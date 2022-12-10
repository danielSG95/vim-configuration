set number
set background=dark
set tags=./tags,tags;$HOME
set laststatus=2
set clipboard=unnamedplus
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"
set ignorecase
set hlsearch
set showmatch
set incsearch
set cc=90
set ttyfast
set cursorline
set wrap
set tw=90


filetype plugin on
" Make space more useful 
nnoremap <space> za
set encoding=UTF-8
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


call plug#begin()
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
" themes 
Plug 'glepnir/oceanic-material'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jacoborus/tender.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'NLKNguyen/papercolor-theme'
" typescript highlight
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
"Fugitive
Plug 'tpope/vim-fugitive'
"Lens
Plug 'camspiers/lens.vim'

call plug#end()

"Themes configuration here
syntax enable
set termguicolors     " enable true colors support
"colorscheme Papercolor
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight
colorscheme dracula
"let g:airline_theme = "tokyonight"
"let g:lightline = {'colorscheme' : 'tokyonight'}
"let g:tokyonight_menu_selection_background = 'red' 
"let g:tokyonight_current_word= 'italic'


hi CocMenuSel ctermbg=109 guibg=#13354A


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"coc-prettier configuration
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

let mapleader = ","
map <C-p> :Files ./<cr>
map - ddp
map = ddP
map <C-n> :Prettier<CR>
nmap ,n :NERDTreeFind<CR>
nmap ,m :NERDTreeToggle<CR>
" add mapping for auto closing
inoremap "<space> ""<Left>
inoremap '<space> ''<Left>
inoremap `<space> ``<Left>
inoremap (<space> ()<Left>
inoremap [<space> []<Left>
inoremap {<space> {}<Left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap jk <Esc>l
inoremap $<space> ${ }<left>



"split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>. viw<esc>a"<esc>bi"<esc>lel
nnoremap H _
nnoremap L $
nnoremap <leader><space>q 1gt
nnoremap <leader><space>w 2gt
nnoremap <leader><space>e 3gt
nnoremap <leader><space>r 4gt
nnoremap <leader><space>t 5gt
nnoremap <space>w :w<cr>
nnoremap <space>a :wa<cr>
nnoremap <leader><space>so :source %<cr>
nnoremap <space>q :q<cr>
nnoremap d dd
nnoremap <leader>vs :vsplit<cr>
nnoremap op "0p
nnoremap pp O<esc>p
