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

$content | Out-File $time-$title".md"  -NoClobber
