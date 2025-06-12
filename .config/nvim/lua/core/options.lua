local g = vim.g
local cmd = vim.cmd

-- Русский язык
cmd("set keymap=russian-jcukenwin")
cmd("set iminsert=0")
cmd("set imsearch=0")

g.mapleader = ','

local options = {
  number = true,                                       -- print the line number in front of each line
  endofline = false,                                  -- fixes git No newline at end of file
  binary = true,                                       -- fixes git No newline at end of file
  relativenumber = true,                               -- show relative line number in front of each line
  history = 500,                                       -- number of command-lines that are remembered
  backspace = { 'eol', 'start', 'indent' },            -- how backspace works at start of line
  listchars = { tab = '->', trail = '-', nbsp = '%' }, -- characters for displaying in list mode
  cursorline = true,                                   -- highlight the screen line of the cursor
  list = true,                                         -- show <Tab> and <EOL>
  wildmenu = true,                                     -- use menu for command line completion
  visualbell = true,                                   -- use visual bell instead of beeping
  lazyredraw = false,                                  -- don't redraw while executing macros
  cmdheight = 2,                                       -- number of lines to use for the command-line
  hidden = true,                                       -- don't unload buffer when it is abandoned
  foldenable = false,                                  -- set to display all folds open
  hlsearch = true,                                     -- highlight matches with last search pattern
  ignorecase = true,                                   -- ignore case in search patterns
  smartcase = true,                                    -- no ignore case when pattern has uppercase
  backup = false,                                      -- keep backup file after overwriting a file
  backupcopy = 'yes',                                  -- make backup as a copy, don't rename the file
  swapfile = false,                                    -- whether to use a swapfile for a buffer
  tabstop = 2,                                         -- number of spaces that <Tab> in file uses
  expandtab = true,                                    -- use spaces when <Tab> is inserted
  shiftwidth = 2,                                      -- number of spaces to use for (auto)indent step
  softtabstop = 2,                                     -- number of spaces that <Tab> uses while editing
  tags = 'tags',                                       -- list of file names used by the tag command
  termguicolors = true,                                -- user terminal colors
  conceallevel = 2
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
