{ ... }:

{
  autoCmd = [
    {
      event = [ "BufReadPost" ];
      callback = {
        __raw = ''
          function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
              vim.cmd('normal! g`"')
            end
          end
        '';
      };
      desc = "Restore cursor position";
    }

    {
      event = [ "BufWritePre" ];
      pattern = [ "*" ];
      callback = {
        __raw = ''
          function()
            local view = vim.fn.winsaveview()
            vim.cmd([[%s/\s\+$//e]])
            vim.fn.winrestview(view)
          end
        '';
      };
      desc = "Remove trailing whitespace";
    }

    {
      event = [ "FileType" ];
      pattern = [
        "help"
        "man"
        "qf"
        "lspinfo"
        "checkhealth"
      ];
      callback = {
        __raw = ''
          function()
            vim.bo.buflisted = false
          end
        '';
      };
      desc = "Hide utility buffers from buffer list";
    }

    {
      event = [ "TextYankPost" ];
      callback = {
        __raw = ''
          function()
            vim.highlight.on_yank({ timeout = 150 })
          end
        '';
      };
      desc = "Highlight yanked text";
    }
  ];
}
