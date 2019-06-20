# *Tabulous*
Lightweight Vim plugin to enhance the tabline including numbered tab page labels; it's written entirely in Vim script.

![Tabulous](http://i.imgur.com/rrh3lIN.gif "Tabulous")

---

### Features
Shows the tab page number on every tab label for quickly navigating to the desired tab **`<number>gt`**.
Rename the current tab page label.
Tabs display an indicator when a buffer has been modified and not saved.
Dynamically updates the filename of the currently focused window in the tab page.
Eliminates inefficient use of string concatenation operator by using **`printf`** where possible.
Does not show filename extensions to preserve the amount of tab label space.
Performs runtime calculation of maximum tab label length and truncates accordingly (Dynamic resizing of tab labels).
Options are configurable from **`.vimrc`**.

##### Planned Features
Enhancement of tab label truncation algorithm
Toggle tab page numbers on and off by keyboard shortcut
Toggle tab label filename extensions on and off by keyboard shortcut
Toggle tab label truncation on and off by keyboard shortcut
> In progress: keyboard shortcuts and enhancement of tab label truncation algorithm.

---

### Install
You may choose your preferred method of installation.
> Windows users, change all occurrences of **`~/.vim`** to **`~\vimfiles.`**

---

##### Vimrc *Tabulous* Installation
Run the following commands in a terminal:
```sh
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/webdevel/tabulous.git
echo 'set runtimepath^=~/.vim/bundle/tabulous' >> ~/.vimrc
```
Restart Vim.

---

##### Pathogen *Tabulous* Installation
Run the following commands in a terminal:
```sh
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/webdevel/tabulous.git
```
Restart Vim.

---

##### Vundle *Tabulous* Installation
> If your Vundle version is less than `0.10.2,` change **`Plugin`** to **`Bundle`**.

Enter this in your **`.vimrc`**:
```sh
Plugin 'webdevel/tabulous'
```
Then enter the following command-lines in Vim:
```sh
:source %
:PluginInstall
```

---

##### NeoBundle *Tabulous* Installation
Enter this in your **`.vimrc`**:
```sh
NeoBundle 'webdevel/tabulous'
```
Then enter the following command-lines in Vim:
```sh
:source %
:NeoBundleInstall
```

---

##### VimPlug *Tabulous* Installation
Enter this in your **`.vimrc`**:
```sh
Plug 'webdevel/tabulous'
```
Then enter the following command-lines in Vim:
```sh
:source %
:PlugInstall
```

---

### Command-Lines
Tabulous adds the following commands available from Vim's Command-Line mode.

##### TabulousRename
Rename the current tab page label name to **`<string>`**. The new label name is remembered until the buffer associated with the label name is wiped out or you use **`TabulousRename`** again on the same label name.

```vimL
:TabulousRename <string>
```

---

### Configuration
No configuration is necessary by default. However, there are options if you want to set them. Any of the following configuration options may simply be added to a new line in your **`.vimrc`**.

##### Disable Plugin
This disables the plugin entirely.
```sh
let loadTabulous = 1
```

##### Tab Label Truncation
This enables or disables tab page label truncation. The default is **`1`** enabled.
```sh
let tabulousLabelNameTruncate = 0
```

##### Tab Close
This sets the tab close string for mouse clicks. The default is **`X`** enabled.
```sh
let tabulousCloseStr = ''
```

##### Tab Label Name Options
This sets the tab label name options which may be valid [filename-modifiers] recognized by the Vim command **`fnamemodify`**. The defaults are **`:t:r`** which remove directories and file extension from a tab label name.
```sh
let tabulousLabelNameOptions = ''
```

##### Tab Label Modified
This sets the string that indicates the buffer associated with a tab has been modified, but not yet saved. The default value is shown below.
```sh
let tabulousLabelModifiedStr = '+'
```

##### Tab Label Left
This sets the string on the left of the tab label. The default value is shown below.
```sh
let tabulousLabelLeftStr = ' '
```

##### Tab Label Right
This sets the string on the right of the tab label. The default value is shown below.
```sh
let tabulousLabelRightStr = ' '
```

##### Tab Label Number
This sets the string on the right of the tab label number. The default value is shown below.
```sh
let tabulousLabelNumberStr = ' '
```

##### Tab Label Name Left
This sets the string on the left of the tab label name. The default value is shown below.
```sh
let tabulousLabelNameLeftStr = ''
```

##### Tab Label Default Name
This sets the default tab label name. The default value is shown below.
```sh
let tabulousLabelNameDefault = '[No Name]'
```

---

### Keyboard Shortcuts

There are no default mappings for renaming your tabs, but you can map it easily like this:

```vimL
map <C-t> :call g:tabulous#renameTab()<cr>
```

This maps `Ctrl + t` to rename your tab.

---

### License
*Tabulous* is free and open source software. It is licensed by the GNU General Public License version 2 (GPLv2).

[filename-modifiers]: http://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers

