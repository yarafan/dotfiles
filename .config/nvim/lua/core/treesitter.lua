local opt = vim.opt
local treesitter_ok, configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
  return
end

local rainbow_ok, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if not rainbow_ok then
  return
end

local languages = {
  "bash",
  "c",
  "dockerfile",
  "erlang",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "html",
  "http",
  "ini",
  "javascript",
  "json",
  "jq",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "objdump",
  "proto",
  "python",
  "regex",
  "ruby",
  "rust",
  "sql",
  "terraform",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}


opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

require("rainbow-delimiters.setup").setup {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
  },
  priority = {
    [''] = 110,
    lua = 210,
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}

configs.setup {
  ensure_installed = languages,
  ignore_install = { "" },
  sync_install = false,

  highlight = {
    enable = true,
    disable = { "" },
  },

  indent = { enable = true, disable = { "yaml" } }, -- experimental

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
