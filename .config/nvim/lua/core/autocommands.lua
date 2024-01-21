local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('filetype_vim', { clear = true })

autocmd('FileType', {
  group = 'filetype_vim',
  pattern = { 'vim' },
  command = 'setlocal foldmethod=marker'
})

autocmd('FileType', {
  group = 'filetype_vim',
  pattern = { 'lua' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

autocmd(
  {
    'BufRead',
    'BufNewFile'
  },
  {
    group = 'filetype_vim',
    pattern = 'Vagrantfile,Gemfile,Capfile',
    command = 'set ft=ruby'
  }
)

autocmd('FileType', {
  group = 'filetype_vim',
  pattern = { 'rspec' },
  command = 'set ft=ruby'
})

autocmd('FileType', {
  group = 'filetype_vim',
  pattern = { 'ruby', 'eruby', 'scss', 'javascript', 'coffee', 'yml', 'yaml' },
  command = 'setlocal shiftwidth=2 softtabstop=2 expandtab'
})

autocmd('FileType', {
  group = 'filetype_vim',
  pattern = { 'python' },
  command = 'setlocal shiftwidth=4 softtabstop=4 expandtab autoindent'
})
