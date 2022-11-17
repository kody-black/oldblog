---
layout:     post
title:      获取PowerShell的所有历史记录
subtitle:   用自定义函数的方法
date:       2022-11-17
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - 配置
---


### 一、PSReadline

当前版本（5.1）默认安装了[Readline](https://learn.microsoft.com/zh-cn/powershell/module/psreadline/about/about_psreadline?view=powershell-5.1)，其为PowerShell提供了诸多实用功能，包括了历史记录的记录功能。

```
# 获取可配置的选项的值
Get-PSReadLineOption
# 获取 PSReadLine 模块的键绑定
Get-PSReadlineKeyHandler
```

可以看到其历史记录功能如下：

```
历史记录功能
======

Key       Function              Description
---       --------              -----------
Alt+F7    ClearHistory          从命令行历史记录(不是 PowerShell 历史记录)
                                中删除所有项
Ctrl+s    ForwardSearchHistory  以交互方式向前搜索历史记录
F8        HistorySearchBackward 搜索历史记录中以当前输入开头的上一项，例如
                                PreviousHistory (如果输入为空)
Shift+F8  HistorySearchForward  搜索历史记录中以当前输入开头的下一项，例如
                                NextHistory (如果输入为空)
DownArrow NextHistory           使用历史记录中的下一项替换输入
UpArrow   PreviousHistory       使用历史记录中的上一项来替换输入
Ctrl+r    ReverseSearchHistory  以交互方式向后搜索历史记录
```

默认的查看历史记录的命令为`history`，但只能查看当前命令行的命令

而当前版本的Readline也没有提供直接查看history功能

可以使用` Get-Content (Get-PSReadlineOption).HistorySavePath`获得PSReadline保存的历史记录，但是这种方法太长了，找了半天发现当前版本并没有什么其他方法。

### 二、写函数

```
# Add Get-AllHistory function for powershell
function Get-AllHistory
{
	<#
       .SYNOPSIS
	   # Get-AllHistory
	   Get all history of powershell
	   # Get-AllHistory n
	   Show the last n history records
	   .DESCRIPTION
	   The function add by Kody
    #>
	param (
        $Count
    )
    if($Count){
		$his = Get-Content (Get-PSReadLineOption).HistorySavePath -tail $Count
	}
	else{
		$his = Get-Content (Get-PSReadLineOption).HistorySavePath
	}
    $n = $his.Length
    $out = @()
    for($i=1;$i -le $n;$i++)
    {
        $out = $out + "$i $($his[$i-1])"
    }
    return $out
}
```

打开配置文件，把这个函数加进去

```
notepad $PROFILE
```

### 三、使用

```
Get-AllHistory

Get-AllHistory 100 #最近一百条历史记录
```

如果还是觉得Get-AllHistory也太长了

可以设个别名，也加到$PROFILE里面

```
Set-Alias -Name his -Value Get-AllHistory
```

