" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if has("win32")
  let $VIMDATA  = $VIM.'/vimdata'
  let $VIMFILES = $VIM.'/vimfiles'
else
  let $VIMDATA  = $HOME.'/.vim/vimdata'
  let $VIMFILES = $HOME.'/.vim'
  set guifont=courier\ 10
endif

syntax on
syntax enable
filetype on             " enable file type detection
filetype plugin on

set nocompatible    " use vim as vim, should be put at the very start
set backspace=indent,eol,start 
					" allow backspacing over everything in insert mode

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup        " make backup file and leave it around
  set backupdir=$VIMDATA/backup  
					" where to put backup file
  set directory=$VIMDATA/temp    
					" where to put swap file
endif

"-----------------------------------------------------------------------------
" general
"-----------------------------------------------------------------------------
set browsedir=buffer    " use directory of the related buffer for file browser
set clipboard+=unnamed  " use clipboard register '*' for all y, d, c, p ops
set viminfo+=!          " make sure it can save viminfo
set isk+=$,%,#,-        " none of these should be word dividers
set confirm             " raise a dialog confirm whether save changed buffer
set ffs=unix,dos,mac    " favor unix, which behaves good under Linux/Windows
set fenc=utf-8          " default fileencoding
set fencs=utf-8,ucs-bom,euc-jp,gb18030,gbk,gb2312,cp936
set runtimepath+=$VIMDATA      " add this path to rtp, support GLVS
set path=.,/usr/include/*,,    " where gf, ^Wf, :find will search
set makeef=error.err           " the errorfile for :make and :grep
set history=100		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set showmatch
set matchtime=5     " 1/10 second to show the matching paren
set incsearch		" do incremental searching
set nohlsearch      " do not highlight searched for phrases
set number			" print line number
set ignorecase
set smarttab
set tabstop=4
set softtabstop=4   " unify it
set shiftwidth=4
set expandtab		" expand tab to spaces
" set noexpandtab
" use :retab to transfer existing tab to spaces
set statusline=%f%m%r%h%w
set laststatus=1        " 2 : always show statusline

set splitbelow
set linebreak
set showbreak=""
set breakat=" ^I!@*-+;:,./?！，。"
set textwidth=80
set colorcolumn=+1,+2
map <F2> :nohl<CR>
map Q gq
					" Don't use Ex mode, use Q for formatting
	
" hi Comment term=bold ctermfg=3 guifg=SlateBlue
" hi StatusLineNC ctermfg=0  ctermbg=7
" hi StatusLine   cterm=reverse ctermfg=4  ctermbg=7

"-----------------------------------------------------------------------------
" Vim UI
"-----------------------------------------------------------------------------
set linespace=1         " space it out a little more (easier to read)
set wildmenu            " type :h and press <Tab> to look what happens
set cmdheight=2         " use 2 screen lines for command-line
set lazyredraw          " do not redraw while executing macros (much faster)
set hid                 " allow to change buffer without saving
set backspace=2         " make backspace work normal
set whichwrap+=<,>,h,l  " allow backspace and cursor keys to wrap
set mouse=a             " use mouse in all modes
set shortmess=atI       " shorten messages to avoid 'press a key' prompt
set report=0            " tell us when anything is changed via :...
set fillchars=vert:\ ,stl:\ ,stlnc:\
                        " make the splitters between windows be blank

"-----------------------------------------------------------------------------
" visual cues
"-----------------------------------------------------------------------------
set scrolloff=10        " minimal number of screen lines to keep above/below the cursor
set novisualbell        " use visual bell instead of beeping
set noerrorbells        " do not make noise
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ " how :set list show

"-----------------------------------------------------------------------------
" text formatting/layout
"-----------------------------------------------------------------------------
set ai                  " autoindent
set si                  " smartindent
set cindent             " do C-style indenting
set fo=tcrqn            " see help (complex)
set noexpandtab         " real tabs please!
set nowrap              " do not wrap lines
set formatoptions+=mM   " thus vim can reformat multibyte text (e.g. Chinese)

"-----------------------------------------------------------------------------
" folding
"-----------------------------------------------------------------------------
set foldenable          " turn on folding
set foldmethod=indent   " make folding indent sensitive
set foldlevel=100       " don't autofold anything, but can still fold manually
set foldopen -=search   " don't open folds when you search into them
set foldopen -=undo     " don't open folds when you undo stuff

"-----------------------------------------------------------------------------
" auto indent
"-----------------------------------------------------------------------------
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
nnoremap <leader>ig :IndentLinesToggle<CR>:set list! lcs=tab:\\|\<Space><CR>
let g:indentLine_char = '¦'

"-----------------------------------------------------------------------------
" mouse setting
"-----------------------------------------------------------------------------
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  " colo inkpot         " colorscheme, inkpot.vim
  set lines=40          " window tall and wide, only if gui_running,
  set columns=120       " or vim under console behaves badly
  set background=dark
  colorscheme darkblue
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 13
else
  colorscheme desert
endif

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"-----------------------------------------------------------------------------
" plugin: ctags
"-----------------------------------------------------------------------------
set autochdir
set tags=./tags,tags,$VIMFILES/doc/tags " used by CTRL-]
map <C-F12> :!ctags -R --fields=+ailS --extra=+q .<CR>

"-----------------------------------------------------------------------------
" plugin: cscope
"-----------------------------------------------------------------------------
set cscopequickfix=s-,c-,d-,i-,t-,e-
if has("cscope")
    set cscopetag
    set csto=0
    if filereadable("cscope.out")
        cs add cscope.out  
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose  

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    " nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

    "set timeoutlen=4000
    "set ttimeout 
    "set ttimeoutlen=100
endif

"-----------------------------------------------------------------------------
" plugin - taglist.vim
"-----------------------------------------------------------------------------
if has("win32")
  let Tlist_Ctags_Cmd = $VIMFILES.'/ctags.exe' " location of ctags tool
else
  let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
endif
nnoremap <silent><F11> :TlistToggle<CR>
let winManagerWindowLayout = 'FileExplorer|TagList'
let Tlist_Show_Menu = 1
let Tlist_Auto_Open = 0
let Tlist_Exit_OnlyWindow = 1             " if you are the last, kill yourself
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Display_Prototype = 1
let Tlist_Display_Tag_Scope = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Highlight_Tag_On_BufEnter = 0
let Tlist_Inc_Winwidth = 1
let Tlist_Max_Submenu_Items = 20
let Tlist_Max_Tag_Length = 10
let Tlist_Process_File_Always = 1
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"               " order by
let Tlist_Use_Horiz_Window = 0
let Tlist_Use_Right_Window = 1             " split to the right side of the screen
let Tlist_Compart_Format = 1               " show small meny
let Tlist_File_Fold_Auto_Close = 1         " close tags for other files
let Tlist_Enable_Fold_Column = 1           " do not show folding tree
let Tlist_Use_SingleClick = 1
" let Tlist_WinHeight = 20
" let Tlist_WinWidth = 20
" let tlist_cpp_settings = 'c++;c:class;f:function'
" let tlist_c_settings = 'c;f:My Functions'
" let tlist_tex_settings='latex;b:bibitem;c:command;l:label'

"-----------------------------------------------------------------------------
" plugin - omnicpp.vim
"-----------------------------------------------------------------------------
set nocp
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 0
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 0 " show function parameter list
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1 " complete after . input
let OmniCpp_MayCompleteArrow = 1 " complete after -> input
let OmniCpp_MayCompleteScope = 1 " complete after ::  input
let OmniCpp_SelectFirstItem = 0
let OmniCpp_DefaultNamespaces   = ["std", "_GLIBCXX_STD"]
highlight Pmenu guibg=darkgrey guifg=black
highlight PmenuSel guibg=lightgrey guifg=black

"-----------------------------------------------------------------------------
" plugin - python related
"-----------------------------------------------------------------------------
if has("win32")
  " let PYTHON_BIN_PATH = 'd:/foo/python/python.exe'  " ensure the path right
else
  let PYTHON_BIN_PATH = '/usr/bin/python'
endif
au FileType python set complete+=k$VIMFILES/dict/pydiction isk+=.,(
let g:pydiction_location='~/.vim/tools/complete-dict'
let g:pydiction_menu_height=20
au FileType python source $VIMFILES/plugin/python.vim
" au FileType python pyfile $VIMFILES/plugin/pyCallTips.py
autocmd FileType python setlocal foldmethod=indent
" unfold all codes defaultly
set foldlevel=99

" supertab setting
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:SuperTabClosePreviewOnPopupClose=1

" quickfix setting
nmap <F5> :cw<cr>
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>


"-----------------------------------------------------------------------------
" plugin - runscript.vim  (for Python)
"-----------------------------------------------------------------------------
"let PYTHON_BIN_PATH    = ...

"-----------------------------------------------------------------------------
" plugin - calendar.vim
"-----------------------------------------------------------------------------
let g:calendar_diary = $VIMDATA.'/diary'   " where to store your diary

"-----------------------------------------------------------------------------
" plugin - mru.vim (most recently used files)
"-----------------------------------------------------------------------------
let MRU_File = $VIMDATA.'/_vim_mru_files'  " which file to save mru entries
let MRU_Max_Entries = 20                   " max mru entries in _vim_mru_files

"-----------------------------------------------------------------------------
" plugin - favmenu.vim
"-----------------------------------------------------------------------------
let FAV_File = $VIMDATA.'/_vim_fav_files'  " which file to save favorite items

"-----------------------------------------------------------------------------
" plugin - minibufexpl.vim
"-----------------------------------------------------------------------------
let g:miniBufExplTabWrap = 1               " make tabs show complete (no broken on two lines)
let g:miniBufExplModSelTarget = 1



"-----------------------------------------------------------------------------
" plugin - matchit.vim
""-----------------------------------------------------------------------------
let b:match_ignorecase = 1

"-----------------------------------------------------------------------------
" utilities
"-----------------------------------------------------------------------------
" select range, then hit :SuperRetab($width) - by p0g and FallingCow
fu! SuperRetab(width) range
  sil! exe a:firstline.','.a:lastline.'s/\v%(^ *)@<= {'. a:width .'}/\t/g'
endf

" bind :CD to :cd %:h, then change cwd to current buffer's directory
sil! com -nargs=0 CD exe 'cd %:h'

"TODO just do it
fu! AddLineNo(isVM)
  if(a:isVM == 1)
    sil! exe 's/^/\=' . strpart((line('.')-line("'<")+1)."    ", 0, 4)
  else
    sil! exe '%s/^/\=' . strpart(line('.')."    ", 0, 4)
  endif
endf
" add line number befor each line of the text
" :g/^/exec "s/^/".strpart(line(".")."    ", 0, 4)
" :%s/^/\=strpart(line('.')."    ", 0, 4)
" visual mode
" :s/^/\=strpart((line('.')-line("'<")+1)."   ", 0, 4)

" XML support, e.g. element,,,<CR> -> <element> </element>
" Bart van Deenen, www.vandeenensupport.com
fu! MakeElement()
  if match(getline('.'),'^\s*>\s*$') == -1
    "the deleted word was not alone on the line
    let @w = "i<pla</pa>F<i"
  else
    "the deleted word was on it's own on the line
    let @w = "i<po</pa>kA"
  endif
endf

" include colon(58) for namespaces in xsl for instance
"setlocal iskeyword=@,48-57,_,192-255,58
inoremap <buffer>  ,,, ><Esc>db:call MakeElement()<enter>@w

"-----------------------------------------------------------------------------
" mappings
"-----------------------------------------------------------------------------
map <right> <ESC>:MBEbn<RETURN>
                                           " -> switches buffers
map <left>  <ESC>:MBEbp<RETURN>
                                           " <- switches buffers
map <up>    <ESC>:Sex<RETURN><ESC><C-W><C-W>
                                           " up arrow to bring up a file explorer
map <down>  <ESC>:Tlist<RETURN>
                                           " down arrow to bring up the taglist
map <A-i> i <ESC>r
                                           " Alt-i inserts a single char, and back to normal
map <F3>    <ESC>ggVG:call SuperRetab()<left>
map <F4>    ggVGg?
                                           " Rot13 encode the current file

"noremap <silent> <C-F11> :cal VimCommanderToggle()<CR>

" plugin - php_console.vim
"map <F5> :call ParsePhpFile()<cr>         " call function in normal mode
"imap <F5> <ESC>:call ParsePhpFile()<cr>   " call function in insert mode

"-----------------------------------------------------------------------------
" autocommands
"-----------------------------------------------------------------------------
au BufEnter * :syntax sync fromstart       " ensure every file does syntax highlighting (full)
au BufNewFile,BufRead *.asp :set ft=jscript " all my .asp files ARE jscript
au BufNewFile,BufRead *.tpl :set ft=html   " all my .tpl files ARE html

"-----------------------------------------------------------------------------
" highlight active line in normal mode, Vim7 don't need this
"-----------------------------------------------------------------------------
"hi CurrentLine guibg=darkgrey guifg=white ctermbg=darkgrey ctermfg=white
"au! Cursorhold * exe 'match CurrentLine /\%' . line('.') . 'l.*/'
"set ut=19

"-----------------------------------------------------------------------------
" useful abbrevs
"-----------------------------------------------------------------------------
iab xasp <%@language=jscript%><CR><%<CR><TAB><CR><BS>%><ESC><<O<TAB>
iab xdate <c-r>=strftime("%m/%d/%y %H:%M:%S")<cr>

"-----------------------------------------------------------------------------
" customize cursor color to indicate IM is on
"-----------------------------------------------------------------------------
if has('multi_byte_ime')
  hi Cursor   guifg=NONE guibg=Green
  hi CursorIM guifg=NONE guibg=Blue
endif

let g:winManagerWidth   = 35
let g:winManagerWindowLayout = 'TodoList'

let g:tskelDir = $VIMFILES."/skeletons"
