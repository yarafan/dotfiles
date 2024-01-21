local ok, lint = pcall(require, "lint")
if not ok then
  return
end

local linters_by_ft = {
  go = { "golangcilint" },
  ruby = { "rubocop" }
}

lint.linters_by_ft = linters_by_ft

vim.api.nvim_create_autocmd(
  {
    "BufWritePost",
    "InsertLeave"
  },
  {
    callback = function()
      lint.try_lint()
    end,
  }
)
