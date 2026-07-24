local ok, lazy = pcall(require, "lazy")

if not ok then
  vim.notify("lazy.nvim is not available on runtimepath", vim.log.levels.WARN)
  return
end

lazy.setup({
  spec = {
    { import = "lazyvim.plugins" },
    { import = "plugins" },
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
