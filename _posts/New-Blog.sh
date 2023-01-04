#!/bin/bash

# 获取脚本参数
name=$1

# 获取当前日期
date=$(date "+%Y-%m-%d")

# 组装文件名
filename="${date}-${name}.md"

# 判断文件是否存在
if [[ -f "${filename}" ]]; then
    # 文件存在，询问用户是否覆盖
    read -p "文件已存在，是否覆盖？[y/N] " yn
    case $yn in
    [Yy]*)
        # 用户选择覆盖，执行创建文件操作
        if cat >"${filename}" <<EOF; then
---
layout:     post
title:      ${name}
subtitle:   
date:       ${date}
author:     Distiny
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - Blog
---
EOF

            echo "创建成功"
            # 检查是否有 typora
            if command -v typora >/dev/null; then
                # 用 typora 打开文件
                nohup typora "${filename}" &>/dev/null &
            else
                echo "未安装 typora，无法打开文件"
            fi
        else
            echo "创建失败"
            exit 1
        fi
        ;;
    [Nn]*)
        # 用户选择不覆盖，退出脚本
        echo "取消创建"
        exit 0
        ;;
    *)
        # 用户输入无效，退出脚本
        echo "无效输入"
        exit 1
        ;;
    esac
else
    # 文件不存在，执行创建文件操作
    if cat >"${filename}" <<EOF; then
---
layout:     post
title:      ${name}
subtitle:   
date:       ${date}
author:     Distiny
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - Blog
---
EOF

        echo "创建成功"
        # 检查是否有 typora
        if command -v typora >/dev/null; then
            # 用 typora 打开文件
            nohup typora "${filename}" &>/dev/null &
        else
            echo "未安装 typora，无法打开文件"
        fi
    else
        echo "创建失败"
        exit 1
    fi
fi
