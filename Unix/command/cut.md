# cut

## 梗概
```
     cut -b list [-n] [file ...]
     cut -c list [file ...]
     cut -f list [-d delim] [-s] [file ...]
```

## 使用

对文件/etc/passwd中的每一行，使用`-d`取`:`分割，然后取第1个和第7个
```
cut -d : -f 1,7 /etc/passwd
cut -d : -f -2 /etc/passwd
```

使用`-c`按照字符的位置取，如`1-16`就是取第1到第16个字符串
```
who | cut -c 1-16,26-38
```
