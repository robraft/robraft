"file: vimrc, Customize Vim Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required

" TODO  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vimcolors.com/
" https://devhub.io/repos/uhub-awesome-viml
" https://github.com/tlhunter/vimrc
" http://vim.wikia.com/wiki/Use_Vim_like_an_IDE
" https://stackoverflow.com/questions/3232518/how-to-update-vim-to-color-code-new-html-elements
" https://www.vim.org/scripts/script.php?script_id=3232
" https://www.vim.org/scripts/script.php?script_id=3236
" }}}

" GLOBAL CONFIG SWITCHES   {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rr_use_autoc = 0
let g:rr_use_cygwin= 0
let g:rr_use_sql = 0
let g:rr_use_syntastic = 0
  let g:rr_use_markdown = 0
  let g:rr_use_web = 0
" }}}

" DEFINE AUTOCMD GROUP   {{{1
""" @see http://rbtnn.hateblo.jp/entry/2014/12/28/010913
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  augroup vimrc
    autocmd!
  augroup END
endif  " }}}

" LOAD PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.vim/vimrc_plugins

" Convenience Mappings   {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't use Ex mode, use Q for formatting
map Q gq
nmap <Leader>XX  :tabedit ++bin $HOME/.vimrc <Enter>
command XX   :tabedit ++bin $HOME/.vimrc
nmap gxx :tabedit ++bin $HOME/.vimrc <Enter>
nmap gbf :execute ":normal a" . fnamemodify(@%, ":t") . "\\e" <Enter>
nmap gbs :execute ":normal a" . strftime("%Y-%b-%d, rwr ") <Enter>
nmap gmd :call Markdown() <Enter>
nmap gfv :call TidyVim() <Enter>
command BW execute My_Wipe_Hidden_Unloaded_Buffers()

" FUNCTION Wipe_Hidden_Unloaded_Buffers   {{{2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if ! exists("*My_Wipe_Hidden_Unloaded_Buffers")
  function My_Wipe_Hidden_Unloaded_Buffers()
    " capture output from ':ls u' into local variable
    redir => l:unloaded_buffers
      " silent ls uh-
      silent ls u
    redir END

    " define list of buffers
    let l:buflist=[]

    " split output from ':ls u' into individual lines
    for l:buffer in split(l:unloaded_buffers, '\n')
      " the first sequence of digits is the buffer #
      call add(l:buflist, matchstr(l:buffer,'\d\+'))
    endfor

    let l:return_this = 'echo "nothing to do"'
    if ! empty(l:buflist)
      let l:return_this = 'bwipeout ' . join(l:buflist)
    endif

    return l:return_this
  endfunction
endif  " }}}
"}}}

" ASSORTED SETTINGS  {{{1
""" @see :h sh-embed
""" @see :h sh.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mapleader='\'             " The Elusive MapLeader character
let g:is_bash = 1               " default shell scripts to Bash syntax
let g:sh_minlines = 250         " fine-tune syntax highlighting for Bash
set autowriteall                " write contents of file if modified
set clipboard=unnamed           " Use global/X11 clipboard
set backspace=indent,eol,start  " Backspacing over everything in insert mode
set cpoptions=aceFs             " Compatability options  -> :h 'cpoptions'

set diffopt=filler,iwhite  " diff settings  -> :h 'diffopt'
set history=500            " command line history
set incsearch              " do incremental searching
set ignorecase             " ignore case in search patterns
set smartcase              " override 'ignorecase' when upper case in search
set linebreak              " wrap long lines based on chars in  'breakat'
set nowrap                 " disable wrapping display of long lines
set mouse=a                " mouse works fine in most terms, enable it.
set showcmd                " display incomplete commands
                           " 'listchars' is overwritten in gvimrc
set listchars=nbsp:^,eol:$,tab:>-,trail:_,extends:>,precedes:<
"}}}

" FOLDING {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("folding")
  set foldenable
  set foldcolumn=2
  set foldmethod=marker
endif
" }}}

" INDENTING   {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent   " always set autoindenting on
set smartindent
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" @see :h indent_guides
" @see :Plug 'nathanaelkane/vim-indent-guides'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_space_guides = 1
let g:indent_guides_tab_guides = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_indent_levels = 8
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

if has("autocmd")
  " ON ALL FILES
  "" @see :tab h indent_guides.txt
  "" @see 'nathanaelkane/vim-indent-guides'
  autocmd vimrc VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgrey guibg=#555555
  autocmd vimrc VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey guibg=#555555
endif
"}}}

" CURSORLINE, LINE NUMBERS, SPLIT  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
" set splitright
set number
if v:version > 700
  set cursorline
endif "}}}

" NETRW  {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle = 3   " vertical tree list style for :Explore
let g:netrw_alto = 0        " if set, horizontal split to the bottom
let g:netrw_altv = 1        " if set, vertical split to the right
let g:netrw_winsize = 40
let g:netrw_preview = 1
let g:netrw_cygwin = g:rr_use_cygwin  " is  scp is from cygwin ?
let g:netrw_browse_split = 2 " split on browse: 1=horiz, 2=vert, 3=tab
let g:netrw_bufsettings="noma nomod nobl nowrap ro bh=wipe bt=nowrite cc=0 nocul"

if has("autocmd")
  autocmd vimrc FileType netrw  setlocal cursorline
endif
"}}}

" HANDLE UTF-8 Intelligently {{{1
""" @see http://vim.wikia.com/wiki/Working_with_Unicode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=utf-8,ucs-bom,latin1
endif

if &fileencoding =~# 'utf-8'
  scriptencoding utf-8
  set listchars+=nbsp:º
  scriptencoding
endif  "}}}

" CMD HEIGHT  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if winheight(0) > 49
  set cmdheight=6
elseif winheight(0) > 39
  set cmdheight=4
elseif winheight(0) > 30
  set cmdheight=3
elseif winheight(0) > 20
  set cmdheight=2
endif  "}}}

" TABLINE Settings {{{1
" ShowTabLine:
""" 0:never 1:if more than one tab page 2: always
set showtabline=1
" also, @see COLORSCHEME SETTINGS
" }}}

" STATUSLINE Settings {{{1
""" @see http://vim.wikia.com/wiki/Show_fileencoding_and_bomb_in_the_status_line
""" sql filetype display [userid,dbtype-srvname] in statusline
""" from dbext plugin  TODO: Update to use tpope/dadbob plugin
""" TODO: @see https://github.com/tpope/vim-flagship
""" TODO: @see https://github.com/tpope/vim-fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set ruler   " show the cursor position all the time
if has("statusline")
  """ [filetype] filename [modified-flag] [readonly-flag]
  set statusline=%.10y%<\ %f\ %m%r
  """ @see :h fugitive-statusline
  set statusline+=\ %{FugitiveStatusline()}
  """ if filetype==sql (srvname.dbtype,user)
  """ set statusline+=%{(&filetype==\"sql\"?tolower(\"\ (\".DB_listOption(\"user\").\",\".DB_listOption(\"type\").\"-\".DB_listOption(\"srvname\").\")\"):\"\")}
  set statusline+=%{(&filetype==\"sql\"?tolower(\"\ (\".DB_listOption(\"srvname\").\"\.\".DB_listOption(\"type\").\",\".DB_listOption(\"user\").\")\"):\"\")}
  """ divider for right-justified right-half of the statusline
  set statusline+=%=
  """ lines,columns  loc%
  set statusline+=%k\ \ %l,%c\ \ %P
  """ fileencoding blah blah blah
  set statusline+=\ \ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\",\".\&ff.\"]\ \"}
endif "}}}

" COLORSCHEME Settings  {{{1
""" when the terminal has colors
""" Also switch on highlighting the last used search pattern.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype plugin indent on """ already handled by vim-plug
" syntax on                 """ already handled by vim-plug
set synmaxcol=9999
set hlsearch
set termguicolors    " enable True Color   @see :h xterm-true-color
set background=dark
if has("autocmd")
  augroup myColors
  au!
  augroup END
endif

colorscheme default
if $TERM != "screen"
" colorscheme grb256    " {{{2
if has("autocmd")
  "" ColorColumn a pleasing light grey
  set colorcolumn=80
  au myColors ColorScheme grb256 hi ColorColumn ctermbg=darkgrey guibg=#333333

  "" TODO Highlighting
  au myColors ColorScheme grb256 hi Todo term=standout ctermfg=black ctermbg=yellow guifg=Blue guibg=Yellow
  "" Tab Line
  au myColors ColorScheme grb256 hi TabLine term=bold,reverse cterm=bold ctermfg=81 ctermbg=darkgrey gui=bold guifg=darkblue guibg=darkgrey
  au myColors ColorScheme grb256 hi TabLineSel term=reverse cterm=bold ctermfg=black ctermbg=81 gui=bold guifg=grey guibg=darkblue
  au myColors ColorScheme grb256 hi TabLineFill term=bold,reverse cterm=bold ctermfg=81 ctermbg=darkgrey gui=bold guifg=darkblue guibg=darkgrey
  "" @see :tab h 'number'
  au myColors ColorScheme grb256 hi LineNr guifg=#888888
  " au myColors ColorScheme grb256 hi CursorLineNr

  if has("folding")
    "" @see :tab h fold-options
    " hi FoldColumn guibg=darkgrey guifg=white
    au myColors ColorScheme grb256 hi FoldColumn guibg=#555555
  endif

  if has("signs")
    "" @see :tab h 'signs'
    au myColors ColorScheme grb256 hi SignColumn guibg=#555555
  endif
endif
colorscheme grb256    " }}}

" colorscheme gruvbox  " {{{2
" let g:gruvbox_bold = 1
" let g:gruvbox_italic = 1
" let g:gruvbox_underline = 1
" let g:gruvbox_undercurl = 1
" let g:gruvbox_contrast_dark = 'hard'    " possible values: soft, medium, hard
" let g:gruvbox_contrast_light= 'hard'    " possible values: soft, medium, hard
" }}}

" colorscheme koehler  " {{{2
" "" Status Line
" hi StatusLine term=bold,reverse cterm=bold ctermfg=white ctermbg=darkgrey gui=bold guifg=blue guibg=white
" hi StatusLineNC term=bold,reverse cterm=bold ctermfg=cyan ctermbg=darkgrey gui=bold guifg=blue guibg=white
" hi StatusLineTerm term=bold,reverse cterm=bold ctermfg=0 ctermbg=121 gui=bold guifg=bg guibg=LightGreen
" hi StatusLineTermNC term=reverse ctermfg=0 ctermbg=121 guifg=bg guibg=LightGreen
" "" Tab Line
" hi TabLine term=bold,reverse cterm=bold ctermfg=81 ctermbg=darkgrey gui=bold guifg=blue guibg=white
" hi TabLineSel term=reverse cterm=bold ctermfg=black ctermbg=81 gui=bold guifg=white guibg=blue
" hi TabLineFill term=bold,reverse cterm=bold ctermfg=81 ctermbg=darkgrey gui=bold guifg=blue guibg=white
" "" TODO Highlighting
" hi Todo term=standout ctermfg=black ctermbg=yellow guifg=Blue guibg=Yellow
" "" ColorColumn a pleasing light grey
" if has("+colorcolumn")
"   set colorcolumn=80
"   hi ColorColumn ctermbg=darkgrey guibg=#555555
" else
"   autocmd vimrc BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" endif
" }}}
endif
"}}}

" VIM STARTUP & WINDOW RESIZE LOGIC {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " ON WINDOW RESIZE-> Resize window splits
  """ Thank you https://github.com/spicycode/Vimlander-2-The-Quickening
  autocmd vimrc VimResized * exe "normal! \<c-w>="

  " TODO: ON VIM STARTUP-> open :Lexplore
  """ augroup VimStartup
  """   au!
  """   au VimEnter * if expand("%") == "" && argc() == 0 &&
  """   \ (v:servername =~ 'GVIM\d*' || v:servername == "")
  """   \ | 30Lexplore . | endif
  """ augroup END
endif
"}}}

" FILE OPEN & LOAD LOGIC  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " ON EDITING A FILE-> Jump to last known cursor position.
  """ Don't do it when position is invalid or when inside an
  """ event handler (happens when dropping a file on gvim).
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  autocmd vimrc BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \	  exe "normal! g`\"" |
    \ endif

  " MODELINE-> I want my freakin modeline
  """ (hack to force ':nmap gxx' to process the modeline)
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " autocmd vimrc TerminalOpen * set modeline
  " autocmd vimrc BufRead      * set modeline

  " ON *.md FILES-> default to MarkDown (not Modula-2)
  autocmd vimrc BufNewFile,BufReadPost *.md set filetype=markdown

  " ON ALL FILETYPES (I got really tired of typing this all the time)
  autocmd vimrc FileType * syn sync fromstart

  " ON TEXT FILES-> Set 'textwidth' to 80 characters.
  autocmd vimrc FileType text setlocal textwidth=80

  " ON HELP FILES
  if exists("colorcolumn")
    autocmd vimrc FileType help  setlocal colorcolumn=0 nocursorline
  endif
  if has("folding")
    autocmd vimrc FileType help,netrw  setlocal foldcolumn=0
  endif
  if has("signs")
    autocmd vimrc FileType help,netrw  setlocal signcolumn=auto
  endif

  " ON VIM FILES-> Set tabstops
  autocmd vimrc FileType vim setlocal ts=2 sts=2 sw=2 expandtab

  " ON SHELL SCRIPTS-> Set tabstops
  autocmd vimrc FileType sh setlocal ts=4 sts=4 sw=4 expandtab

endif
"}}}

" FILE BACKUP & SAVE LOGIC  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTION StripTrailingWhitespace   {{{2
""" Strip trailing whitespace, and remember cursor position
""" Thank you https://github.com/spicycode/Vimlander-2-The-Quickening
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if ! exists("*My_StripTrailingWhitespaces")
  function My_StripTrailingWhitespaces()
    let l:l = line(".")
    let l:c = col(".")
    %g/\s\+$/s///e
    call cursor(l:l, l:c)
    unlet l:l l:c
  endfunction
endif  " }}}

if has("autocmd")
  " ON FILE SAVE-> Strip trailing whitespace on save
  """ Thank you https://github.com/spicycode/Vimlander-2-The-Quickening
  autocmd vimrc BufWritePre * :call My_StripTrailingWhitespaces()
endif

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  " Save backups in directory $HOME/tmp/YYYY-MM.vim  --  make dir as needed
  "------------------------------------------------------------------------
  let s:my_bkdir = $HOME . '/tmp/' . strftime('%Y-%m') . '.vim'
  if empty(glob(s:my_bkdir))
    execute "silent !mkdir -p " . s:my_bkdir
  endif
  let &backupdir = s:my_bkdir
  unlet s:my_bkdir
  set backup    " keep a backup file
  if has("autocmd")
    " Use a timestamp as a backup extension
  "------------------------------------------------------------------------
    autocmd vimrc BufWritePre * let &bex = '.' . strftime('%Y-%m-%d_%H%M') . '~'
  endif
endif  " }}}

" SYNTASTIC   {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("g:rr_use_syntastic") && g:rr_use_syntastic
  " @see :tab h syntastic.txt
  " @see :tab h syntastic-checkers
  " @see http://www.vim.org/scripts/script.php?script_id=2736

  "" ENABLE SELECTED SYNTAX CHECKERS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:syntastic_lua_checkers = ['luac','luacheck']
  let g:syntastic_vim_checkers = ['vimlint']
  let g:syntastic_yaml_checkers = ['yamllint']

  "" ADD SYNTASTIC TO STATUSLINE
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if has("statusline")
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
  endif

  "" ENABLE SYNTASTIC 'SIGNS'
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if has("signs")
    set signcolumn=yes  " always display the sign column
    let g:syntastic_enable_signs = 1
  endif

  "" ENABLE BALLOON MESSAGES
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  if has("balloon_eval_term") || has("balloon_eval")
    let g:syntastic_enable_balloons = 1
  endif

  "" TWEAK SYNTASTIC SETTINGS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 0
  let g:syntastic_aggregate_errors = 1
  let g:syntastic_echo_current_error = 1
  let g:syntastic_cursor_column = 0
  let g:syntastic_auto_jump = 1
endif  " }}}

" SQL SYNTAX & PLUGIN Settings   {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("g:rr_use_sql") && g:rr_use_sql && ! exists("*SQLFixCase")
  "////////////////////////////////////////////////////////////////////////////
  "/// DBEXT PLUGIN SETTINGS and CONNECTION PROFILES
  "////////////////////////////////////////////////////////////////////////////

  "" SQL: sample dbext modeline...
  "" --  dbext:profile=p411_dv03737
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:dbext_default_profile_tutorial     = 'type=SQLITE:SQLITE_bin=/usr/bin/sqlite3:host=local:dbname=~/proj/aba_report/sql/tutorial.db'
  let g:dbext_default_use_result_buffer     = 1
  let g:dbext_default_use_sep_result_buffer = 0
  let g:dbext_default_replace_title         = 0
  let g:dbext_default_use_win32_filenames   = 1
  let g:dbext_default_window_use_horiz      = 1
  let g:dbext_default_window_use_bottom     = 0
  let g:dbext_default_use_sep_result_buffer = 1
  let g:dbext_default_replace_title = 1
  let g:dbext_default_use_win32_filenames = 1
  let g:dbext_default_window_use_horiz = 0
  let g:dbext_default_window_use_right = 1
  let g:dbext_default_window_width = 30

  "" SQLUTIL PLUGIN SETTINGS
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:sqlutil_keyword_case = '\U'
  let g:sqlutil_indent_nested_blocks = 1
  let g:sqlutil_wrap_long_lines = 1
  let g:sqlutil_split_unbalanced_paran = 1

  if has("autocmd")
    " for Oracle SQLPlus editing...
    autocmd vimrc BufReadPre _sqlplus.sql set lines=24
  endif

  "" SQLFixCase
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  command SQLFixCase :call SQLFixCase()
  nmap gfs :call SQLFixCase() <Enter>

  function SQLFixCase()
    "" UPPERCASE SQL and SQL*Plus keywords and column/table qualifiers
    "" Camelcase the SQL Column Names
    "" (skips lines containing comments and lines containing a string literal)
    "" ln 01. mark current location in document
    "" ln 02. lowercase everything
    "" ln 03. title case column names
    "" ln 04. uppercase 2 char 'chunks'
    "" ln 05-11. uppercase common sql and sql*plus keywords
    "" ln 12. uppercase column/table qualifiers - non-blank text directly preceding a dot.
    "" ln 13. uppercase table aliases in from-clause
    "" ln 14. return to previously marked location in document
    :normal mz
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/[A-Z]/\L&/g
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v([A-Za-z0-9_]+\.)@!(_|\.|<)@<=[a-z]/\u&/g
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v[A-Z][a-z]([ _,\t\n])@=/\U&/g

    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v<(select|update|insert)>/\U&/gi
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v<(create|delete|alter)>/\U&/gi
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v<(union|minus|commit|distinct)>/\U&/gi
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v<(from|where|group|having)>/\U&/gi
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v<(order|by|asc|desc|nulls)>/\U&/gi
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v<(and|not|null|in|is|as)>/\U&/gi
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v<(set|first|into)>/\U&/gi

    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v([a-z0-9_]+)(\.)@=/\U&/gi
    :silent! g!/\/\*\|\*\/\|^ *\*\|'\|"|--/s/\v(([A-Z0-9_]+)(\.)([A-Za-z0-9_]+)( +))@<=<([A-Z][a-z0-9]+)>/\U&/gi
    :normal `z
  endfunction
endif   " }}}

" MARKDOWN SYNTAX  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only define the function(s) and commands once.
if exists("g:rr_use_markdown") && g:rr_use_markdown && ! exists("*Markdown")
  command HI  :echon " autoindent="&ai " smartindent="&si " cindent="&ci
               \ " cpoptions="&cpo "<NL> indentexpr="&inde "<NL> expandtab="&et
               \ " ts="&ts " sts="&sts " sw="&sw

  let g:markdown_minlines = 100
  let g:markdown_fenced_languages = ['bash=sh', 'css', 'javascript', 'js=javascript', 'json=javascript', 'vim', 'xml']
  let g:scratch_filetype = 'markdown'
  let g:scratch_autohide = &hidden
  let g:scratch_insert_autohide = 0

  function Markdown()
    ":silent exec '!Markdown.pl --html4tags "' . expand('%:p') . '" > "' . expand('%:p') . '.html"'
    if has("X11")
      """ if ! exists(expand("%:p:h") . "/html")
      """   :silent exec '!mkdir "' . expand("%:p:h") . '/html"'
      """ endif
      """ :silent exec '!pandoc -f markdown -t html --ascii -S --email-obfuscation=none --section-divs --output $(cygpath -w "' . expand('%:p:h') . "/html/" . expand("%:p:t:r") . '.html") $(cygpath -w "' . expand('%:p') . '")'
      :silent exec '!pandoc -f markdown -t html --ascii -S --email-obfuscation=none --section-divs --output $(cygpath -w "' . expand('%:p:h') . "/" . expand("%:p:t:r") . '.html") $(cygpath -w "' . expand('%:p') . '")'
    else
      """ if ! exists(expand("%:p:h") . "\\html")
      """   :silent exec '!mkdir "' . expand("%:p:h") . '\\html"'
      """ endif
      """ :silent exec '!pandoc -f markdown -t html --ascii -S --email-obfuscation=none --section-divs --output "' . expand('%:p:h') . "\\html\\" . expand("%:p:t:r") . '.html" "' . expand('%:p') . '"'
      :silent exec '!pandoc -f markdown -t html --ascii -S --email-obfuscation=none --section-divs --output "' . expand('%:p:h') . "\\" . expand("%:p:t:r") . '.html" "' . expand('%:p') . '"'
    endif
    :echomsg "[pandoc] See file '" . expand('%:p:~:.:r') . ".html'"
  endfunction

  "-- ----------------------------------------------------------------------------
  "-- https://stackoverflow.com/users/249630/lucapette
  "-- https://stackoverflow.com/questions/9212340/is-there-a-vim-plugin-for-previewing-markdown-files
  "-- ----------------------------------------------------------------------------
  function MarkdownPreview()
    silent update
    let output_name = tempname() . '.html'

    let file_header = ['<html>', '<head>',
          \ '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">',
          \ '<title>'.expand('%:p').'</title>',
          \ '<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset-min.css">',
          \ '<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.3.0/build/cssbase/base-min.css">',
          \ '<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts-min.css">',
          \ '<style>body{padding:20px;}div#container{background-color:#F2F2F2;padding:0 20px;margin:0px;border:solid #D0D0D0 1px;}</style>',
          \ '</head>', '<body>', '<div id="container">']

    call writefile(file_header, output_name)

    silent exec '!Markdown.pl "' . expand('%:p') . '" >> "' . output_name . '"'
    silent exec '!echo "</div></body></html>" >> "' . output_name . '"'
    silent exec '!cmd /c start "' . output_name . '" &'
  endfunction

  inoremap <buffer> <F7> <ESC>:call MarkdownPreview()<CR>
  nmap <buffer> <F7> :call MarkdownPreview()<CR>
endif   " }}}

" FUNCTION MYDIFF   {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if ! exists("*MyDiff")
  " Only define the function(s) and commands once.

  "-----------------------------------------------------------------------------
  "-- Convenient command to see the difference between the current buffer and the
  "-- file it was loaded from, thus the changes you made.
  "-----------------------------------------------------------------------------
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis

  "-- set diffexpr=MyDiff()
  function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        let cmd = '""' . $VIMRUNTIME . '\diff"'
        let eq = '"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
  endfunction
endif  " }}}

" PRINTING Settings  "{{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set printfont=Courier_New:h9
set printoptions=left:0.3in,right:0.25in,duplex:on,portrait:y
set printheader=%<%f%h%m%=%{strftime('%c')}\ \ \ \ Page\ %N "}}}

" WHAT TO SAVE IN ':MKSESSION'  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:version > 700
  set sessionoptions=blank,buffers,folds,globals,help,resize,sesdir,tabpages,winsize,winpos
endif  "}}}

" CRYPTO  {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cryptv")
  set cryptmethod=blowfish
endif "}}}

" vim: set filetype=vim :
