" remove backspace in abbrev
func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc
" Vim Settings ---------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au BufRead,BufNewFile {Vagrantfile,Gemfile,Capfile} set ft=ruby
    au FileType rspec set ft=ruby
    au FileType ruby,eruby,scss setl sw=2 sts=2 et
    au FileType python setl sw=4 sts=4 et autoindent
    au FileType javascript,coffee setl sw=2 sts=2 et
    au FileType yml,yaml setl sw=2 sts=2 et

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
colorscheme gruvbox
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set tags=tags
" }}}
" Syntax highlighting--- {{{
let g:used_javascript_libs = 'jquery,underscore,react,chai,requirejs'
let g:polyglot_disabled = ['javascript', 'go']
" }}}
" Vim-plug ------------- {{{
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'elzr/vim-json'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'csscomb/vim-csscomb'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'chrisbra/unicode.vim'
Plug 'embear/vim-localvimrc'
Plug 'vim-scripts/dbext.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
" }}}
" CTRLP--- {{{
let g:ctrlp_arg_map = 1
" }}}
" ALE --- {{{
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters = { 'python': ['pylint'], 'javascript': ['flow', 'eslint'] }
let g:ale_fixers = { 'ruby': ['rubocop'],  'css': ['prettier'], 'python': ['pylint'], 'javascript': ['prettier', 'eslint'] }
let g:ale_fix_on_save = 1
" }}}

" Lvimrc --- {{{
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
" }}}
let g:omni_sql_no_default_maps = 1
" Rsense --- {{{
let g:rsenseHome = expand("~/rsense/rsense-0.3")
let g:rsenseUseOmniFunc = 1
" }}}
" Statusline ---- {{{
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
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
vmap <leader>y "+y
vmap <leader>p "+p
nmap <leader>p "+p
imap <F6> <Esc>"+pa
noremap ,hl :set hlsearch! hlsearch?<CR>
noremap <leader>q :q!<cr>
noremap <leader>s :w<cr>
noremap <C-m> <S-o><C-c>
" }}}
" Abbreviations -------- {{{
" some abbrevs
iab bpr binding.pry<C-R>=Eatchar('\s')<CR><C-C>
iab bbg byebug<C-R>=Eatchar('\s')<CR><C-C>
" }}}
"

let g:go_def_mapping_enabled = 0
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" " Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>fq  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
