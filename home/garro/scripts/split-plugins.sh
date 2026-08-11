#!/usr/bin/env bash

set -euo pipefail

ROOT="${1:-.}"

find "$ROOT" \
    -type f \
    -name '*.nix' \
    -not -name 'default.nix' \
    -print0 |
while IFS= read -r -d '' file; do

    dir="$(dirname "$file")"
    name="$(basename "$file" .nix)"
    output_dir="$dir/$name"

    echo "Processing: $file"

    mkdir -p "$output_dir"

    perl - "$file" "$output_dir" <<'PERL'
use strict;
use warnings;
use File::Spec;

my ($input, $output_dir) = @ARGV;

open my $fh, '<', $input
    or die "Cannot open $input: $!\n";

local $/;
my $text = <$fh>;

close $fh;

#
# Encontrar todos los:
#
#   plugins.foo...
#
# y agruparlos por plugin.
#

my %plugins;

while ($text =~ /(^[ \t]*plugins\.([A-Za-z0-9_-]+)(?:\.[A-Za-z0-9_-]+)?[ \t]*=.*?(?:;|\{))/mg) {

    my $start  = $-[0];
    my $plugin = $2;

    #
    # Buscar el final de la línea de asignación.
    #
    my $line_end = index($text, "\n", $start);

    $line_end = length($text) if $line_end < 0;

    my $line = substr($text, $start, $line_end - $start);

    #
    # Caso simple:
    #
    # plugins.foo.enable = true;
    #
    if ($line =~ /;[ \t]*$/) {

        push @{$plugins{$plugin}}, $line;
        next;
    }

    #
    # Caso:
    #
    # plugins.foo = {
    #
    # Tenemos que encontrar la llave correspondiente.
    #

    my $brace_start = index($text, '{', $start);

    next if $brace_start < 0;

    my $depth = 0;
    my $in_string = 0;
    my $escaped = 0;
    my $end = undef;

    for (my $i = $brace_start; $i < length($text); $i++) {

        my $c = substr($text, $i, 1);

        if ($in_string) {

            if ($escaped) {
                $escaped = 0;
            }
            elsif ($c eq '\\') {
                $escaped = 1;
            }
            elsif ($c eq '"') {
                $in_string = 0;
            }

            next;
        }

        if ($c eq '"') {
            $in_string = 1;
        }
        elsif ($c eq '{') {
            $depth++;
        }
        elsif ($c eq '}') {
            $depth--;

            if ($depth == 0) {
                $end = $i + 1;

                #
                # Incluir ; después del bloque.
                #
                if (
                    $end < length($text) &&
                    substr($text, $end, 1) eq ';'
                ) {
                    $end++;
                }

                last;
            }
        }
    }

    next unless defined $end;

    my $statement = substr($text, $start, $end - $start);

    push @{$plugins{$plugin}}, $statement;
}

#
# Generar archivos.
#

for my $plugin (sort keys %plugins) {

    my $path = File::Spec->catfile(
        $output_dir,
        "$plugin.nix"
    );

    open my $out, '>', $path
        or die "Cannot write $path: $!\n";

    print $out "{ ... }:\n\n";
    print $out "{\n";

    for my $statement (@{$plugins{$plugin}}) {

        #
        # Quitar indentación original.
        #
        $statement =~ s/^[ \t]+//mg;

        #
        # Indentar para el nuevo módulo.
        #
        $statement =~ s/^/  /mg;

        print $out "$statement\n\n";
    }

    print $out "}\n";

    close $out;

    print "  + $path\n";
}

#
# Generar default.nix
#

my $default = File::Spec->catfile(
    $output_dir,
    "default.nix"
);

open my $df, '>', $default
    or die "Cannot write $default: $!\n";

print $df "{ ... }:\n\n";
print $df "{\n";
print $df "  imports = [\n";

for my $plugin (sort keys %plugins) {
    print $df "    ./$plugin.nix\n";
}

print $df "  ];\n";
print $df "}\n";

close $df;

print "  + $default\n";
print "\n";

PERL

done
