" VIM Run Commands: :w
" source $VIMRUNTIME/vimrc_example.vim
" in Windows _vimrc
" in Ubuntu init.vim
" in Ubunutu this file 'virmc.local' --, should be in /etc/vim

" Windows MyDiff() {{{1
set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg1 = substitute(arg1, '!', '/!', 'g')
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg2 = substitute(arg2, '!', '/!', 'g')
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let arg3 = substitute(arg3, '!', '/!', 'g')
	if $VIMRUNTIME =~ ' '
		if &sh =~ '/<cmd'
			if empty(&shellxquote)
				let l:shxq_sav = ''
				set shellxquote&
			endif
			let cmd = '"' . $VIMRUNTIME . '/diff"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '/diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '/diff'
	endif
	let cmd = substitute(cmd, '!', '/!', 'g')
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
	if exists('l:shxq_sav')
		let &shellxquote=l:shxq_sav
	endif
endfunction " }}}

" Setting displayed and saved encoding --pjp
set encoding=utf-8  " The encoding displayed. Default is =latin1
set fileencoding=utf-8  " The encoding written to file.  Default is =""


" Selecting coding & Chinese fonts --pjp
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata/ 12		" fonts for non Mac and non Windows
	elseif has("gui_win32")
		set guifont=Consolas:h14
		set guifontwide=NSimSun:h16		" fonts for Windows
	elseif has("gui_macvim")
		set guifont=Menlo/ Regular:h14	" fonts for Mac
	endif
endif


" Turn off physical line wrapping for .txt files --pjp
" set textwidth=0
autocmd FileType text setlocal textwidth=0 " works better


" Stop wrapping lines in the middle of a word --pjp
set lbr


" Setting spell language to English, French, cjk (Chinese-Japanese-Korean) --pjp
set spelllang=en_us,fr,cjk


" Setting spell file to add good words --pjp
set spellfile=/home/perubu/.vim/site/spell/pjp.utf-8.add


" number lines --pjp
set number
set relativenumber	" Show line number on the current line and relative numbers on all other lines. Works only if number is enabled.
augroup toggle_relative_number
	autocmd InsertEnter * :setlocal norelativenumber
	autocmd InsertLeave * :setlocal relativenumber


	" error bells --pjp
	set errorbells	" Disable beep on errors.
	set visualbell	" Flash the screen instead of beeping on errors.


	" set the default directory listing view style --pjp
	let g:netrw_liststyle = 1

	" set swap, backup, undo file directories & tags file --pjp
	set tags=$VIMRUNTIME/doc/tags
if has('win32')
	set directory=$HOME/vimfiles/swap//
	set backupdir=$HOME/vimfiles/backup//
	set undodir=$HOME/undo//
	set viewdir=$HOME/view//
else
	set directory=$HOME/.vim/swap//
	set backupdir=$HOME/.vim/backup//
	set undodir=$HOME/.vim/undo//
	set viewdir=$HOME/.vim/view//
endif


" automatically save and load fold views --pjp
augroup AutoSaveFolds
	autocmd!
	" view files are about 500 bytes
	" bufleave but not bufwinleave captures closing 2nd tab
	" nested is needed by bufwrite* (if triggered via other autocmd)
	" The BufWritePost event (+ nested) can be left out if you prefer, though you will experience no penalty for leaving it in.
	autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
	autocmd BufWinEnter ?* silent! loadview
augroup end
set viewoptions=folds,cursor
set sessionoptions=folds


" Splits --pjp
" let g:netrw_browse_split = 2 " keep netrw in a side split --pjp
" let g:netrw_winsize = 20 " set the width of netrw window --pjp
set splitright 


" set vertical offset to zero when scrolling --pjp
set scrolloff=0


" Wipe all registers --pjp
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor


" Change Current Working Directory to the one of the file which was opened or selected --pjp
set autochdir


" Quick Change Dirs --pjp
if has('win32')
	command! CdVimbuf cd ~/Documents/vimbuf
	command! CdProVim cd  /Program Files (x86)/vim
	command! CdNotes  cd ~/Documents/1./ Perso/Notes/ -/ Synthèses/ -/ Flashcards/
endif

" Ctrl-P.......
" set runtimepath=~/.vim/plugin/ctrlp.vim,~/.vim,"C:/Program Files (x86)/Vim/.vim","C:/Program Files (x86)/Vim/vim81","C:/Program Files (x86)/Vim/vim81/pack/dist/opt/matchit","C:/Program Files (x86)/Vim/.vim/after",~/.vim/after  ne fonctionne pas bien
" set runtimepath^=~/.vim/bundle/synstastic.vim

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


" Grammalecte
" let g:grammalecte_cli_py='C:/users/perubu/appdata/roaming/python/python37/scripts/grammalecte-cli.py'
" let g:grammalecte_cli_py='C:/Python37/Scripts/grammalecte-cli.py'

" Maximize window at startup under MS Windows --pjp
autocmd GUIEnter * simalt ~x

" Neovim for linux
" on could put these in .bashrc
" export VIMCONFIG='~/.config/nvim'
" export VIMDATA='~/.vim'

"colorscheme murphy " black background
"colorscheme delek	" light yellow background, some colors unclear
colorscheme default

" Setting up for python 3
" let g:python_host_prog = '/home/perubu/.cache/vim/venv/neovim2/bin/python'
" let g:python3_host_prog = '/home/perubu/.cache/vim/venv/neovim3/bin/python'
let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/bin/python3.8'

" To write files even in RO mode
cnoremap w!! execute 'silent! write !sudo tee %>/dev/null' <bar> edit!

" Adding a package
packadd! matchit

" Managing plugins with minpac
if has('nvim')
	packadd minpac
	call minpac#init()

	" Adding, Updating plugins with minpac
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('janko-m/vim-test')
	call minpac#add('plytophogy/vim-virtualenv', {'type': 'opt'})
	call minpac#add('tpope/vim-unimpaired', {'type': 'opt'})
	call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
	call minpac#add('altercation/vim-colors-solarized', {'type': 'opt'})
	" Updating plugins
	" :call minpac#update()
	" :messages
	" Deleting plugins
	"   erase line
	"   :call minpac#clean()
endif

" Tweaks to Terminal mode
if has('nvim')
	" Switching between Terminal mode and Normal mode
	tnoremap <Esc> <C-\><C-n>
	tnoremap <C-v><Esc> <Esc>
	" Coloring the terminal cursor
	highlight! link TermCursor Cursor
	highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

" Adding xmllint as a map.  In command mode press @@x to lint XML file
" cnoremap xlt !%xmllint --format --recover -
cnoremap l!! %!xmllint --format --encode utf-8 --recover -


" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set ar

" vim:fdm=marker:
