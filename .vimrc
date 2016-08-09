filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/hoon.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Essentials
Plugin 'jlanzarotta/bufexplorer'
Plugin 'godlygeek/csapprox'
Plugin 'godlygeek/tabular'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-endwise'
Plugin 'henrik/vim-indexed-search'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-repeat'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mbbill/undotree'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'majutsushi/tagbar'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'EinfachToll/DidYouMean'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'bling/vim-airline'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'airblade/vim-gitgutter'
"Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'Valloric/YouCompleteMe'
Plugin 'easymotion/vim-easymotion'
"Plugin 'Xe/vim-licenses'
"Plugin 'ekalinin/Dockerfile.vim'
Plugin 'docker/docker', {'rtp': '/contrib/syntax/vim/'}
"Plugin 'junegunn/goyo.vim'
"Plugin 'nsf/gocode', {'rtp': 'vim/'}
"Plugin 'Yggdroot/indentLine'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'shougo/unite.vim'
Plugin 'raimondi/delimitmate'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-markdown'
Plugin 'terryma/vim-multiple-cursors'

" Javascript Bundle
Plugin 'jelera/vim-javascript-syntax'

" HTML Bundle
Plugin 'amirh/HTML-AutoCloseTag'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'tpope/vim-haml'
Plugin 'mattn/emmet-vim'

" PHP Bundle
Plugin 'arnaud-lb/vim-php-namespace'

" Aesthetics
Plugin 'chriskempson/base16-vim'
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline-themes'

" More
"Plugin 'vim-ruby/vim-ruby'
"Plugin 'fatih/vim-go'
Plugin 'Lyude/vim-systemd-syntax'
"Plugin 'yosssi/vim-gcss'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'digitaltoad/vim-jade'
"Plugin 'eagletmt/neco-ghc'
"Plugin 'dag/vim2hs'
Plugin 'eagletmt/ghcmod-vim'
"Plugin 'rust-lang/rust.vim'
"Plugin 'yosssi/vim-ace'
"Plugin 'pgdouyon/nimrod.vim'
"Plugin 'chakrit/upstart.vim'
"Plugin 'embear/vim-localvimrc'
"Plugin 'dpwright/vim-tup'
"Plugin 'mattn/go-errcheck-vim'
"Plugin 'm2mdas/phpcomplete-extended'
Plugin 'vimwiki/vimwiki'
"Plugin 'exu/pgsql.vim'
"Plugin 'gilgigilgil/anderson.vim'
"Plugin 'flazz/vim-colorschemes'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-lua-ftplugin'
"Plugin 'rubik/vim-dg'
"Plugin 'elmcast/elm-vim'
"Plugin 'dag/vim-fish'

call vundle#end()

set t_Co=256
set updatetime=250

colorscheme gruvbox

syntax on
filetype plugin indent on

set whichwrap=<,>,[,],b,
set backspace=indent,eol,start
set cursorcolumn
set cursorline
set number
set background=dark
set autoread
set mouse=a
set showcmd             " Show commands on the right as they're being typed

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

""hi CursorColumn term=none cterm=none ctermbg=234
"hi CursorLine term=none cterm=none ctermbg=236

"hi Folded term=none cterm=none ctermbg=232
"hi Comment term=bold cterm=bold ctermfg=green

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" But also have C-like languages use C spacing
" Thanks much jdhore
set ai
au BufRead,BufNewFile *.c,*.cpp,*.cxx,*.hpp,*.c++,*.hh,*.hxx,*.ipp,*.moc,*.tcc,*.inl set cindent
au BufRead,BufNewFile *.c,*.cpp,*.cxx,*.hpp,*.c++,*.hh,*.hxx,*.ipp,*.moc,*.tcc,*.inl set tabstop=8
au BufRead,BufNewFile *.c,*.cpp,*.cxx,*.hpp,*.c++,*.hh,*.hxx,*.ipp,*.moc,*.tcc,*.inl set shiftwidth=8
set cinoptions=>s,e0,n0,f0,{0,}0,^0,=s,ps,t0,c3,+s,(2s,us,)20,*30,gs,hs

" Other language specific hacks
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

" Lolcode is special
au Filetype lolcode setl et ts=4 sw=4

" So is Elixir
au Filetype elixir setl et ts=2 sw=2

" Make Lua have ruby spacing for reading
au Filetype lua setl et ts=2 sw=2

" Erlang!
au Filetype erlang setl et ts=4 sw=4

" Oh nim
au Filetype nim setl et ts=2 sw=2
au BufRead,BufNewFile *.nimble set filetype=nim
au BufRead,BufNewFile *.nims set filetype=nim

" moonscript is cool too
au Filetype moon setl et ts=2 sw=2
au BufWrite moon call s:RunShellCommand('moonc -l')

" Coffeescript is hipster goodness
au Filetype coffee setl et ts=2 sw=2

" Go!
au Filetype go setl noet ts=4 sw=4

" Yaml
au Filetype yaml setl et ts=2 sw=2

" Haskell
au Filetype haskell setlocal omnifunc=necoghc#omnifunc
au Filetype haskell setl et ts=4 sw=4

" Cabal
au Filetype cabal setl et ts=2 sw=2

" Email should wrap at 75 characters to allow for replies on an 80 character
" terminal
au Filetype mail let &colorcolumn="70,75"
au Filetype mail set spell
au Filetype mail setlocal textwidth=75
au Filetype mail set expandtab

" APKBUILD files have spacing like python
au BufRead APKBUILD setl noexpandtab softtabstop=0 tabstop=4 shiftwidth=4 nosmarttab

" fuck you I do what I want
au BufRead,BufNewFile *.tmpl set filetype=gotmplhtml

" Make tabs visible
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

" Default settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set encoding=utf-8

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline,
    "")
    call append(line("$"), l:modeline)
endfunction

command WQ wq
command Wq wq
command W w
command Q q

set wildmenu
set wildignore=*.o,*~,*.pyc

" Delete extra spaces 4 at a time
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Paste macros
" Thanks to jdhore
map <F8> :set paste<CR>
map <F9> :set nopaste<CR>
imap <F8> <C-O>:set paste<CR>
imap <F9> <nop>
set pastetoggle=<F9>
map <F3> gg=G:w<cr>

" status line
set ls=2
set statusline=%F%m%r%h%w\ >\ FORMAT=%{&ff}\ >\ TYPE=%Y\ >\ BUF=\#%n\ <\ POS=%04l,%04v\ <\ %p%%\ <\ LEN=%L

" Color column definition
"let &colorcolumn="80"
highlight ColorColumn ctermbg=58

" resume at line
autocmd BufReadPost *
            \ if ! exists("g:leave_my_cursor_position_alone") |
            \     if line("'\"") > 0 && line ("'\"") <= line("$") |
            \         exe "normal g'\"" |
            \     endif |
            \ endif

" text files at 78 cols
autocmd BufNewFile,BufRead *.txt
            \ if &tw == 0 && ! exists("g:leave_my_textwidth_alone") |
            \     setlocal textwidth=78 |
            \ endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" PhpComplete
let g:phpcomplete_index_composer_command = 'composer'

" Gist
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_show_privates = 1
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

" Airline
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

" Macvim
set guioptions-=r

" Leader
let mapleader = " "
let g:mapleader = " "

" Highlight a line to read over later
nnoremap <silent> <leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
nmap <leader>w :w!<cr>
nmap <leader>d :call DeleteTrailingWS()<cr>
nmap <leader>rt :retab<cr>
nmap <leader>g :Gist<cr>
nnoremap <silent> <leader>ml :call AppendModeline()<CR>
nmap <leader>sp gg=G:w<cr>
nnoremap <leader>c :Goyo<CR>
nmap <leader>gf :%!gofmt<CR>

" Spellchecking
map <leader>ss :setlocal spell!<cr>

" License
let g:licenses_authors_name = 'Christine Dodrill <xena@yolo-swag.com>'

" Goyo
function! Goyo_before()
  silent !tmux set status off
  set noshowmode
  set noshowcmd
  " ...
endfunction

function! Goyo_after()
  silent !tmux set status on
  set showmode
  set showcmd
  " ...
endfunction

let g:goyo_callbacks = [function('Goyo_before'), function('Goyo_after')]

" Use current directory as vimshell prompt.
let g:vimshell_prompt_expr =
	\ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '

let g:ycm_semantic_triggers = {'haskell' : ['.']}

let g:go_fmt_command = "goimports"

let g:localvimrc_whitelist = '/home/xena/(go/src/(git.xeserv.us/.*|github.com/Xe/.*)|.ghq/(github.com/Xe/.*|git.xeserv.us/.*))'
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 2

" https://www.youtube.com/watch?v=iTfcCfCB90E
let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'brown', 'darkblue', 'darkgray', 'darkgreen', 'darkred', 'darkmagenta', 'darkred'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

let g:vimwiki_list = [{'path': '~/life/vimwiki/'}]

function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
map <Leader>x :call RangerExplorer()<CR>
