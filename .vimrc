set nocompatible        " must be the first line
filetype on
filetype indent on
filetype plugin on
syntax on
" for latexsuite
set grepprg=grep\ -nH\ $*
set laststatus=2
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set number
set cursorline
set pastetoggle=<F12>
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set autowrite
set matchpairs+=<:> " To mach arguments of templates
set cinoptions={1s,:0,l1,g0,c0,(0,(s,m1 " ITK/VTK style indenting
" highlight search
set hlsearch
set incsearch
set ignorecase smartcase " when searching, search pattern with an uppercase letter will only be case-sensitive
set encoding=utf8
set guifont=Inconsolata\ for\ Powerline\ Plus\ Nerd\ File\ Types:h10
set guioptions+=a
" wrapping textwidth
set history=500				" keep 50 lines of command history
set textwidth=78
set formatlistpat=^\\s*\\(\\d\\+\\\|[a-z]\\)[\\].)]\\s*
set formatoptions+=tqn

let s:is_windows = has('win32') || has('win64')

au BufNewFile,BufRead *.txx set filetype=cpp
au BufNewFile,BufRead *.cxx set filetype=cpp
au BufNewFile,BufRead *.wrap set filetype=cmake

call pathogen#infect()

if $TERM == "xterm" || $TERM == "rxvt" || $TERM == "xterm-256color" || $TERM == "screen-256color" || $TERM == "rxvt-unicode" || &term =~ "builtin_gui" || $TERM == "dumb"
  set t_Co=256
  "colorscheme molokayo
  "https://github.com/morhetz/gruvbox/issues/43
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
  let g:gruvbox_italic=1
  colorscheme gruvbox
  hi SyntasticError   ctermfg=235 ctermbg=218
  hi SyntasticWarning ctermfg=015 ctermbg=062
else
  colorscheme desert
endif

let g:airline_powerline_fonts = 1

let g:syntastic_check_on_open = 0
let g:syntastic_enable_signs = 1
let g:syntastic_mode_map = { 'mode' : 'active', 'active_filetype': ['cpp', 'python'] }
let g:syntastic_cpp_checkers = [ 'cppcheck' ]
let g:syntastic_python_checkers = [ 'pyflakes', 'pylint' ]
let g:syntastic_asciidoc_checkers = [ 'proselint' ]
let g:syntastic_help_checkers = [ 'proselint' ]
let g:syntastic_html_checkers = [ 'proselint' ]
let g:syntastic_markdown_checkers = [ 'proselint' ]
let g:syntastic_nroff_checkers = [ 'proselint' ]
let g:syntastic_pod_checkers = [ 'proselint' ]
let g:syntastic_rst_checkers = [ 'proselint' ]
let g:syntastic_tex_checkers = [ 'proselint' ]
let g:syntastic_texinfo_checkers = [ 'proselint' ]
let g:syntastic_text_checkers = [ 'proselint' ]
let g:syntastic_xhtml_checkers = [ 'proselint' ]
"let g:syntastic_debug_file = '/tmp/syntastic_debug.log'
" 1 - trace checker calls
" 2 - dump loclists
" 4 - trace notifiers
" 8 - trace autocommands
" 16 - dump variables
"let g:syntastic_debug=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_server_keep_logfiles = 1
"debug
"info
"warning
"error
"critical
let g:ycm_server_log_level = 'warning'

" lhs comments
map ,# :s/^/#/<CR>:nohlsearch<CR>
map ,/ :s/^/\/\//<CR>:nohlsearch<CR>
map ,> :s/^/> /<CR>:nohlsearch<CR>
map ," :s/^/\"/<CR>:nohlsearch<CR>
map ,% :s/^/%/<CR>:nohlsearch<CR>
map ,! :s/^/!/<CR>:nohlsearch<CR>
map ,; :s/^/;/<CR>:nohlsearch<CR>
map ,- :s/^/--/<CR>:nohlsearch<CR>
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" wrapping comments
nnoremap ,* :s/^\(\s*\)\(.*\)$/\1\/\*************** \2 \***************\//<CR>:nohlsearch<CR>
nnoremap ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
nnoremap ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
nnoremap ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>tb :TagbarToggle<CR>
let NERDTreeWinSize=50
let NERDTreeWinPos="right"
" shut up about Unknown filetype
let NERDShutUp=1

vnoremap <silent> <Enter> :EasyAlign<CR>

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1
nnoremap <leader>tt :TlistToggle<CR>

" http://wiki.contextgarden.net/Vim
let g:tex_flavor = "latex"

" from help under gU, -- capitalize words after typing
map! <C-F> <Esc>gUiw`]a

" Pyclewn print variable under cursor.
map <F10> :exe "Cprint " . expand("<cword>") <CR>

map <leader>mj :mak<CR>
map <leader>me :mak test<CR>
map <leader>ma :mak -j1<CR>

" unite plugin mappings suggested here
" http://bling.github.io//blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
" https://github.com/bling/dotvim/blob/master/vimrc
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('line,outline','matchers','matcher_fuzzy')
call unite#custom#source('file,file_rec,file_rec/async,grep', 'ignore_globs', ['.ExternalData/**', '.git/**'])
call unite#custom#profile('default', 'context', {
      \ 'start_insert': 1,
      \ })
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=10000

if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
  let g:unite_source_grep_recursive_opt=''
endif

nmap <space> [unite]
nnoremap [unite] <nop>

if s:is_windows
  nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec:! buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec:!<cr><c-u>
else
  nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr><c-u>
  nnoremap <silent> [unite]g :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/git:!<cr><c-u>
endif
nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=recent file_mru<cr>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline outline<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

nnoremap <leader>u :UndotreeToggle<CR>

let g:DoxygenToolkit_authorName="Matthew McCormick (thewtex) <matt@mmmccormick.com>"
let g:DoxygenToolkit_licenseTag="Public Domain"

let g:SuperTabDefaultCompletionType="context"
let g:SuperTabContextDefaultCompletionType="<c-p>"

" OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview

set makeprg=ninja

" Whitespace checking ( helps for git work )
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

function UseTabs()
  set softtabstop=0
  set noexpandtab
endfunction

function TubeTKEditing()
  set textwidth=80
  set wrap
  set wrapmargin=2
endfunction
