local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
  vim.notify("Failed to load tokyonight")
  vim.cmd[[colorscheme default]]
end

tokyonight.setup({
  style = "moon"
})
vim.cmd[[colorscheme tokyonight]]
