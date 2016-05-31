"tabulous.vim - Lightweight Vim plugin for setting the tabline including the tab page labels.
"File:		tabulous.vim
"Location:      plugin/tabulous.vim
"Author:        Steven Garcia <https://github.com/webdevel>
"Description:   Lightweight Vim plugin for setting the tabline including the tab page labels.
"Version:       0.1
"License:       GNU GPLv2

" ToDo implement algorithm to truncate 
" tab page labels based on line column count
" ToDo enable some settings to be configrable
" ToDo enable some keyboard shorcuts

" exit when plugin is already loaded,
" vi compatibility or vim version is insufficient
if exists('g:loadTabulous') || &compatible || v:version < 700

  finish

endif

let g:loadTabulous = 1

" build tabline and return it
" returns string representing tabline
function s:getTabline()

  let tablineStr = ''

  " get the tab page count
  let tabPageCount = tabpagenr('$')

  " get a tab number list. tab numbers start at one, not zero
  let tabNumList = range(1, tabPageCount)

  " iterate through the tab number list
  for tabNum in tabNumList

    " get the currently focused window number in the specified tab page
    let windowNum = tabpagewinnr(tabNum)

    " get a list of all buffer numbers in the specified tab page
    let bufferNumList = tabpagebuflist(tabNum)

    " get buffer number indexed by currently focused window number
    let bufferNum = bufferNumList[windowNum - 1]

    " get buffer name using buffer number
    let bufferName = bufname(bufferNum)

    " get buffer-local variable that indicates whether buffer is modified
    let isBufferModified = getbufvar(bufferNum, '&mod')

    " concatenate a single tab page label for this iteration
    " TabNumberToken, TabSelectedToken, TabNumber, TabBufferModified, TabFileName
    let tablineStr .= printf(
      \'%%%dT%s %d %s%s ',
      \tabNum,
      \(tabNum == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'),
      \tabNum,
      \(isBufferModified ? '+' : ''),
      \(bufferName != '' ? fnamemodify(bufferName, ':t:r') : '[No Name]')
    \)

  endfor

  " after the last tab, fill with TabLineFill, reset tab page number,
  " right-align the label to close the current tab page and
  " return complete string representation of tabline
  return printf('%s%%#TabLineFill#%%T%s', tablineStr, (tabPageCount > 1 ? '%=%#TabLine#%9999XX' : ''))

endfunction

" wrap in vendor specific function to avoid name conflicts
function! Tabulous()

  return s:getTabline()

endfunction

" since the number of tab labels will vary,
" we need to use an expression when setting the tabline option
set tabline=%!Tabulous()

