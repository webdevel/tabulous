# *Tabulous*
Vim plugin for setting the tabline including the tab page labels. It is lightweight and written in pure Vim script.

### Features
Shows the tab page number on every tab label for quickly navigating to the desired tab.  
Tabs display an indicator when a buffer has been modified and not saved.  
Dynamically updates the filename of the currently focused window in the tab page.  
Eliminates inefficient use of string concatenation operator by using **`printf`** where possible.  
Does not show filename extensions to preserve the amount of tab label space.  
> In progress: dynamic resizing of tab page labels based on current line column count, configurable options and keyboard shortcuts.  

### Install
You may choose your preferred method of installation.
> Windows users, change all occurrences of **`~/.vim`** to **`~\vimfiles.`**

##### Vimrc
Run the following commands in a terminal:
```sh
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/webdevel/tabulous.git
echo 'set runtimepath^=~/.vim/bundle/tabulous' >> ~/.vimrc
```
Restart Vim.

##### Pathogen
Run the following commands in a terminal:
```sh
mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/webdevel/tabulous.git
```
Restart Vim.

##### Vundle
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

##### NeoBundle
Enter this in your **`.vimrc`**:
```sh
NeoBundle 'webdevel/tabulous'
```
Then enter the following command-lines in Vim:
```sh
:source %
:NeoBundleInstall
```

##### VimPlug
Enter this in your **`.vimrc`**:
```sh
Plug 'webdevel/tabulous'
```
Then enter the following command-lines in Vim:
```sh
:source %
:PlugInstall
```

### Configuration
No configuration is necessary by default. However, there are options if you want to set them.

##### Disable Plugin
To disable the plugin, add the following line in your **`.vimrc`**:
```sh
let g:loadTabulous = 1
```

### Keyboard Shortcuts
**_TODO_**

### License
*Tabulous* is free and open source software. It is licensed by the GNU General Public License version 2 (GPLv2).

