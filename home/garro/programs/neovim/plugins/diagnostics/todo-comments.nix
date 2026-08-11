{ ... }:

{
  plugins.todo-comments = {
    enable = true;

    settings = {
      signs = true;

      highlight = {
        multiline = true;
      };

      search = {
        pattern = ''\b(KEYWORDS)\b'';
      };
    };
  };
}
