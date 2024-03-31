---
layout:     post
title:      关于哈希碰撞和PHP的Tricks
subtitle:   
date:       2024-03-31
author:     Kody Black
header-img: img/post-bg-normal.jpg
catalog: true
tags:
    - Web
    - CTF
---

### 关于

做了几道hash相关的题目（其实应该算Crypto，不过我做的Web），基本都是老生常谈的小知识点，简单记录一下。

关键词：md5；弱类型；sha1；Magic Hash；Shattered

### php弱类型

由于 PHP 是一种弱类型语言，它在比较和运算时可能会自动转换数据类型，这可以被用来绕过某些类型的检查或验证。例如，使用 `==` 比较时，PHP 会尝试将两边的值转换为相同的类型再进行比较，而 `===` 则不会进行类型转换直接比较。

一些常见的利用 PHP 弱类型的技巧包括：

1. 利用 PHP 数组与字符串的比较：在使用 `==` 进行比较时，如果一个值是数组，另一个值是字符串，那么结果总是 `false`。
2. 利用 PHP 类型转换：例如，字符串 `"0e1234"` 和 `"0"` 在使用 `==` 比较时会被视为相等，因为它们都可以被转换成数值 0。
3. 利用松散比较与散列函数：某些情况下，不同的输入在经过散列函数处理后可能产生相同的散列值，这在使用松散比较时可以被利用。

一个非常著名的技巧是使用类似 `0eXXXX` 形式的字符串。在 PHP 中，如果一个字符串以 `0e` 开头（不区分大小写），后跟任意数量的数字，它会被当作科学记数法处理，并转换成 0。这种情况在松散比较（使用 `==` 而非 `===`）时可以被利用。

因此，我们的目标是找到两个不同的字符串，它们的 MD5 哈希值都具有 `0eXXXX` 的形式。这样，这两个哈希值在 PHP 的比较中就会被视为相等的 0。

### Magic Hash

刚才提到的这类在松散比较（使用 `==` 而不是 `===`）可以被视为相等的哈希值称为Magic Hash。这种情况发生在某些哈希函数（如 MD5, SHA1）生成的哈希字符串以 "0e" 开头，并且后面跟随的只是数字时。由于 "0e" 被解释为科学记数法，表示 0 乘以 10 的若干次方，其结果是 0。因此，如果两个不同的字符串生成的哈希值都是这种形式，并且它们在数学上被解释为 0，那么它们在 PHP 的松散比较中会被认为是相等的。

下文提供了诸多符合条件的Magic Hash

[Magic Hashes (github.com)](https://gist.github.com/atoponce/bb672d93233121560d2841f67e41698b)

### 哈希碰撞

这里首先区分一个特别容易混淆的概念[Collision resistance - Wikipedia](https://en.wikipedia.org/wiki/Collision_resistance#Weak_and_strong_collision_resistance)：

- 弱抗碰撞性：给定一个x时，不可能找到另一个y使得H(x)=H(y)
- 强抗碰撞性：找不到任意的x和y，有H(x)=H(y)

md5和sha-1都没有抗强碰撞性。

下面是一些例子，注意这里都是进行了url编码：

##### md5强碰撞：

**`5d6544fbcea407302737f3b222925766`**

```
psycho%0A%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00W%ADZ%AF%3C%8A%13V%B5%96%18m%A5%EA2%81_%FB%D9%24%22%2F%8F%D4D%A27vX%B8%08%D7m%2C%E0%D4LR%D7%FBo%10t%19%02%82%7D%7B%2B%9Bt%05%FFl%AE%8DE%F4%1F%84%3C%AE%01%0F%9B%12%D4%81%A5J%F9H%0FyE%2A%DC%2B%B1%B4%0F%DEcC%40%DA29%8B%C3%00%7F%8B_h%C6%D3%8Bd8%AF%85%7C%14w%06%C2%3AC%BC%0C%1B%FD%BB%98%CE%16%CE%B7%B6%3A%F3%99%B59%F9%FF%C2
```

```
psycho%0A%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00%00W%ADZ%AF%3C%8A%13V%B5%96%18m%A5%EA2%81_%FB%D9%A4%22%2F%8F%D4D%A27vX%B8%08%D7m%2C%E0%D4LR%D7%FBo%10t%19%02%02%7E%7B%2B%9Bt%05%FFl%AE%8DE%F4%1F%04%3C%AE%01%0F%9B%12%D4%81%A5J%F9H%0FyE%2A%DC%2B%B1%B4%0F%DEc%C3%40%DA29%8B%C3%00%7F%8B_h%C6%D3%8Bd8%AF%85%7C%14w%06%C2%3AC%3C%0C%1B%FD%BB%98%CE%16%CE%B7%B6%3A%F3%9959%F9%FF%C2
```

**`008ee33a9d58b51cfeb425b0959121c9`**

```
M%C9h%FF%0E%E3%5C%20%95r%D4w%7Br%15%87%D3o%A7%B2%1B%DCV%B7J%3D%C0x%3E%7B%95%18%AF%BF%A2%00%A8%28K%F3n%8EKU%B3_Bu%93%D8Igm%A0%D1U%5D%83%60%FB_%07%FE%A2
```

```
M%C9h%FF%0E%E3%5C%20%95r%D4w%7Br%15%87%D3o%A7%B2%1B%DCV%B7J%3D%C0x%3E%7B%95%18%AF%BF%A2%02%A8%28K%F3n%8EKU%B3_Bu%93%D8Igm%A0%D1%D5%5D%83%60%FB_%07%FE%A2
```

##### SHA1强碰撞：

这个例子来源于[SHAttered](https://shattered.io/)，还有其他的例子如：[SHA-1 is a Shambles (sha-mbles.github.io)](https://sha-mbles.github.io/)

**`f92d74e3874587aaf443d1db961d4e26dde13e9c`**

```
%25PDF-1.3%0A%25%E2%E3%CF%D3%0A%0A%0A1%200%20obj%0A%3C%3C/Width%202%200%20R/Height%203%200%20R/Type%204%200%20R/Subtype%205%200%20R/Filter%206%200%20R/ColorSpace%207%200%20R/Length%208%200%20R/BitsPerComponent%208%3E%3E%0Astream%0A%FF%D8%FF%FE%00%24SHA-1%20is%20dead%21%21%21%21%21%85/%EC%09%239u%9C9%B1%A1%C6%3CL%97%E1%FF%FE%01%7FF%DC%93%A6%B6%7E%01%3B%02%9A%AA%1D%B2V%0BE%CAg%D6%88%C7%F8K%8CLy%1F%E0%2B%3D%F6%14%F8m%B1i%09%01%C5kE%C1S%0A%FE%DF%B7%608%E9rr/%E7%ADr%8F%0EI%04%E0F%C20W%0F%E9%D4%13%98%AB%E1.%F5%BC%94%2B%E35B%A4%80-%98%B5%D7%0F%2A3.%C3%7F%AC5%14%E7M%DC%0F%2C%C1%A8t%CD%0Cx0Z%21Vda0%97%89%60k%D0%BF%3F%98%CD%A8%04F%29%A1
```

```
%25PDF-1.3%0A%25%E2%E3%CF%D3%0A%0A%0A1%200%20obj%0A%3C%3C/Width%202%200%20R/Height%203%200%20R/Type%204%200%20R/Subtype%205%200%20R/Filter%206%200%20R/ColorSpace%207%200%20R/Length%208%200%20R/BitsPerComponent%208%3E%3E%0Astream%0A%FF%D8%FF%FE%00%24SHA-1%20is%20dead%21%21%21%21%21%85/%EC%09%239u%9C9%B1%A1%C6%3CL%97%E1%FF%FE%01sF%DC%91f%B6%7E%11%8F%02%9A%B6%21%B2V%0F%F9%CAg%CC%A8%C7%F8%5B%A8Ly%03%0C%2B%3D%E2%18%F8m%B3%A9%09%01%D5%DFE%C1O%26%FE%DF%B3%DC8%E9j%C2/%E7%BDr%8F%0EE%BC%E0F%D2%3CW%0F%EB%14%13%98%BBU.%F5%A0%A8%2B%E31%FE%A4%807%B8%B5%D7%1F%0E3.%DF%93%AC5%00%EBM%DC%0D%EC%C1%A8dy%0Cx%2Cv%21V%60%DD0%97%91%D0k%D0%AF%3F%98%CD%A4%BCF%29%B1
```

##### 测试代码如下：

```
import hashlib
import urllib.parse

encoded_hash_str1 = "M%C9h%FF%0E%E3%5C%20%95r%D4w%7Br%15%87%D3o%A7%B2%1B%DCV%B7J%3D%C0x%3E%7B%95%18%AF%BF%A2%00%A8%28K%F3n%8EKU%B3_Bu%93%D8Igm%A0%D1U%5D%83%60%FB_%07%FE%A2"
encoded_hash_str2 = "M%C9h%FF%0E%E3%5C%20%95r%D4w%7Br%15%87%D3o%A7%B2%1B%DCV%B7J%3D%C0x%3E%7B%95%18%AF%BF%A2%02%A8%28K%F3n%8EKU%B3_Bu%93%D8Igm%A0%D1%D5%5D%83%60%FB_%07%FE%A2"

# Convert the URL encoded strings directly to bytes
bytes_hash_str1 = urllib.parse.unquote_to_bytes(encoded_hash_str1)
bytes_hash_str2 = urllib.parse.unquote_to_bytes(encoded_hash_str2)

# Calculate MD5/SHA-1 hashes of the byte sequences
# str1 = hashlib.sha1(bytes_hash_str1).hexdigest()
str1 = hashlib.md5(bytes_hash_str1).hexdigest()
str2 = hashlib.md5(bytes_hash_str2).hexdigest()

print(str1, str2, str1 == str2)
```

参考链接：

[corkami/collisions: Hash collisions and exploitations (github.com)](https://github.com/corkami/collisions?tab=readme-ov-file)

[MD5 - CTF Wiki (ctf-wiki.org)](https://ctf-wiki.org/crypto/hash/md5/)

[md5在线解密破解,md5解密加密 (cmd5.com)](https://www.cmd5.com/)
