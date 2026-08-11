{ ... }:

{
  plugins.lint = {
    enable = true;

    lintersByFt = {
      javascript = [ "eslint_d" ];
      typescript = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];

      python = [ "ruff" ];

      markdown = [ "markdownlint" ];
    };

    autoCmd = {
      event = [
        "BufWritePost"
        "BufEnter"
        "InsertLeave"
      ];
    };
  };
}
