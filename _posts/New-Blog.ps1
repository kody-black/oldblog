param(
    $title='title',
    $sub='',
    $tag=''
)

$a = 
"---
layout:     post
title:      "+$title+"
subtitle:   "+$sub+"
date:       "

$time = Get-Date -UFormat "%Y-%m-%d"

$b = 
"
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - "+$tag+"
---

"

$content = $a + $time + $b
$name = './'+$time+'-'+$title+".md"

# 注意，这里要设置编码为UTF8，否则会出现错误
$content | Out-File -Encoding UTF8 $name  -NoClobber

powershell $name
