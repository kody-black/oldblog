---
layout:     post
title:      Github的Action功能初探
subtitle:   profile上的贪吃蛇
date:       2022-11-20
author:     Kody Black
header-img: img/post-bg-github.jpg
catalog: true
tags:
    - github

---

> 新发现一个好玩的东西 [generate-snake-game-from-github-contribution-grid](https://github.com/marketplace/actions/generate-snake-game-from-github-contribution-grid)，它可以在自己的github profile上面生成一个动态的贪吃蛇：

![贪吃蛇](https://raw.githubusercontent.com/distiny-cool/distiny-cool/output/github-contribution-grid-snake.svg)

最关键的底下的这个github贡献栏可以每天更新，这就很有趣了

### 配置贪吃蛇

在个人介绍的仓库中，创建`./.github/workflows/snake.yml`,其中内容如下：

```yaml
name: generate animation

on:
  # run automatically every 12 hours
  schedule:
    - cron: "0 */12 * * *" 
  
  # allows to manually run the job at any time
  workflow_dispatch:
  
  # run on every push on the master branch
  push:
    branches:
    - master

jobs:
  generate:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    
    steps:
      # generates a snake game from a github user (<github_user_name>) contributions graph, output a svg animation at <svg_out_path>
      - name: generate github-contribution-grid-snake.svg
        uses: Platane/snk/svg-only@v2
        with:
          github_user_name: ${{ github.repository_owner }}
          outputs: |
            dist/github-contribution-grid-snake.svg
            dist/github-contribution-grid-snake-dark.svg?palette=github-dark

      # push the content of <build_dir> to a branch
      # the content will be available at https://raw.githubusercontent.com/<github_user>/<repository>/<target_branch>/<file> , or as github page
      - name: push github-contribution-grid-snake.svg to the output branch
        uses: crazy-max/ghaction-github-pages@v2.6.0
        with:
          target_branch: output
          build_dir: dist
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

再在README文件中添加：

```
![github contribution grid snake animation](https://raw.githubusercontent.com/distiny-cool/distiny-cool/output/github-contribution-grid-snake-dark.svg#gh-dark-mode-only)
![github contribution grid snake animation](https://raw.githubusercontent.com/distiny-cool/distiny-cool/output/github-contribution-grid-snake.svg#gh-light-mode-only)
# 上述格式主要用去区分黑暗模式和白天模式的显示图像
```

就可以得到这样的贪吃蛇了

### Action了解

那么这里添加的yml文件有什么呢？

实际上，在.github/workflows中的yml文件正是Action对应的工作流，每天会定时执行里面的操作。

那么，这个功能显然也可以用在我的博客里面吧哈哈哈哈，之后有时间了可以试试。

> 参考：
>
> [Platane/snk: Generates a snake game from a github user contributions graph and output a screen capture as animated svg or gif](https://github.com/Platane/snk)
>
> [Workflow syntax for GitHub Actions - GitHub Docs](https://docs.github.com/cn/actions/using-workflows/workflow-syntax-for-github-actions)
>
> [Github Action 精华指南 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/164744104)

### 其他有趣的主页配置

主要参考自https://github.com/alexandresanlim/Badges4-README.md-Profile

~~不过没多大用~~

<img src="https://github-readme-stats.vercel.app/api/top-langs/?username=distiny-cool" /> 

<img align="left" src="https://github-profile-trophy.vercel.app/?username=distiny-cool" />

<img align="left" src="https://github-profile-summary-cards.vercel.app/api/cards/profile-details?username=distiny-cool&theme=vue" />

<img align="left" src="https://profile-counter.glitch.me/distiny-cool/count.svg" />

