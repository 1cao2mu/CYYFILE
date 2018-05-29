#!/bin/bash
# sh tap.sh 循环点击按键
count=1
mode=0;
zcount=200
if [ -n "$2" ]; then
    zcount=$2
else
    zcount=200
fi

if [ -n "$1" ]; then
    mode=$1
else
    mode=0
fi

while [ $count -le $zcount ]; 
do  

    if [ $mode -eq  1 ]; then
        adb shell input tap 960 185 ;
    else if [ $mode -eq  2 ]; then
        adb shell input tap 960 325 ;
    else if [ $mode -eq  3 ]; then
        adb shell input tap 960 450 ;
    fi
    fi
    fi

    adb shell input tap 960 325 ; 
    adb shell input tap 1820 715 ;
    count=$((count + 1));
done;
# 第一个选项：960 185
# 第二个选项：960 325
# 第三个选项：960 450
# 	  是：960 325
# 	 图片：1820 715

