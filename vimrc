" 关闭兼容模式
set nocompatible
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 语法高亮
syntax on
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
set shortmess=atI				" 启动的时候不显示提示 

" 一般配置{{{
set selection=exclusive 
set selectmode=mouse,key 
" 显示中文帮助
set helplang=cn
" vim文件间复制粘贴完美方案
"将选择缓冲区中内容粘贴到vim文件：普通模式下按 “*p 
"复制内容到选择缓冲区。
"  带行号时，使用鼠标选择内容区域。
"  不要行号，使用 “*yny 复制n行或可视模式下选择。
set mouse=a 
set clipboard=unnamed

set number
set showcmd								"显示命令
set cmdheight=1							"命令行的高度
set confirm								"处理未保存或只读文件时，弹出确认
set ruler								"状态行上显示光标所在行号和列号
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
"[?]set rulerformat=%20(%2*%<%f%=\ %m%r\ %31\ %c\ %p%%%)
set laststatus=2						"always show the status line
set scrolloff=3							"光标移动到buffer的顶部和底部时保持3行距离, 或set so=3
set fillchars=vert:\ ,stl:\ ,stlnc:\	"在被分割的窗口间显示空白，便于阅读

set tw=80						" Linebreak on 500 characters
set lbr							" 整词换行
set iskeyword+=_,$,@,%,#,-		" 带有如下符号的单词不要被换行分割 

" showmarks setting
let showmarks_enable = 0            " disable showmarks when vim startup
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let showmarks_ignore_type = "hqm"   " help, Quickfix, non-modifiable

"Search Relate
set ignorecase  " Set search/replace pattern to ignore case 
set smartcase   " Set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.
set incsearch   " 在搜索时，输入的词句的逐字符高亮
set hlsearch    " highlight search
set magic       " Enable magic matching
set showmatch   " show matching paren
set wildmenu    " 增强模式中(vim)的命令行自动完成操作

" 状态栏
highlight StatusLine guifg=SlateBlue guibg=Yellow 
highlight StatusLineNC guifg=Gray guibg=White 

set tm=500
set formatoptions=tcrqn					" 自动格式化 
set mps+=<:>							" 让<>可以使用%跳转
" like 007, it would not become 010
set nf=
" In Visual Block Mode, cursor can be positioned where there is no actual character
set ve=block
"}}}

"判断是终端还是Gvim{{{
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
"}}}

" Encoding{{{ 
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936 
set termencoding=utf-8
set encoding=utf-8
set encoding=utf-8
"处理consle输出乱码
language messages zh_CN.utf-8
"处理菜单及右键菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"}}}

"Intend{{{
filetype indent on					" 自适应不同语言的智能缩进
set sw=4
set expandtab						" 将制表符扩展为空格
set tabstop=4						" 设置编辑时制表符占用空格数
set shiftwidth=4					" 设置格式化时制表符占用空格数
set softtabstop=4					" 让 vim 把连续数量的空格视为一个制表符
set autoindent				" always set autoindenting on
set smartindent				" 为C程序提供自动缩进
set smarttab				" 在行和段开始处使用制表符
" }}}

"Fold{{{
" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=marker			"对文中标志折叠 [manual|intend|expr|syntax|diff|marker]
" 启动 vim 时关闭折叠代码
set nofoldenable
"}}}
 
"Windows config{{{
if g:isGUI      " 使用GUI界面时的设置
	au GUIEnter * simal ~x	 "全屏显示
	set t_Co=256
    set guioptions+=c        " 使用字符提示框
    set guioptions-=m        " 隐藏菜单栏
    set guioptions-=T       " 隐藏工具栏
    set guioptions-=L        " 隐藏左侧滚动条
    set guioptions-=r       " 隐藏右侧滚动条
    set guioptions-=b        " 隐藏底部滚动条
    set showtabline=0       " 隐藏Tab栏
    set cursorline           " 突出显示当前行
	set gcr=a:block-blinkon0 " 禁止光标闪烁
    set guifont=Courier_New:h11:cDEFAULT    "设置字体
endif
"}}}

"Fast Edit Virmrc file{{{ 
" 系统平台
function! MySys()
	if has("win32")
		return "windows"
	else
		return "linux"
	endif
endfunction
" 用开Fast Edit vimrc 
function! SwitchToBuf()
	" find in current tab
	let bufwinnr = bufwinnr($MYVIMRC)
	if bufwinnr != -1
		exec bufwinnr . "wincmd w"
		return
	else
		" find in each tab
		tabfirst
		let tab = 1
		while tab <= tabpagenr("$")
			let bufwinnr = bufwinnr($MYVIMRC)
			if bufwinnr != -1
				exec "normal " . tab . "gt"
				exec bufwinnr . "wincmd w"
				return
			endif
			tabnext
			let tab = tab + 1
		endwhile
		" not exist, new tab
		exec "tabnew " . $MYVIMRC
	endif
endfunction

if MySys() == 'linux'
	"Fast reloading of the .vimrc
	map <silent> <leader>ss :source $MYVIMR <cr> 
	"Fast editing of .vimrc
	map <silent> <leader>ee :call SwitchToBuf()<cr>
	"When .vimrc is edited, reload it
	autocmd! bufwritepost .vimrc source $MYVIMRC
elseif MySys() == 'windows'
	" Set helplang
	set helplang=cn
	"Fast reloading of the _vimrc
	map <silent> <leader>ss :source $MYVIMRC<cr>
	"Fast editing of _vimrc
	map <silent> <leader>ee :call SwitchToBuf()<cr>
	"When _vimrc is edited, reload it
	autocmd! bufwritepost _vimrc source $MYVIMRC
endif

"#}}}

"Run Compile{{{ 
map <F7> :call CompileRun()<CR>
function! CompileRun()
	exec "w"
	exec "!python  %"
endfunction

function! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunction

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"#}}}

"Auto insert file header{{{ 
autocmd BufNewFile *.py, exec ":call SS()" 
autocmd BufNewFile * normal G 
function! SS() 
	if &filetype == 'python' 
		call setline(1, "#!/usr/bin/env python")
		call setline(2, "# -*- coding: utf-8 -*-")
		autocmd BufNewFile * normal 17G 
	endif
endfunction
"}}}

"Mappings{{{
map 0 ^					" Remap VIM 0 to first non-blank character
map j gj				" 换行的长行内上移
map k gk				" 换行的长行内下移
vmap <C-c> "+y			" 选中状态下 Ctrl+c 复制
map <C-A> ggVGY			" 全选+复制 ctrl+a
map! <C-A> <Esc>ggVGY

" PAST模式切换,将文本原本格式粘贴到VIM中，避免错误
set pastetoggle=<F2>			" 激活/取消 paste模式
" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>
" Set Up and Down non-linewise
noremap <Up> gk
noremap <Down> gj
" 使用 ALT+[jk] 上下移动一行文本
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" 多窗口操作
nmap wv <C-w>v     " 垂直分割当前窗口
nmap ws <C-w>s     " 水平分割当前窗口
nmap wc <C-w>c     " 关闭当前窗口
nmap wd :bd<CR>    " 清空当前窗口
nmap wq :q<CR>     " 退出
" 多窗口切换
nnoremap nw <C-W><C-W>				" 依次遍历子窗口
nnoremap <Leader>lw <C-W>l			" 跳转至右方的窗口
nnoremap <Leader>hw <C-W>h			" 跳转至方的窗口
nnoremap <Leader>kw <C-W>k			" 跳转至上方的子窗口
nnoremap <Leader>jw <C-W>j			" 跳转至下方的子窗口
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" tab标签操作
map tn :tabn<cr>
map tp :tabp<cr>
map te :tabnew<cr>
map to :tabonly<cr>					" 关闭其它tab窗口
map tq :tabclose<cr>
map tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>
"}}}

"Files and backups{{{ 
set autochdir						" 自动切换当前目录为当前文件所在的目录
set autoread						" Set to auto read when a file is changed from the outside
set wildignore=*.o,*~,*.pyc,*.obj	" 那些文件不参数自动补全
set bufhidden=hide					" 当前文件不在窗口显示,buffer如何处理
set autowrite						" 自动把内容写回文件: 如果文件被修改过
set hid								" allow to change buffer without saving 
autocmd BufEnter * lcd %:p:h		" 自动更改到当前文件所在的目录
"取消自动备份及产生swp文件
set nobackup
set nowb
set noswapfile
"}}}

"Plugin{{{ 
" vundle {
" set nocompatible    " be iMproved
" 如果在Linux下使用的话，设置为
" set rtp+=~/.vim/bundle/vundle/
" 如果在windows下使用的话，设置为
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()
" }
Bundle 'gmarik/vundle'
Bundle 'SuperTab'
Bundle 'vim-scripts/TaskList.vim'

Bundle 'Lokaltog/vim-powerline'

"winmanager{{{
Bundle 'winmanager'
Bundle 'minibufexpl.vim'
Bundle 'The-NERD-tree'
Bundle 'tagbar'
"=========>  tagbar
nmap <Leader>tb :TagbarToggle<CR>
"let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_ctags_bin='C:\ctags58\ctags.exe'
"let g:tagbar_left = 1                                "在左侧                                              
let g:tagbar_right = 1                                "在右侧                                              
let g:tagbar_width = 30                               "设置宽度            
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"=========> The-NERD-tree 
let g:tagbar_left=1
nnoremap <silent> <F9> :TagbarToggle<CR>
"=========> winmanager 
let g:winManagerWidth = 25
let g:NERDTree_title="[NERDTree]"  
let g:winManagerWindowLayout="NERDTree|Tagar"  
"}}}

"vimwiki{{{ 
Bundle 'vimwiki'
let g:vimwiki_list = [{'path':'E:/home/wiki/'
        \,'template_path' : 'E:/home/wiki/template/'
        \,'template_default' : 'default_template/'
        \,'template_ext' : '.html'
        \,'path_html': 'E:/home/wiki/html'}]
" 如果你希望在Vimwiki中直接写HTML标签，那可以通过vimwiki_valid_html_tags选项配置。
let g:vimwiki_valid_html_tags = ''
" 例如在.wiki中refer了一个名为my.cpp的文件，会被默认扩展为my.cpp.html，
" 这个选项告诉Vimwiki，对设置了的文件类型不进行扩展
let g:vimwiki_file_exts = 'c, cpp, wav, txt, h, hpp, zip, sh, awk, ps,doc,,php,zip,rar,7z,html,gz,jsp'
" 为Vimwiki定义快捷键
nmap <F10> :Vimwiki2HTML<CR>
nmap <F11> :VimwikiAll2HTML<CR>
" 配置多个项目
" let g:vimwiki_list = [{'path':'d:/vimwiki/'}, {'path':'d:/pwiki'}]
" 禁用驼峰形式生成wiki页面
let g:vimwiki_camel_case = 0
" 自定义的HTML页面不被删除如果手动创建如下的HTML文件，不会被删除
let g:vimwiki_user_htmls = 'contact.html, canvas-1.html, html.html'
" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 下面取消vimwiki菜单
let g:vimwiki_menu = ''
" 是否开启按语法折叠  会让文件比较慢
"let g:vimwiki_folding = 1
" 是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_CJK_length = 1
" 有效的html标记 
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
" 启用鼠标
let g:vimwiki_use_mouse = 1
"对[]中的选中切换
map<S-Space> <Plug>VimwikiToggleListItem
"你可能不喜欢文件名中包含空格（就像其他 vimwiki 用户一样），如果这样，你可以设置将那些坏字符转换为指定的字符
let g:vimwiki_badsyms = ' '
"在Windows你不能使用/*?<>" 作为文件名，所以 vimwiki 替换它们为_
let g:vimwiki_stripsym = '_'
"0 关闭标题的编号。
"1 开启标题的编号。编号从一级标题开始。
"2 开启标题的编号。彪悍从二级标题开始。
let g:vimwiki_html_header_numbering = 1
"每一行显示日期链接的最大数目。
let g:diary_link_count=5
"}}}

"nathanaelkane/vim-indent-guide{{{
Bundle 'nathanaelkane/vim-indent-guides' 
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle
"}}}

"主题altercation/vim-colors-solarized {{{
    Bundle 'altercation/vim-colors-solarized'
    "let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"

    colorscheme solarized
"}}}

"'kshenoy/vim-signature' {{{
Bundle 'kshenoy/vim-signature'
let g:SignatureMap={ 
    \'Leader':"m", 
    \'PlaceNextMark':"m,", 
    \'ToggleMarkAtLine':"m.",
    \'PurgeMarksAtLine': "m-",
    \'DeleteMark':"dm",
    \'PurgeMarks':"mda",
    \'PurgeMarkers':"m<BS>",
    \'GotoNextLineAlpha':"']",
    \'GotoPrevLineAlpha':"'[",
    \'GotoNextSpotAlpha':"`]",
    \'GotoPrevSpotAlpha':"`[",
    \'GotoNextLineByPos':"]'",
    \'GotoPrevLineByPos':"['",
    \'GotoNextSpotByPos':"mn",
    \'GotoPrevSpotByPos':"mp",
    \'GotoNextMarker':"[+",
    \'GotoPrevMarker':"[-",
    \'GotoNextMarkerAny':"]=",
    \'GotoPrevMarkerAny':"[=",
    \'ListLocalMarks':"ms",
    \'ListLocalMarkers':"m?"} 
"}}}

"}}}
