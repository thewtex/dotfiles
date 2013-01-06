set nocompatible        " must be the first line
filetype on
filetype indent on
filetype plugin on
syntax on
" for latexsuite
set grepprg=grep\ -nH\ $*
set laststatus=2
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set nu
set cul
set pastetoggle=<F12>
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set autowrite
set matchpairs+=<:> " To mach arguments of templates
set cinoptions={1s,:0,l1,g0,c0,(0,(s,m1 " ITK/VTK style indenting
set incsearch
set ignorecase smartcase " when searching, search pattern with an uppercase letter will only be case-sensitive
set guifont=Inconsolata\ 10
"colorscheme desert256   " desert256, gardener, wintersday, metacosm, oceanblack: is nice too
" wrapping textwidth
set history=500				" keep 50 lines of command history
set textwidth=80
set formatlistpat=^\\s*\\(\\d\\+\\\|[a-z]\\)[\\].)]\\s*
set formatoptions+=tqn

if $TERM == "xterm" || $TERM == "rxvt" || $TERM == "xterm-256color" || $TERM == "rxvt-unicode" || &term =~ "builtin_gui" || $TERM == "dumb"
        set t_Co=256
        colorscheme calmar256-dark
        "colorscheme peaksea
else
        colorscheme desert
endif

call pathogen#infect()

map ,m :s/^\(.*\)$/disp\('\1'\)/<CR>:nohlsearch<CR> 

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
nnoremap <leader>ns :NERDTreeFromBookmark strain<CR>
nnoremap <leader>nd :NERDTreeFromBookmark rfd<CR>
nnoremap <leader>ni :NERDTreeFromBookmark itk<CR>
nnoremap <leader>ne :NERDTreeFromBookmark itks<CR>
nnoremap <leader>nb :NERDTreeFromBookmark block<CR>
nnoremap <leader>nc :NERDTreeFromBookmark curve<CR>
nnoremap <leader>nf :NERDTreeFromBookmark fft<CR>
nnoremap <leader>na :NERDTreeFromBookmark bsc<CR>
let NERDTreeWinSize=50
let NERDTreeWinPos="right"

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Process_File_Always = 1
nnoremap <leader>tt :TlistToggle<CR>

" vtk class instantiation
map ,s :s/^\(\s*\)\(\a\+\)\s\+\(\a\+\)/\1vtkSmartPointer\< \2\ > \3 = vtkSmartPointer\< \2 \>::New\(\);/<CR>:nohlsearch<CR>o

" http://wiki.contextgarden.net/Vim
let g:tex_flavor = "latex"

" from help under gU, -- capitalize words after typing
map! <C-F> <Esc>gUiw`]a

" Pyclewn print variable under cursor.
map <F10> :exe "Cprint " . expand("<cword>") <CR>

" shut up about Unknown filetype
let NERDShutUp=1

map <leader>mj :mak -j8<CR>
map <leader>me :mak test<CR>
map <leader>ma :mak<CR>

let g:DoxygenToolkit_authorName="Matthew McCormick (thewtex) <matt@mmmccormick.com>"
let g:DoxygenToolkit_licenseTag="Public Domain"


if !exists("PIDA_EMBEDDED")

" your vim-only vimrc commands here

endif

if exists("PIDA_EMBEDDED")

" your vim-in-pida vimrc commands here

endif

function RESTScreenPreview()
  mak
  !screen -X screen -t rst links2 %:p:r.html
endfunction
map <leader>rt :call RESTScreenPreview()<CR>
function RESTFirefoxPreview()
  mak
  !firefox %:p:r.html
endfunction
map <leader>rf :call RESTFirefoxPreview()<CR><CR>

let g:SuperTabDefaultCompletionType="context"
let g:SuperTabContextDefaultCompletionType="<c-p>"

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/itk

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
map <leader>mt :make ctags<CR>

let twitvim_login = "thewtex:eLEhmec9993"
let twitvim_api_root = "http://identi.ca/api"

" Whitespace checking ( helps for git work )
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

