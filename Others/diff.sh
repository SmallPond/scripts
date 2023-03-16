#!/bin/bash
# 对比两个文件的差异， A 文件中的内容是否在 B 文件中
fileA=$1
fileB=$2
while read -r searchPattern; do    
    if grep -q "$searchPattern" $fileB; then
        flag="YES"
    else
        flag="NO"    
    fi
    printf "%s %s\n" "$flag" "$searchPattern"
done < $fileA >output
