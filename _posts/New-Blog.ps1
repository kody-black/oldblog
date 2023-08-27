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

$content | Out-File -Encoding UTF8 $name  -NoClobber

powershell $name
