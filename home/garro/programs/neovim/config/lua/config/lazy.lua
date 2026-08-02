local ok, lazy = pcall(require, "lazy")

if not ok then
  vim.notify("lazy.nvim is not available on runtimepath", vim.log.levels.WARN)
  return
end

local nix_plugin_root = vim.fn.stdpath("data") .. "/nix-plugins"

lazy.setup({
  spec = {
    { import = "lazyvim.plugins" },
    { import = "plugins" },
    { "folke/lazy.nvim", dir = nix_plugin_root .. "/lazy.nvim" },
    { "LazyVim/LazyVim", dir = nix_plugin_root .. "/LazyVim" },
    { "saghen/blink.cmp", dir = nix_plugin_root .. "/blink.cmp" },
    { "akinsho/bufferline.nvim", dir = nix_plugin_root .. "/bufferline.nvim" },
    { "catppuccin/nvim", dir = nix_plugin_root .. "/catppuccin", name = "catppuccin" },
    { "folke/flash.nvim", dir = nix_plugin_root .. "/flash.nvim" },
    { "rafamadriz/friendly-snippets", dir = nix_plugin_root .. "/friendly-snippets" },
    { "lewis6991/gitsigns.nvim", dir = nix_plugin_root .. "/gitsigns.nvim" },
    { "MagicDuck/grug-far.nvim", dir = nix_plugin_root .. "/grug-far.nvim" },
    { "folke/lazydev.nvim", dir = nix_plugin_root .. "/lazydev.nvim" },
    { "nvim-lualine/lualine.nvim", dir = nix_plugin_root .. "/lualine.nvim" },
    { "nvim-mini/mini.ai", dir = nix_plugin_root .. "/mini.ai" },
    { "nvim-mini/mini.icons", dir = nix_plugin_root .. "/mini.icons" },
    { "nvim-mini/mini.pairs", dir = nix_plugin_root .. "/mini.pairs" },
    { "folke/noice.nvim", dir = nix_plugin_root .. "/noice.nvim" },
    { "MunifTanjim/nui.nvim", dir = nix_plugin_root .. "/nui.nvim" },
    { "rcarriga/nvim-notify", dir = nix_plugin_root .. "/nvim-notify" },
    { "windwp/nvim-ts-autotag", dir = nix_plugin_root .. "/nvim-ts-autotag" },
    { "nvim-treesitter/nvim-treesitter-textobjects", dir = nix_plugin_root .. "/nvim-treesitter-textobjects" },
    { "folke/persistence.nvim", dir = nix_plugin_root .. "/persistence.nvim" },
    { "nvim-lua/plenary.nvim", dir = nix_plugin_root .. "/plenary.nvim" },
    { "folke/snacks.nvim", dir = nix_plugin_root .. "/snacks.nvim" },
    { "folke/todo-comments.nvim", dir = nix_plugin_root .. "/todo-comments.nvim" },
    { "folke/tokyonight.nvim", dir = nix_plugin_root .. "/tokyonight.nvim" },
    { "folke/trouble.nvim", dir = nix_plugin_root .. "/trouble.nvim" },
    { "folke/ts-comments.nvim", dir = nix_plugin_root .. "/ts-comments.nvim" },
    { "folke/which-key.nvim", dir = nix_plugin_root .. "/which-key.nvim" },
    { "neovim/nvim-lspconfig", dir = nix_plugin_root .. "/nvim-lspconfig" },
    { "stevearc/conform.nvim", dir = nix_plugin_root .. "/conform.nvim" },
    { "mfussenegger/nvim-lint", dir = nix_plugin_root .. "/nvim-lint" },
    { "nvim-treesitter/nvim-treesitter", dir = nix_plugin_root .. "/nvim-treesitter" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    missing = false,
  },
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = false,
  },
})

vim.g.trouble_lualine = false
