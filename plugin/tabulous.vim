" tabulous.vim - Lightweight Vim plugin for setting the tabline including the tab page labels.
" File:          tabulous.vim
" Location:      plugin/tabulous.vim
" Author:        Steven Garcia <https://github.com/webdevel>
" Description:   Lightweight Vim plugin for setting the tabline including the tab page labels.
" Version:       0.5
" License:       GNU GPLv2
" GetLatestVimScripts: 5395 1 :AutoInstall: tabulous.vim

" TODO enable some keyboard shorcuts
" TODO enhance label truncation algorithm

" exit when plugin is already loaded,
" vi compatibility or vim version is insufficient
if exists('g:loadTabulous') || &compatible || v:version < 700

  finish

endif

let g:loadTabulous = 1

" inspired by similar nerd tree function
" initialize variables to sane defaults if not set already
function s:initVariable(var, val) abort

  if !exists(a:var)

    execute printf("let %s = \'%s\'", a:var, a:val)

    return 1

  endif

  return 0

endfunction

" initialize defaults
call s:initVariable('g:tabulousCloseStr', 'X')
call s:initVariable('g:tabulousLabelModifiedStr', '+')
call s:initVariable('g:tabulousLabelLeftStr', ' ')
call s:initVariable('g:tabulousLabelRightStr', ' ')
call s:initVariable('g:tabulousLabelNumberStr', ' ')
call s:initVariable('g:tabulousLabelNameLeftStr', '')
call s:initVariable('g:tabulousLabelNameOptions', ':t:r')
call s:initVariable('g:tabulousLabelNameDefault', '[No Name]')
call s:initVariable('g:tabulousLabelNameTruncate', 1)
let s:userTabLabelNameDict = {}

" build tabline and return it
" returns string representing tabline
function s:getTabline() abort

  let tablineStr = ''

  " get the tab page count
  let tabPageCount = tabpagenr('$')

  " get a tab number list. tab numbers start at one, not zero
  let tabNumList = range(1, tabPageCount)

  " iterate through the tab number list
  for tabNum in tabNumList

    let bufferNum = s:getCurrentBufferNumber(tabNum)

    " get buffer name using buffer number
    let bufferName = bufname(bufferNum)

    " get buffer-local variable that indicates whether buffer is modified
    let isBufferModified = getbufvar(bufferNum, '&mod')

    " whether to show the buffer modified hint or not
    let tabBufferModified = (isBufferModified ? g:tabulousLabelModifiedStr : '')

    " get the modified tab name or default tab name
    let tabNameStr = (bufferName != '' ? fnamemodify(bufferName, g:tabulousLabelNameOptions) : g:tabulousLabelNameDefault)

    " if user specified a tab label name for this buffer, use it
    let tabNameStr = has_key(s:userTabLabelNameDict, bufferNum) ? s:userTabLabelNameDict[bufferNum] : tabNameStr

    " used to adjust number of available columns
    " based on tab label length and tab count
    "let usedLength = (tabPageCount/tabCountDivisor)*tabPageCount + strlen(printf(
    let usedLength = tabPageCount * strlen(printf(
      \'%s%s%s%s%s%s%s',
      \g:tabulousLabelLeftStr,
      \tabNum,
      \g:tabulousLabelNumberStr,
      \tabBufferModified,
      \g:tabulousLabelNameLeftStr,
      \g:tabulousLabelRightStr,
      \g:tabulousCloseStr
    \))

    " divide columns by tab page count for even distribution
    let tabNameLengthMax = (&columns-usedLength)/(tabPageCount > 0 ? tabPageCount : 1)

    " make length a zero or greater number
    let tabNameLengthMax = (tabNameLengthMax > 0 ? tabNameLengthMax : 0)

    " build tab page label format specifier.
    " to enable calculation of tab name maximum length at runtime
    let tabFormatStr = printf(
      \'%s%d%s',
      \'%%%dT%s%s%d%s%s%s%.',
      \g:tabulousLabelNameTruncate ? tabNameLengthMax : &columns,
      \'s%s'
    \)

    "echom printf('%s: %s', 'TAB-NAME-LENGTH-MAX', tabNameLengthMax)

    " concatenate a single tab page label for this iteration
    " TabNumberToken, TabSelectedToken, TabLeftString, TabNumber, TabNumberString,
    " TabBufferModified, TabNameLeftString, TabFileName, TabRightString
    let tablineStr .= printf(
      \tabFormatStr,
      \tabNum,
      \(tabNum == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'),
      \g:tabulousLabelLeftStr,
      \tabNum,
      \g:tabulousLabelNumberStr,
      \tabBufferModified,
      \g:tabulousLabelNameLeftStr,
      \tabNameStr,
      \g:tabulousLabelRightStr
    \)

  endfor

  " after the last tab, fill with TabLineFill, reset tab page number,
  " right-align the label to close the current tab page and
  " return complete string representation of tabline
  return printf(
    \'%s%%#TabLineFill#%%T%s',
    \tablineStr,
    \(tabPageCount > 1 ? printf('%s%s', '%=%#TabLine#%999X', g:tabulousCloseStr) : '')
  \)

endfunction

" wrap in vendor specific function to avoid name conflicts
function! Tabulous() abort

  return s:getTabline()

endfunction

function s:setTabline() abort

  " since the number of tab labels will vary,
  " we need to use an expression when setting the tabline option
  set tabline=%!Tabulous()

endfunction

function s:setUserTabLabelName(name) abort

  " store user specified tab label name keyed by the current buffer number
  let s:userTabLabelNameDict[s:getCurrentBufferNumber(tabpagenr())] = a:name

  " set the tabline with the user specified tab label name
  call s:setTabline()

endfunction

function s:getCurrentBufferNumber(tabNum) abort

    " get the currently focused window number in the specified tab page
    let windowNum = tabpagewinnr(a:tabNum)

    " get a list of all buffer numbers in the specified tab page
    let bufferNumList = tabpagebuflist(a:tabNum)

    " get buffer number indexed by currently focused window number
    return bufferNumList[windowNum - 1]

endfunction

" event handler for buffer wipeout events.
" remove unused entries from user tab label names
function s:removeUserTabLabelName(bufferNum) abort

  if has_key(s:userTabLabelNameDict, a:bufferNum)

    unlet s:userTabLabelNameDict[a:bufferNum]

  endif

endfunction

" ask for a name and rename the current tab
function! g:tabulous#renameTab()
  call inputsave()
  let name = input('Enter new name: ')
  call inputrestore()

  call s:setUserTabLabelName(name)
endfunction

" command-line :TabulousRename <string> to rename current tab page label as specified
command! -nargs=1 TabulousRename call <SID>setUserTabLabelName(<q-args>)

" group tabulous auto commands
augroup Tabulous

  " listen for buffer wipeout events
  autocmd BufWipeout * call <SID>removeUserTabLabelName(expand('<abuf>'))

augroup END

call s:setTabline()


