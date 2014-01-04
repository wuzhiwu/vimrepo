" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nu

" hi Comment term=bold ctermfg=3 guifg=SlateBlue
" hi StatusLineNC ctermfg=0  ctermbg=7
" hi StatusLine   cterm=reverse ctermfg=4  ctermbg=7


" tab setting
set ignorecase
set smartcase
set smarttab
set tabstop=4
set splitbelow
set shiftwidth=4
set showmatch
set matchtime=1
set linebreak
set showbreak=""
set breakat=" ^I!@*-+;:,./?！，。"
set expandtab " expand tab to spaces
" set noexpandtab
" use :retab to transfer existing tab to spaces

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set background=dark
  colorscheme darkblue
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 13
endif

" Only do this part when compiled with support for autocommands.
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

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" syntax highlight enable
syntax enable
syntax on
colorscheme desert

set autochdir
set tags=tags;
set tags+=/home/wuzhw/openvswitch-1.10.0/tags
set tags+=/home/wuzhw/xen-4.3.0/tags
set tags+=/home/wuzhw/protobuf/protobuf-rpc/protobuf-socket-rpc-read-only/java/src/main/java/com/googlecode/protobuf/socketrpc/tags
set tags+=/home/wuzhw/protobuf/protobuf-2.5.0/java/src/main/java/com/google/protobuf/tags
set tags+=/home/wuzhw/protobuf/protobuf-rpc/protobuf-socket-rpc-read-only/python/src/protobuf/socketrpc/tags
set tags+=/home/wuzhw/linux-3.10.20/tags
set tags+=//usr/lib/python2.6/site-packages/tags

" cscope

" set vim status line
set statusline=%F%m%r%h%w/[FORMAT=%{&ff}]/[TYPE=%Y]/[ASCII=/%03.3b]/[HEX=/%02.2B]/[POS=%04l,%04v][%p%%]/[LEN=%L]
" set laststatus=1

" taglist setting
nnoremap <silent><F11> :TlistToggle<CR>
let winManagerWindowLayout = 'FileExplorer|TagList'
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 1
let Tlist_Compact_Format = 1
let Tlist_Display_Prototype = 1
let Tlist_Display_Tag_Scope = 0
let Tlist_Enable_Fold_Column = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Highlight_Tag_On_BufEnter = 0
let Tlist_Inc_Winwidth = 0
let Tlist_Max_Submenu_Items = 20
let Tlist_Max_Tag_Length = 10
let Tlist_Process_File_Always = 1
let Tlist_Show_Menu = 1
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
let Tlist_Use_Horiz_Window = 0
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
" let Tlist_WinHeight = 20
" let Tlist_WinWidth = 20
" let tlist_cpp_settings = 'c++;c:class;f:function'
" let tlist_c_settings = 'c;f:My Functions'
" let tlist_tex_settings='latex;b:bibitem;c:command;l:label'

" omnicpp setting
set nocp
filetype plugin on
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

" supertab setting
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:SuperTabClosePreviewOnPopupClose=1

" quickfix setting
nmap <F5> :cw<cr>
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>


let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
nnoremap <leader>ig :IndentLinesToggle<CR>:set list! lcs=tab:\\|\<Space><CR>
let g:indentLine_char = '¦'
