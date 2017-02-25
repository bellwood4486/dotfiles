" OSの判定
if has('win32')
  let ostype = "Win"
elseif has('mac')
  let ostype = "Mac"
else
  let ostype = system("uname")
endif

" フォントの設定
if ostype == "Win"
  " フォント名に全角文字を場合は一時的にエンコードをcp932に変更する
  " set encoding=cp932
  if hostname() ==? "yoga260"
    set guifont=Consolas:h11
    set guifontwide=Migu_1M:h11
  else
    set guifont=Consolas:h9
    set guifontwide=MeiryoKe_Gothic:h9
  endif
elseif ostype == "Mac"
  set guifont=Ricty\ Discord\ Regular:h14
  set guifontwide=Ricty\ Discord\ Regular:h14
endif
set ambiwidth=double

" エンコード
set encoding=utf-8

" メニュー非表示
set guioptions-=m
" ツールバー非表示
set guioptions-=T
" gvim(Kaoriya版)のメニューが化ける問題の対策
" See : http://sea-mountain.hatenablog.jp/entry/20100906/1283792259
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

" タブページを常に表示
set showtabline=2

" カラースキーム
set background=dark
colorscheme hybrid

" ウィンドウの位置とサイズを終了時に保存
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif

"
" キーマップ関連
"
" gvimrcを開く & 即座にリロード
nnoremap <Space>g.  :<C-u>edit $MYGVIMRC<CR>
nnoremap <Space>gs. :<C-u>source $MYGVIMRC<CR>
"ime setting
if has('kaoriya')
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
  set iminsert=0 imsearch=0
endif
" IME切り替え
inoremap <silent> <C-j> <C-^>

" IMEの状態でカーソルの色を変える
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

" ビープの設定
" 参考：http://vimblog.hatenablog.com/entry/vimrc_set_bell_options
"
"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

