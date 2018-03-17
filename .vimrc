" vim の独自拡張機能を使う(viとの互換性をとらない)
set nocompatible

" 画面表示 {{{
" 参考：http://vimblog.hatenablog.com/entry/vimrc_set_display_options
"
set number " 行番号を表示する
set ruler " 画面右下のカーソル位置表示
set cursorline " カーソル行の背景色を変える
set laststatus=2 " 画面下部ステータス行の表示
set cmdheight=2 " コマンドラインの行数
set showmatch " 括弧入力時に対応する括弧を強調する
" set helpheight=999 " ヘルプ画面の行数
set list " 不可視文字の表示
set listchars=tab:>\ ,trail:~  " 不可視文字の表示に使う文字
syntax on " 構文ごとに色分け表示する
set wrap " ウィンドウ幅で行を折り返す
" }}}

" カーソル移動 {{{
" 参考：http://vimblog.hatenablog.com/entry/vimrc_set_cursor_movement_options
"
set backspace=indent,eol,start "Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set scrolloff=8                "上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
" }}}

" ファイル処理 {{{
" 参考：http://vimblog.hatenablog.com/entry/vimrc_set_file_handling_options
"
set confirm "保存されていないファイルがあるときは終了前に保存確認
set hidden "保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread "外部でファイルに変更がされた場合は読みなおす
set nobackup "ファイル保存時にバックアップファイルを作らない
set noswapfile "ファイル編集中にスワップファイルを作らない
set noundofile " Undoファイルを作らない
" }}}

" 検索/置換 {{{
" 参考：http://vimblog.hatenablog.com/entry/vimrc_set_search_replace_options
"
set hlsearch "検索文字列をハイライトする
set incsearch "インクリメンタルサーチを行う
set ignorecase "大文字と小文字を区別しない
set smartcase "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan "最後尾まで検索を終えたら次の検索で先頭に移る
" }}}

" ビープ {{{
" 参考：http://vimblog.hatenablog.com/entry/vimrc_set_bell_options
"
set visualbell t_vb= "ビープ音すべてを無効にする
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない
" }}}

" コマンドライン {{{
" 参照：http://vimblog.hatenablog.com/entry/vimrc_set_cmdline_options
"
set wildmenu wildmode=list:longest,full " コマンドラインモードでTABキーによるファイル名補完を有効にする
set history=10000 " コマンドラインの履歴を10000件保存する
" }}}

" 動作環境との統合 {{{
" 参考：http://vimblog.hatenablog.com/entry/vimrc_set_environmental_options
"
set clipboard=unnamed,unnamedplus " OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set mouse=a " マウスの入力を受け付ける
set shellslash " Windows でもパスの区切り文字を / にする
" }}}

" タブ/インデント {{{
" 参照：http://vimblog.hatenablog.com/entry/vimrc_set_tab_indent_options
"
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=8 "画面上でタブ文字が占める幅
set shiftwidth=8 "自動インデントでずれる幅
set softtabstop=8 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
" set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
" }}}

" パッケージ管理 {{{
"
" NeoBundleは git submodule add でこのディレクトリ以下に取得しておく
if has('vim_starting')
  set runtimepath+=~/.dotfiles/neobundle.vim/
endif
" NeoBundleが取得するバンドルは、ドットファイルと同じ管理下には置かない。
call neobundle#begin(expand('~/.vim/bundle/'))
" NeoBundle自体をNeoBundleで管理する
NeoBundleFetch 'Shougo/neobundle.vim'
" 導入バンドル
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'kannokanno/previm' " markdownのプレビュー用
NeoBundle 'tyru/open-browser.vim' " markdownのプレビュー用
NeoBundle 'vitalk/vim-simple-todo'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'mrk21/yaml-vim'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim'
endif
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'aklt/plantuml-syntax'
NeoBundle 'elzr/vim-json'
NeoBundle 'ekalinin/Dockerfile.vim'
" テーマ
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jnurmine/Zenburn'
NeoBundle 'w0ng/vim-hybrid'
call neobundle#end()
filetype plugin indent on
" 起動時にインストールされていないバンドルがあればインストールするか確認する
NeoBundleCheck
" }}}

" vim-singleton {{{
" 起動中のvimプロセスでファイルを開く
if has('clientserver')
  call singleton#enable()
endif
" }}}

" neocomplete {{{
"
if has('lua')
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif
" }}}

" Unite {{{
"
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
" }}}

" lightline {{{
"
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"}}}

" カラースキーム {{{
"
" http://qiita.com/pepoipod/items/e058b098af389ddb451f
" autocmd ColorScheme * highlight Normal ctermbg=none
" autocmd ColorScheme * highlight LineNr ctermbg=none
" colorscheme hybrid
" colorscheme jellybeans
"}}}

" VimFiler {{{
"
let g:vimfiler_as_default_explorer = 1
"}}}

" simple-javascript-indenter {{{
"
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1
" }}}

" syntastic {{{
"
" jshintを必ず使ってチェック
" let g:syntastic_javascript_checker = "jshint"
" }}}

" autocmd設定 {{{
"
augroup MyAutoCmd
  autocmd!
  autocmd BufRead,BufNewFile *.md set filetype=markdown " markdown
  autocmd FileType {vim,xml,html,build,sh,zsh,javascript,css,plantuml,json} setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType {java,cpp} setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufEnter * silent! lcd %:p:h " set autochdirだとプラグインによっては動作しない場合があるため
  autocmd FileType gitcommit setlocal formatoptions=q
augroup END
"}}}

" キーマップ {{{
"
nnoremap j gj
nnoremap k gk
" <Leader>をカンマに割り当てる。See:http://deris.hatenablog.jp/entry/2013/05/02/192415
let mapleader = ","
" ,のデフォルトの機能は、\で使えるように退避
noremap \ ,
" unite
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]u :<C-u>Unite file_mru buffer<CR>
" vimrcを開く & 即座にリロード
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>
" help を開きすくする
nnoremap <C-h>      :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>
" 検索ハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>
" コマンド履歴のフィルタリングを<C-p>や<C-n>でもする。(TIP34)
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" バッファ移動を楽にする(TIP36)
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Pomodoroリストのカッコ()を(x)に置換する
nnoremap <silent> <C-l> :s/\(.\{-}\)()\(.*\)/\1(x)\2/<CR>:nohlsearch<CR>
" レジスタ/マークの確認を楽にする
" nnoremap <Space>m  :<C-u>marks
" nnoremap <Space>r  :<C-u>registers
" 最後に変更されたテキストを選択する
" nnoremap gc  `[v`]
" 選択されたHTMLをJavascriptの連結文字列表現にする
vmap <silent> ;h :s?^\(\s*\)+ '\([^']\+\)',*\s*$?\1\2?g<CR>
vmap <silent> ;q :s?^\(\s*\)\(.*\)\s*$? \1 + '\2'?<CR>
"}}}

" コマンド {{{
"
" 文字エンコーディングを指定してファイルを開き直す
command! -bang -nargs=? Utf8
\ edit<bang> ++enc=utf-8 <args>
" }}}

" 折りたたみ {{{
"
set foldmethod=marker
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

" OS独自設定の読み込み {{{
"
if has('unix')
  source ~/.vimrc_unix
endif

