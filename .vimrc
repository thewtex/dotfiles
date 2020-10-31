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
set cinoptions={0,:0,l1,g0,c0,(0,(s,m1 " ITK/VTK style indenting
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

set rtp+=~/.fzf
"https://github.com/junegunn/fzf.vim
"nnoremap <leader>e :FZF<CR>
":Files [PATH]
nnoremap <leader>o :Files<CR>
nnoremap <leader>e :GFiles<CR>
nnoremap <leader>g :GFiles?<CR>
":Colors
nnoremap <leader>a :Lines<CR>
nnoremap <leader>b :BLines<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>h :BTags<CR>
nnoremap <leader>q :History<CR>
nnoremap <leader>j :History:<CR>
nnoremap <leader>k :History/<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>be :Buffers<CR>

if $TERM == "xterm" || $TERM == "rxvt" || $TERM == "xterm-256color" || $TERM == "screen-256color" || $TERM == "rxvt-unicode-256color" || &term =~ "builtin_gui" || $TERM == "dumb"
  "set t_Co=256
  "colorscheme molokayo
  "https://github.com/morhetz/gruvbox/issues/43
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
  let g:gruvbox_italic=1
  if (has("termguicolors"))
    set termguicolors
  endif
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " The default is 256
  "colorscheme gruvbox
  "let g:onedark_termcolors=16
  colorscheme onedark
  hi SyntasticError   ctermfg=235 ctermbg=218
  hi SyntasticWarning ctermfg=015 ctermbg=062
else
  let g:onedark_termcolors=16
  "colorscheme desert
endif
colorscheme onedark

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
let g:syntastic_javascript_checkers = ['standard']
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
let g:ycm_rust_src_path="/home/matt/src/rust/src/"

let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#bracket_spacing = 'true'
"autocmd bufwritepost *.js silent !standard-format -w %
set autoread

let g:clang_format#detect_style_file = 1
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
"nmap <Leader>C :ClangFormatAutoToggle<CR>

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

let g:rainbow_active = 1

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
