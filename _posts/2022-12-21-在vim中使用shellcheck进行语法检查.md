---
layout:     post
title:      在vim中使用shellcheck进行语法检查
subtitle:   
date:       2022-12-21
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - 工具
---

## 方法介绍

你可以使用插件来在Vim中使用shellcheck。 一种方法是使用vim-syntastic插件。

安装此插件后，你可以在Vim中打开一个Shell脚本文件，并使用命令`:SyntasticCheck`来检查语法错误和其他问题。

你也可以设置syntastic插件来自动检查脚本，只要你保存文件就会触发检查。要做到这一点，你需要在你的Vim配置文件（通常是~/.vimrc）中添加以下行：

```
let g:syntastic_auto_check_on_open = 1
let g:syntastic_auto_check_on_wq = 1
```

这将启用自动检查功能。当你打开一个新的Shell脚本文件时，syntastic插件就会自动使用shellcheck来检查语法错误和其他问题。

需要注意的是，在使用此插件之前，你需要在你的系统中安装shellcheck。要安装shellcheck，你可以使用以下命令：

```
sudo apt-get install shellcheck
```

## vim-syntastic插件安装方法

要在Vim中安装vim-syntastic插件，你可以使用一个管理插件的插件，比如Vundle或者vim-plug。这些插件可以帮助你管理和安装其他的插件。

下面是使用Vundle来安装vim-syntastic插件的示例步骤：

1. 首先，你需要安装Vundle。你可以使用以下命令来安装Vundle：

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

2. 然后，打开你的Vim配置文件（通常是~/.vimrc），并添加以下行：

```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
```

3. 现在，你可以在你的Vim配置文件中添加对vim-syntastic插件的引用，如下所示：

```
" Syntastic plugin for syntax checking
Plugin 'scrooloose/syntastic'
```

​	这样，在你使用命令`:PluginInstall`来安装插件时，Vundle就会安装vim-syntastic插件。

4. 现在，你可以在Vim中使用命令`:PluginInstall`来安装vim-syntastic插件。 输入命令后，Vundle将下载和安装vim-syntastic插件。
5. 安装完成后，你就可以在Vim中使用shellcheck了。 你可以打开一个Shell脚本文件，并使用命令`:SyntasticCheck`来检查语法错误和其他问题。 你也可以通过设置syntastic插件来自动检查脚本，只要你保存文件就会触发检查。

## 最后

以上方法来自chatGPT，亲测有效！
