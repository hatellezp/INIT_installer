"nvim configuration file

"----------neovim intern config

"line numbers
set number

"default color scheme
"colorscheme 'onedark'

"remapping the navigation between tabs keys
map <C-H> <C-W>h<C-W>
map <C-L> <C-W>l<C-W>
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-K>

"remapping the split tab keys
map <C-V> <C-W>v<C-W>
map <C-S> <C-W>s<C-W>

"rustfmt for rust lang
let g:autofmt_autosave 	= 1
let g:autofmt_save 	= 1
let g:rustfmt_autosave	= 1

"-----------------------------------------------------"
"---------------plug-vim configuration----------------"
call plug#begin('/home/horacio/.config/nvim/pluggers')

"---------------plugins declarations------------------"
"syntastic (syntax plugin
Plug 'scrooloose/syntastic'
"vim-javascript
Plug 'pangloss/vim-javascript'
"vim-go
Plug 'fatih/vim-go'
"markdown syntax
Plug 'plasticboy/vim-markdown'
"json.vim
Plug 'elzr/vim-json'
"html5.vim
Plug 'othree/html5.vim'
"rust.vim
Plug 'rust-lang/rust.vim'
"python-mode
Plug 'klen/python-mode'
"merlin (ocaml plugin)
Plug 'the-lambda-church/merlin'
"youcompleteme
Plug 'valloric/youcompleteme'
"fugitive-vim (git wrapper plugin)
Plug 'tpope/vim-fugitive'
"tabular (tab and space following plugin)
Plug 'godlygeek/tabular'
"vim-colorschemes
Plug 'flazz/vim-colorschemes'
"ctrlp.vim (interface plugin?)
Plug 'kien/ctrlp.vim'
"vim-airline
Plug 'bling/vim-airline'
Plug 'bling/vim-airline-themes'
Plug 'vim-airline/vim-airline-themes'
"the nerd tree
Plug 'scrooloose/nerdtree'
"surround.vim (parentheses and brackets plugin)
Plug 'tpope/vim-surround'
"easy-motion
Plug 'easymotion/vim-easymotion'
"rustfmt (plugin for correctly formatting rust file)
Plug 'rust-lang-nursery/rustfmt'
"language-client-neovim
Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }
"
"multi-entry selection UI
Plug 'junegunn/fzf'
"another completion plugin
Plug 'roxma/nvim-completion-manager'
"vim-colors-solarized (solarized official theme)
Plug 'altercation/vim-colors-solarized'
"delimitmate (plugin should automatically close brackets)
Plug 'raimondi/delimitmate'
"
"-------------plugins configurations------------------"
"vim-javascript
let g:javascript_plugin_jsdoc 	= 1
let g:javascript_plugin_ngdoc 	= 1
let g:javascript_plugin_flow 	= 1
"
"the nerd tree
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
"vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized
"
"
"languageclient configuration
 "basic set up for LanguageClient-Neovim

" << LSP >> {{{

let g:LanguageClient_autoStart = 1
nnoremap <leader>lcs :LanguageClientStart<CR>

" if you want it to turn on automatically
" let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'go': ['go-langserver'] }

noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>

set runtimepath+=/home/horacio/.config/nvim/pluggers/LanguageClient-neovim
" }}}

"-----------------------------------------------------"
call plug#end()
"-----------------------------------------------------"
"
"
"
" ##added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 3d0bcf584795f570ae0621843f92bafc ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/horacio/.opam/4.06.0/share/vim/syntax/ocp-indent.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line

