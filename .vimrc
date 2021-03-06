" Vim Settings ---------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au BufRead,BufNewFile {Vagrantfile,Gemfile,Capfile} set ft=ruby
    au FileType ruby,eruby,scss setl sw=2 sts=2 et
    au FileType yaml,eruby.yaml setlocal commentstring=#\ %s
    au FileType javascript,coffee setl sw=2 sts=2 et
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
set backupcopy=yes
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
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'elzr/vim-json'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'mattn/emmet-vim'
Plugin 'majutsushi/tagbar'
Plugin 'sheerun/vim-polyglot'
Plugin 'csscomb/vim-csscomb'
Plugin 'othree/yajs.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/es.next.syntax.vim'

call vundle#end()

filetype on
filetype plugin indent on
" }}}
" CTRLP--- {{{
let g:ctrlp_arg_map = 1
" }}}
" ALE --- {{{
let g:ale_ruby_rubocop_executable = 'bundle'
" }}}
" Syntax highlighting--- {{{
let g:used_javascript_libs = 'jquery,underscore,react,chai,requirejs'
let g:polyglot_disabled = ['javascript']
" }}}
" Rsense --- {{{
let g:rsenseHome = expand("~/rsense/rsense-0.3")
let g:rsenseUseOmniFunc = 1
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
iab clg console.log()<Left><C-R>=Eatchar('\s')<CR>
" }}}
