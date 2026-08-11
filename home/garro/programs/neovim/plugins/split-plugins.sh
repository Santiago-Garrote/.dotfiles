#!/usr/bin/env bash

set -euo pipefail

ROOT="${1:-.}"

find "$ROOT" -type f -name '*.nix' -print0 |
while IFS= read -r -d '' file; do

    # No procesar archivos que ya fueron generados
    [[ "$(basename "$file")" == "default.nix" ]] && continue

    dir="$(dirname "$file")"
    name="$(basename "$file" .nix)"

    echo "Processing: $file"

    # Crear directorio donde van a vivir los plugins.
    output_dir="$dir/$name"
    mkdir -p "$output_dir"

    # Extraer cada plugin.
    awk -v output_dir="$output_dir" '
    function matching_brace(text, start,    i,c,depth,in_string,escaped) {
        depth = 0
        in_string = 0
        escaped = 0

        for (i = start; i <= length(text); i++) {
            c = substr(text, i, 1)

            if (in_string) {
                if (escaped) {
                    escaped = 0
                } else if (c == "\\") {
                    escaped = 1
                } else if (c == "\"") {
                    in_string = 0
                }
                continue
            }

            if (c == "\"") {
                in_string = 1
            } else if (c == "{") {
                depth++
            } else if (c == "}") {
                depth--

                if (depth == 0)
                    return i
            }
        }

        return -1
    }

    {
        line = $0

        # plugins.<name>
        if (match(line, /plugins\.[A-Za-z0-9_-]+/)) {

            plugin = substr(
                line,
                RSTART + 8,
                RLENGTH - 8
            )

            # Evitar capturar plugins.foo.settings como otro plugin.
            if (plugin in seen)
                next

            seen[plugin] = 1

            # Buscar comienzo real de la línea.
            sub(/^[[:space:]]*/, "", line)

            #
            # Caso:
            #
            # plugins.foo.enable = true;
            #
            if (line ~ /^plugins\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+[[:space:]]*=/) {

                file = output_dir "/" plugin ".nix"

                print "{ ... }:" > file
                print "" >> file
                print "{" >> file
                print "  " line >> file
                print "}" >> file

                close(file)

                print "  + " file
            }

            #
            # Caso:
            #
            # plugins.foo = {
            #   ...
            # };
            #
            else if (line ~ /^plugins\.[A-Za-z0-9_-]+[[:space:]]*=[[:space:]]*{/) {

                file = output_dir "/" plugin ".nix"

                print "{ ... }:" > file
                print "" >> file
                print "{" >> file

                print "  " line >> file

                active = plugin
                active_file = file

                # Contar llaves de esta línea.
                opens = gsub(/{/, "{", line)
                closes = gsub(/}/, "}", line)

                depth = opens - closes

                close(file)

                if (depth <= 0)
                    active = ""
            }

            next
        }

        #
        # Continuación de un bloque activo.
        #
        if (active != "") {

            file = active_file

            print "  " line >> file

            opens = gsub(/{/, "{", line)
            closes = gsub(/}/, "}", line)

            depth += opens - closes

            if (depth <= 0) {

                print "}" >> file
                close(file)

                print "  + " file

                active = ""
                active_file = ""
                depth = 0
            }

            next
        }
    }
    ' "$file"

    #
    # Crear default.nix
    #
    default="$dir/default.nix"

    {
        echo "{ ... }:"
        echo
        echo "{"
        echo "  imports = ["

        for plugin in "$output_dir"/*.nix; do
            [[ -e "$plugin" ]] || continue

            plugin_name="$(basename "$plugin")"

            echo "    ./$name/$plugin_name"
        done

        echo "  ];"
        echo "}"
    } > "$default"

    echo "  + $default"
    echo
done
