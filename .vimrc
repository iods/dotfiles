" Base settings -----------------------------------------------------------------------------------
set nocompatible           " use Vim settings, rather then Vi settings
syntax on                  " turn on syntax highlighting (this will turn 'filetype on' by default)
filetype plugin indent on  " turn on file type detection
set hidden                 " the current buffer can be put to the background without writing it on disk
set nobackup               " do not create backup files
set noswapfile             " do not create swap files
set autowrite              " write the contents of the file on next, previous, make, etc commands
set exrc                   " allows loading local executing rc files
set secure                 " disallows the use of :autocmd, shell and write commands in local rc files

" text and indentaion
set nowrap                 " do not wrap long lines
set textwidth=0            " disable break long lines while editing
set fo-=t                  " disable automatic text wrapping
set autoindent             " copy indent from current line when starting a new line
set tabstop=4              " number of spaces that a <Tab> in the file counts for
set shiftwidth=4           " number of spaces to use for each step of (auto)indent
set softtabstop=4          " number of spaces that a <Tab> counts for while performing
set smarttab               " use different amount of spaces in a front of line or in other places
                           " according to 'tabstop', 'softtabstop' and 'shiftwidth' settings
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set encoding=utf-8              " sets the character encoding used inside Vim
set fileencodings=utf8     " list of character encodings considered
                           " when starting to edit an existing file

" UI
set showcmd                " show (partial) command in the last line of the screen
set wildmenu               " turn on wildmenu (enhanced mode of command-line completion)
set wcm=<Tab>              " wildmenu navigation key
set laststatus=2           " always show the status line
set incsearch              " jump to search results while typing a search command
set lazyredraw             " redraw only when we need to
set nonumber               " do not show line numbers
set nocursorline           " do not highlight the screen line of the cursor
set nofoldenable           " turn off folding
set scrolloff=3            " minimal number of screen lines to keep above and below the cursor
set splitright             " how to split new windows
set winminheight=0         " non-current windows may collapse to a status line and nothing else
set equalalways            " makes sure Vim try to make all windows equal
set fillchars=vert:\ ,fold:·  " characters for fill statuslines and vertical separators
set background=light       " Vim will try to use colors that look good on a light background

" invisible characters
set nolist                 " do not display unprintable characters by default
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:¬  " invisible symbols representation

" list of ignored in expanding wildcards files
set wildignore+=.git,*.o,*.pyc,__pycache__,.DS_Store

"if &term =~ '256color'
"	" disable Background Color Erase (BCE) so that color schemes
"	" render properly when inside 256-color tmux and GNU screen.
"	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
"	set t_ut=
"endif








" Make vim more useful
set nocompatible

" Set syntax highlighting options.
set t_Co=256
set background=dark
syntax on
colorscheme badwolf

" Enabled later, after Pathogen
filetype off

" Change mapleader
let mapleader=","

" Local dirs
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Set some junk
set autoindent " Copy indent from last line when starting new line.
set backspace=indent,eol,start
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set encoding=utf-8 nobomb " BOM often causes trouble
set esckeys " Allow cursor keys in insert mode.
set expandtab " Expand tabs to spaces
set foldcolumn=4 " Column to show folds
set foldenable
set foldlevel=2
" set foldlevelstart=2 " Sets `foldlevel` when editing a new buffer
set foldmethod=syntax " Markers are used to specify folds.
set foldminlines=0 " Allow folding single lines
set foldnestmax=3 " Set max fold nesting level
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set gdefault " By default add g flag to search/replace. Add g to toggle.
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches.
set incsearch " Highlight dynamically as pattern is typed.
set laststatus=2 " Always show status line
set lispwords+=defroutes " Compojure
set lispwords+=defpartial,defpage " Noir core
set lispwords+=defaction,deffilter,defview,defsection " Ciste core
set lispwords+=describe,it " Speclj TDD/BDD
set magic " Enable extended regexes.
set mouse=a " Enable moouse in all in all modes.
set noerrorbells " Disable error bells.
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.
set nostartofline " Don't reset cursor to start of line when moving around.
set nowrap " Do not wrap lines.
set nu " Enable line numbers.
set ofu=syntaxcomplete#Complete " Set omni-completion method.
set report=0 " Show all changes.
set ruler " Show the cursor position
set scrolloff=3 " Start scrolling three lines before horizontal border of window.
set shiftwidth=2 " The # of spaces for indenting.
set shortmess=atI " Don't show the intro message when starting vim.
set showmode " Show the current mode.
set showtabline=2 " Always show tab bar.
set sidescrolloff=3 " Start scrolling three columns before vertical border of window.
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters.
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set softtabstop=2 " Tab key results in 2 spaces
set splitbelow " New window goes below
set splitright " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set title " Show the filename in the window titlebar.
set ttyfast " Send more characters at a given time.
set ttymouse=xterm " Set mouse type to xterm.
set undofile " Persistent Undo.
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*
set wildmenu " Hitting TAB in command mode will show possible completions above command line.
set wildmode=list:longest " Complete only until point of ambiguity.
set winminheight=0 "Allow splits to be reduced to a single line.
set wrapscan " Searches wrap around end of file

" Status Line
" hi User1 guibg=#455354 guifg=fg      ctermbg=238 ctermfg=fg  gui=bold,underline cterm=bold,underline term=bold,underline
" hi User2 guibg=#455354 guifg=#CC4329 ctermbg=238 ctermfg=196 gui=bold           cterm=bold           term=bold
" set statusline=[%n]\ %1*%<%.99t%*\ %2*%h%w%m%r%*%y[%{&ff}→%{strlen(&fenc)?&fenc:'No\ Encoding'}]%=%-16(\ L%l,C%c\ %)%P
let g:Powerline_symbols = 'fancy'

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Faster split resizing (+,-)
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Sudo write (,W)
noremap <leader>W :w !sudo tee %<CR>

" Remap :W to :w
command W w

" Better mark jumping (line + col)
nnoremap ' `

" Hard to type things
imap >> →
imap << ←
imap ^^ ↑
imap VV ↓
imap aa λ

" Toggle show tabs and trailing spaces (,c)
set lcs=tab:›\ ,trail:·,eol:¬,nbsp:_
set fcs=fold:-
nnoremap <silent> <leader>c :set nolist!<CR>

" Clear last search (,qs)
map <silent> <leader>qs <Esc>:noh<CR>
" map <silent> <leader>qs <Esc>:let @/ = ""<CR>

" Vim on the iPad
if &term == "xterm-ipad"
  nnoremap <Tab> <Esc>
  vnoremap <Tab> <Esc>gV
  onoremap <Tab> <Esc>
  inoremap <Tab> <Esc>`^
  inoremap <Leader><Tab> <Tab>
endif

" Remap keys for auto-completion, disable arrow keys
" I still need these cuz im nub. so nub.
" inoremap <expr>  <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr>  <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <expr>  <Down>     pumvisible() ? "\<C-n>" : "\<NOP>"
" inoremap <expr>  <Up>       pumvisible() ? "\<C-p>" : "\<NOP>"
" inoremap <Left>  <NOP>
" inoremap <Right> <NOP>

" Indent/unident block (,]) (,[)
nnoremap <leader>] >i{<CR>
nnoremap <leader>[ <i{<CR>

" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" NERD Commenter
let NERDSpaceDelims=1
let NERDCompactSexyComs=1
let g:NERDCustomDelimiters = { 'racket': { 'left': ';', 'leftAlt': '#|', 'rightAlt': '|#' } }

" Buffer navigation (,,) (,]) (,[) (,ls)
map <Leader>, <C-^>
" :map <Leader>] :bnext<CR>
" :map <Leader>[ :bprev<CR>
map <Leader>ls :buffers<CR>

" Close Quickfix window (,qq)
map <leader>qq :cclose<CR>

" Yank from cursor to end of line
nnoremap Y y$

" Insert newline
map <leader><Enter> o<ESC>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" Strip trailing whitespace (,ss)
function! StripWhitespace ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace ()<CR>

" Save and restore folds
" :au BufWinLeave * mkview
" :au BufWinEnter * silent loadview

" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Toggle folds (<Space>)
nnoremap <silent> <space> :exe 'silent! normal! '.((foldclosed('.')>0)? 'zMzx' : 'zc')<CR>

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Set relative line numbers
set relativenumber " Use relative line numbers. Current line is still in status bar.
au BufReadPost,BufNewFile * set relativenumber

" Emulate bundles, allow plugins to live independantly. Easier to manage.
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" JSON
au BufRead,BufNewFile *.json set ft=json syntax=javascript

" Jade
au BufRead,BufNewFile *.jade set ft=jade syntax=jade

" Common Ruby files
au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

" Nu
au BufNewFile,BufRead *.nu,*.nujson,Nukefile setf nu

" Coffee Folding
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" ZSH
au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh

" CtrlP
let g:ctrlp_match_window_bottom = 0 " Show at top of window
let g:ctrlp_working_path_mode = 2 " Smart path mode
let g:ctrlp_mru_files = 1 " Enable Most Recently Used files feature
let g:ctrlp_jump_to_buffer = 2 " Jump to tab AND buffer if already open
let g:ctrlp_split_window = 1 " <CR> = New Tab

" Clojure.vim
let g:vimclojure#ParenRainbow = 1 " Enable rainbow parens
let g:vimclojure#DynamicHighlighting = 1 " Dynamic highlighting
let g:vimclojure#FuzzyIndent = 1 " Names beginning in 'def' or 'with' to be indented as if they were included in the 'lispwords' option

" Rainbow Parenthesis
nnoremap <leader>rp :RainbowParenthesesToggle<CR>





colors ir_black

" some common helpful settings "
set nomodeline
set nocompatible
set history=50
set wildmode=list:longest,full
set notitle
set number
set showmode
set showcmd
set ruler
" set ls=2
set incsearch
set ignorecase
set smartcase
set gdefault

set tabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent

set dictionary=/usr/share/dict/words
map <F7> :set complete+=k<CR>
map <S-F7> :set complete-=k<CR>


if &term == "xterm-color"
  fixdel
endif

set bg=dark

"stop recording accidentally"
nmap q :

" normally don't automatically format `text' as it is typed, IE only do this "
" with comments, at 79 characters: "
set formatoptions-=t
set textwidth=0

filetype on
autocmd!

" in human-language files, automatically format everything at 72 chars: "
autocmd FileType mail,human set formatoptions+=t textwidth=72
autocmd FileType c,cpp,slang,java set cindent
autocmd FileType c set formatoptions+=ro
autocmd FileType perl,css set smartindent
autocmd FileType html set formatoptions+=tl
autocmd FileType html,css set noexpandtab tabstop=4
autocmd FileType make set noexpandtab shiftwidth=4
autocmd FileType sh set shiftwidth=4 tabstop=4

" when using list, keep tabs at their full width and display 'arrows': "
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)

" php helpfuls
" let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

" Correct indentation after opening a phpdocblock and automatic * on every line "
set formatoptions=qroct

" Wrap visual selections with chars "
:vnoremap ( "zdi^V(<C-R>z)<ESC>
:vnoremap { "zdi^V{<C-R>z}<ESC>
:vnoremap [ "zdi^V[<C-R>z]<ESC>
:vnoremap ' "zdi'<C-R>z'<ESC>
:vnoremap " "zdi^V"<C-R>z^V"<ESC>

" Detect filetypes "
"if exists("did_load_filetypes") "
"    finish "
"endif "
augroup filetypedetect
    au! BufRead,BufNewFile *.pp     setfiletype puppet
    au! BufRead,BufNewFile *httpd*.conf     setfiletype apache
    au! BufRead,BufNewFile *inc     setfiletype php
augroup END

" Nick wrote: Uncomment these lines to do syntax checking when you save "
augroup Programming
" clear auto commands for this group "
autocmd!
autocmd BufWritePost *.php !php -d display_errors=on -l <afile>
autocmd BufWritePost *.inc !php -d display_errors=on -l <afile>
autocmd BufWritePost *httpd*.conf !/etc/rc.d/init.d/httpd configtest
autocmd BufWritePost *.bash !bash -n <afile>
autocmd BufWritePost *.sh !bash -n <afile>
autocmd BufWritePost *.pl !perl -c <afile>
autocmd BufWritePost *.perl !perl -c <afile>
autocmd BufWritePost *.xml !xmllint --noout <afile>
autocmd BufWritePost *.xsl !xmllint --noout <afile>
autocmd BufWritePost *.js !~/jslint/jsl -conf ~/jslint/jsl.default.conf -nologo -nosummary -process <afile>
autocmd BufWritePost *.rb !ruby -c <afile>
autocmd BufWritePost *.pp !puppet --parseonly <afile>
augroup en

" Correct indentation after opening a phpdocblock and automatic * on every line"
set formatoptions=qroct

" * Keystrokes -- Formatting "
" have Q reformat the current paragraph (or selected text if there is any): "
nnoremap Q gqap
vnoremap Q gq
" have the usual indentation keystrokes still work in visual mode: "
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>
" have Y behave analogously to D and C rather than to dd and cc "
noremap Y y$

" * Keystrokes -- Insert Mode "
" allow <BkSpc> to delete line breaks, beyond the start of the current insertion, and over indentations: "
set backspace=eol,start,indent
" have <Tab> (and <Shift>+<Tab> where it works) change the level of indentation: "
" inoremap <Tab> <C-T>
" inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.] "


" abbreviations / spelling errors "
abbreviate wierd weird
abbreviate restaraunt restaurant
iabbrev hse he/she

syntax on

if $VIM_CRONTAB == "true"
set nobackup
set nowritebackup
endif

