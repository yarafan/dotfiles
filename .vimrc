" Vim Settings ---------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au BufRead,BufNewFile {Vagrantfile,Gemfile,Capfile} set ft=ruby
    au FileType ruby,eruby,scss setl sw=2 sts=2 et
    au FileType javascript,coffee setl sw=4 sts=4 et
    au FileType yaml setl sw=2 sts=2 et
augroup END
set nocompatible
syntax on
let mapleader=','
set history=500
set backspace=eol,start,indent
set listchars=tab:->,trail:-,nbsp:%
set list
set wildmenu
set visualbell
set lazyredraw
set cmdheight=2
set cursorline
set hidden
set nofoldenable
set number
set hlsearch
set ignorecase
set smartcase
set nobackup
set noswapfile
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set t_Co=256
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
colorscheme jellybeans
" }}}
" Vundle ------------- {{{
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'elzr/vim-json'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'sheerun/vim-polyglot'
Plugin 'csscomb/vim-csscomb'

call vundle#end()

filetype on
filetype plugin indent on
" }}}
" Rsense --- {{{
let g:rsenseHome = expand("~/rsense/rsense-0.3")
let g:rsenseUseOmniFunc = 1
" }}}
" Syntastic ------- {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exec = '~/projects/js/market-api/node_modules/.bin/eslint'
let g:syntastic_haml_checkers = ['haml_lint', 'haml']
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_scss_checkers= ['scss_lint']
" let g:syntastic_erlang_checkers = ['syntaxerl', 'escript']
" let g:syntastic_php_checkers=['phpcs', 'php']
" let g:syntastic_php_phpcs_exec='~/.composer/vendor/bin/phpcs'
" let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
" }}}
" Statusline ---- {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}}
" NERDTree -------------{{{
nmap <C-\> :NERDTreeFind<CR>
nmap <silent> <leader><leader> :NERDTreeToggle<CR>
" }}}
" Tagbar ----- {{{
nnoremap <silent> <leader>t :TagbarToggle<CR>
" }}}
" Custom mappings ---- {{{
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>va :source $MYVIMRC<cr>
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>
" sudo save
cmap w!! %!sudo tee > /dev/null %
vmap <F5> "+y
vmap <F6> "+p
nmap <F6> "+p
imap <F6> <Esc>"+pa
noremap ,hl :set hlsearch! hlsearch?<CR>
noremap <leader>q :q!<cr>
noremap <leader>s :w<cr>
noremap <C-m> <S-o><C-c>
" }}}
" Abbreviations -------- {{{
" remove backspace in abbrev
func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc
" some abbrevs
iab vdp var_dump(); die('1');<esc><s-b><s-b>f'a<C-R>=Eatchar('\s')<CR>
iab clg console.log();<Left><Left><C-R>=Eatchar('\s')<CR>
" }}}
"
"" FOR ESLINT SYNTASTIC EXEC
fun! s:GetNodeModulesAbsPath ()
  let lcd_saved = fnameescape(getcwd())
  silent! exec "lcd" expand('%:p:h')
  let path = finddir('node_modules', '.;')
  exec "lcd" lcd_saved
  return path is '' ? '' : fnamemodify(path, ':p')
endfun
fun! s:GetEslintExec (node_modules)
  let eslint_guess = a:node_modules is '' ? '' : a:node_modules . '.bin/eslint'
  return exepath(eslint_guess)
endfun
fun! s:LetEslintExec (eslint_exec)
  if a:eslint_exec isnot ''
    let g:syntastic_javascript_eslint_exec = a:eslint_exec
  endif
endfun

fun! s:main ()
  let node_modules = s:GetNodeModulesAbsPath()
  let eslint_exec = s:GetEslintExec(node_modules)
  call s:LetEslintExec(eslint_exec)
endfun

call s:main()
"" FOR ESLINT SYNTASTIC EXEC
