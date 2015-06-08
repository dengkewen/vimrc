" An example for a vimrc file.一般设置cli相关设置，即命令行相关设置，插件相关设置。原因加载顺序是先读取vimrc配置，然后读取plugin插件，然后加载GUI，最后再读取gvimrc配置文件。所以，GUI以及快捷键一般放到gvimrc里设置，有时候在vimrc设置跟界面显示相关的没作用，要在gvimrc里设置才有用。vimrc配置是vim，gvimrc配置文件是gvim，如果想要vim也有配色等，可以将界面相关的设置放在vimrc文件里重新设置一下。  

""""brew install macvim --env-std --override-system-vim  """"
   
"-------------------------------------------------------------------------------  
"           基本设置  
"-------------------------------------------------------------------------------  
" When started as "evim", evim.vim will already have done these settings.  
"if v:progname =~? "evim"  
""  finish  
"endif  

"启用Vim的特性，而不是Vi的（必须放到配置的最前边）  
set nocompatible 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
 
     
" 设置文件编码    
   
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,big5

"设置字体（之后的插件绝对不要出现设置字体的命令，如powerline
set guifontwide=微软雅黑:h16  "此项必须在下一项的前面，否则不成功！
set guifont=Menlo:h16

"显示行号  
set number  
  
"设置默认打开窗口大小  
set lines=70 columns=120  
  
" ------------------------------------------------------------------
" Solarized Colorscheme Config, solarzed.vim 必须放在.vim/color文件夹下
" 否则无法调用该主题, 奇怪的现象
" ------------------------------------------------------------------
if has("gui_running")
let g:solarized_termcolors=256    "default value is 16
let g:solarized_contrast="normal"    "default value is normal
let g:solarized_diffmode="normal"    "default value is normal
colorscheme solarized 
set background=light
endif
"隐藏工具栏和滑动条  
set guioptions=aAce      
            
"设置标签栏  
"最多30个标签  
set tabpagemax=30   
"显示标签栏    
set showtabline=2           
  
"设定文件浏览器目录为当前目录  
set bsdir=buffer  
set autochdir  
  
"保存100条命令历史记录  
set history=600   
      
"总是在窗口右下角显示光标的位置  
set ruler     
      
"在Vim窗口右下角显示未完成的命令   
set showcmd           
  
" 启用鼠标  
if has('mouse')  
  set mouse=a  
endif  
  
" 记录上次打开的位置  
if has("autocmd")  
autocmd BufRead *.txt set tw=78  
autocmd BufReadPost *  
\ if line("'\"") > 0 && line ("'\"") <= line("$") |  
\   exe "normal g'\"" |  
\ endif  
endif  
  

"激活Alt键，可以增加很多组合功能"
 
"-------------------------------------------------------------------------------  
"           文本操作设置  
"------------------------------------------------------------------------------- 
"set leader 键
let mapleader=";"
let g:mapleader=";"
"快速保存
nmap <leader>w :w!<cr>
" 快捷打开编辑vimrc文件的键盘绑定

" Platform
function! MySys()
    if (has("win16")||has("win32")||has("win64")||has("win32unix")||has("win95"))
        return "windows"
    elseif (has("macunix")||has("mac")) "这句必须放在下一句前面"
        return "mac"
    elseif has("unix")
        return "linux"
    endif
endfunction
"Set shell to be bash
if (MySys() == "linux" || MySys() == "mac")
set shell=bash
else
"I have to run win32 python without cygwin
"set shell=E:cygwinsh
endif

"快速编辑.vimrc
"Fast reloading of the .vimrc
map <silent> <leader>ss :source $MYVIMRC <cr>
"Fast editing of .vimrc
map <silent> <leader>ee :tabnew $MYVIMRC <cr>
"When _vimrc is edited, reload it
autocmd BufWritePost .vimrc source $MYVIMRC

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ^z快速进入shell
nmap <C-Z> :shell<cr>
inoremap <leader>n <esc>
nnoremap <leader>n <esc>
vnoremap <leader>n <esc>

set backspace=eol,start,indent 
set whichwrap+=<,>,h,l " 退格键和方向键可以换行

set nobackup        " 关闭备份
set nowb
set noswapfile      " 不使用swp文件，注意，错误退出后无法恢复
set lbr             " 在breakat字符处而不是最后一个字符处断行

"设置自动缩进  
"设置智能缩进  
set tabstop=4  
set shiftwidth=4  
set softtabstop=4  
set expandtab  
set smarttab  
  
  
"设置Tab键跟行尾符显示出来  
"set list lcs=tab:>-,trail:-  
  
"设置自动换行 
set ai "Auto indent
set si "Smart indent 
set wrap  
  
"设置Insert模式和Normal模式下Left和Right箭头键左右移动可以超出当前行  
set whichwrap=b,s,<,>,[,]  
  
"设置光标移动到屏幕之外时，自动向右滚动10个字符  
set sidescroll=10  
   
  
"设置使~命令成为操作符命令，从而使~命令可以跟光标移动命令组合使用  
set tildeop  
  
"在Insert模式下，设置Backspace键如何删除光标前边的字符。这里三个值分别表示空白字符，分行符和插入模式之前的字符。  
set backspace=indent,eol,start  
  
"定义键映射，不使用Q命令启动Ex模式，令Q命令完成gq命令的功能---即文本格式化。  
map Q gq  
  
" CTRL-U 在Insert模式下可以删除当前光标所在行所在列之前的所有字符.  Insert模式下，在Enter换行之后，可以立即使用CTRL-U命令删除换行符。  
inoremap <C-U> <C-G>u<C-U>  
  
"使 "p" 命令在Visual模式下用拷贝的字符覆盖被选中的字符。  
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>  

""only for MACVIM, 终端下的VIM无效果，很有用的快捷键：在插入模式下，
""光标移动到下(上）一行的末端
"Remap VIM 0
"map 0 ^

"Move a line of text using control
if (MySys()=="windows"||MySys()=="linux") && has("gui_running")
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
imap <C-j> <Esc>jA
imap <C-CR> <C-j>
imap <C-k> <Esc>kA

elseif (MySys()=="mac" && has("gui_running"))
nmap <D-j> mz:m+<cr>`z
nmap <D-k> mz:m-2<cr>`z
vmap <D-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <D-k> :m'<-2<cr>`>my`<mzgv`yo`z   
imap <C-j> <Esc>jA
imap <C-CR> <C-j>
imap <C-k> <Esc>kA
else
imap <C-j> <Esc>jA
imap <C-k> <Esc>kA
endif


"-------------------------------------------------------------------------------
"           搜索设置  
"-------------------------------------------------------------------------------  
"打开搜索高亮 (很烦人，难看，所以关了) 
"set hlsearch  
  
"忽略大小写  
set ignorecase  
  
"在查找时输入字符过程中就高亮显示匹配点。然后回车跳到该匹配点。  
set incsearch     
  
"设置查找到文件尾部后折返开头或查找到开头后折返尾部。  
set wrapscan  
  
  
"-------------------------------------------------------------------------------  
"           插件设置  
"-------------------------------------------------------------------------------  
  
"插件相关的设置  
"matchit 的字符匹配自定义设置  
let b:match_words = '\<if\>:\<endif\>,'  
        \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'  
  
  
  
"Vundle 的配置    
set rtp+=~/.vim/bundle/vundle/  
call vundle#rc()  
  
" let Vundle manage Vundle  
" required!   
"管理Vim插件   
Bundle 'gmarik/vundle'   
  
  
" My Bundles here:  
" original repos on github  
  
" vim-scripts repos  
"实现“begin”/“end”类似地匹配,~/.vimrc文件中添加自定义的设置：
let b:match_words = '\<if\>:\<endif\>,'  
        \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'    
Bundle 'winmanager'  
Bundle 'kien/ctrlp.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'DoxygenToolKit.vim'
Bundle 'MattesGroeger/vim-bookmarks'
Bundle 'https://github.com/SirVer/ultisnips'
Bundle 'https://github.com/honza/vim-snippets'
"Bundle 'https://github.com/jcfaria/Vim-R-plugin'
Bundle 'https://github.com/drmingdrmer/xptemplate'
" non github repos  
Bundle 'https://github.com/Valloric/YouCompleteMe'
Bundle 'https://github.com/scrooloose/syntastic' 
Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'https://github.com/Lokaltog/vim-powerline.git'
Bundle 'https://github.com/altercation/vim-colors-solarized.git'

   
filetype plugin indent on     " required!  
"  
" Brief help  
" :BundleList          - list configured bundles  
" :BundleInstall(!)    - install(update) bundles  
" :BundleSearch(!) foo - search(or refresh cache first) for foo  
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles  
"  
" see :h vundle for more details or wiki for FAQ  
" NOTE: comments after Bundle command are not allowed..


"""""""""" nerdtree settings""""""""""""""""""""""
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"""""""""""""""""""""""""""""""""""""
" 此函数可以隐藏不需要显示的文件和文件夹Use the 'wildignore' and 'suffixes' settings for filtering out files.
function! s:FileGlobToRegexp( glob )
    " The matching is done against the sole file / directory name.
    if a:glob =~# '^\*\.'
        return '\.' . a:glob[2:] . '$'
    else
        return '^' . a:glob . '$'
    endif
endfunction
function! s:SuffixToRegexp( suffix )
    return escape(v:val, '.~') . "$"
endfunction
let g:NERDTreeIgnore =
\   map(split(&wildignore, ','), 's:FileGlobToRegexp(v:val)') +
\   map(split(&suffixes, ','), 's:SuffixToRegexp(v:val)')
delfunction s:SuffixToRegexp
delfunction s:FileGlobToRegexp

"""""""""""""""""下面再添加一些常用的不希望显示的文件""""""""""""""""""""""
"不显示以下列后缀名结尾的文件"
let NERDTreeIgnore+=['\.so$', '\.a$','\.o$','\~$','\.exe$']

let NERDTreeIgnore+=['\.bash_profile$','\.DS_Store$','\.localized$','\history$','\.viminfo$','\.zcompdump-DKW-5.0.5$','\.*update$','\.Xauthority$','\.slate$','\.swp$']

let NERDTreeIgnore+=['\.dvi$','\.aux$','\.fls$','\.log$','\.swo$','\.dvi$','\.sublime-project$','\.sublime-workspace$','\.synctex.gz$','\.fdb_latexmk$','\.sfd$','\.out$','\.thm$','\.tmp$','\.toc$']
"写LATEX时有用的文件不隐藏，如：,'\.eps$','\.jpg$','\.png$','\.pdf$'"

"不显示以下列后缀结尾的文件夹"
let NERDTreeIgnore+=['\.cache$','\.config$','\.local$','\.nutstore$','\.texlive2014$','\.Trash$','\.swt$','\.subversion$']

"不显示以下文件夹"
let NERDTreeIgnore+=['\~$','Applications','concorde','Movies','Music','Pictures','Public','Library','Downloads','QSOPT','texmf','LKH-2.0.7']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$VIM.'NerdBookmarks.txt'
let NERDTreeMouseMode=1
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=0
let NERDTreeWinPos='left'
let NERDTreeWinSize=31

"""""""""WinManage setup"""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout='FileExplorer,BufExplorer|TagList'  
"let g:winManagerWindowLayout='NERDTree, BufExplorer|TagList'  
"打开vim时自动打开winmanager  
"let g:AutoOpenWinManager = 1  
"定义打开关闭winmanager的快捷键为 wt组合键命令  
"nmap wt :WMToggle<cr>  

"""""""""""CtrlP"""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = {
      \ 'dir':  'vendor/bundle/*\|vendor/cache/*\|public\|spec',
      \ 'file': '\v\.(exe|so|dll|swp|log|eps|o|a||jpg|png|json|dvi|plist|)$',
      \ }
"可以查找隐藏文件，默认情况下是不打开的"
 let g:ctrlp_show_hidden = 1     
""""""""""syntastic""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = 'x'
let g:syntastic_warning_symbol = '!'
"whether to show balloons
let g:syntastic_enable_balloons = 1

"""""""""YouCompleteMe'"""""""""""""""""""""""""""""""""""""""""
"""""install method"""""""
"1) cd /Users/kevin/.vim/bundle/YouCompleteMe/

"2) EXTRA_CMAKE_ARGS="-DEXTERNAL_LIBCLANG_PATH=/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"

"3) ./install.sh --clang-completer --system-libclang
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = "/Users/kevin/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"

"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']

set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"  "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  

let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1  " 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>  "force recomile with syntastic
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR>  "close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处

"""""UltiSnips SETUP"""""""""""""""""""""""""""""""""""""""""""""""
"定义存放代码片段的文件夹，使用自定义和默认的，将会的到全局，有冲突的会提示
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsSnippetDir=["~/.vim/UltiSnips"]
let g:UltiSnipsExpandTrigger="<C-f>"
if has("gui_running")
  imap <S-CR> <C-f>
endif

let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"


"""""DoxygenToolKit.vim""""""""""""""""""""""""""""""""""""""""""""
let g:DoxygenToolkit_briefTag_funcName = "yes"

    " for C++ style, change the '@' to '\'
    let g:DoxygenToolkit_commentType = "C++"
    let g:DoxygenToolkit_briefTag_pre = "\\brief "
    let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
    let g:DoxygenToolkit_paramTag_pre = "\\param "
    let g:DoxygenToolkit_returnTag = "\\return "
    let g:DoxygenToolkit_throwTag_pre = "\\throw " " @exception is also valid
    let g:DoxygenToolkit_fileTag = "\\file "
    let g:DoxygenToolkit_dateTag = "\\date "
    let g:DoxygenToolkit_authorTag = "\\author "
    let g:DoxygenToolkit_versionTag = "\\version "
    let g:DoxygenToolkit_blockTag = "\\name "
    let g:DoxygenToolkit_classTag = "\\class "
    let g:DoxygenToolkit_authorName = "Kewen Deng, dengkewen@cqu.edu.cn"
    let g:doxygen_enhanced_color = 1
    "let g:load_doxygen_syntax = 1


"powerline{
 set t_Co=256
 "}
""""""""""""xptemplate setup"""""""""""""""""""""""""""""""""""""""""
"let g:xptemplate_key = '<C-\>'  
let g:xptemplate_vars = "SParg="
let g:xptemplate_vars = "SPcmd=&BRloop=\n"
let g:xptemplate_vars = "BRfun= "
let g:xptemplate_vars = "author=KeWen Deng &email=dengkewen@cqu.edu.cncom&"
let g:xptemplate_minimal_prefix = 0

"""""""""VIM-BookMark""""""""""""""""""""""""""""""""""""""""""""""
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '>>'
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_manage_per_buffer = 1
let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""如下几行必须放在本文档的最后，否则UltiSnips""""""""""""""
"""""""""""""将无法正常工作，MGB的，困扰了我三天的问题'""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置语法高亮  
if &t_Co > 2 || has("gui_running")  
syntax on  
endif  
filetype on
filetype plugin on
filetype indent on 
