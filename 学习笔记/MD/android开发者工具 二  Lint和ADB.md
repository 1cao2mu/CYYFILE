android开发者工具 二  Lint.adb

1. gradle lint 命令

   生成代码检测的检测结果Lint Report

2. adb help指令  

3. adb 无线调试

   必须在同一wifi下

   首先，手机要开通调试模式

   其次：adb tcpip 5555

   最后：adb connect <ip地址：5555> 

   关闭：adb disconnect <ip地址：5555>

4. adb 截图

   adb shell screencap -p /sdcard/1.png 截图到手机

   adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g'>~/桌面/1.png 截图后，定位pull传到电脑里面

5. 帧率分析

   adb shell dumpsys gfxinfo 《包名》 可定位到一个txt文件

6. adb dumpsyys 》》《群英传》

7. adb Logcat

   adb logcat -s xxx    //-s 显示TAG为xxx的Log信息

   adb logcat -f /sdcard/log.txt  //-f 保存到文件

   adb logcat -v time //输出详细的时间

   grep 过滤输出信息

   重定向符>  将输出信息放置到文件中

8. adb bugreport 了解

   adb bugreport >bugreport.log

9. ADM android device monitor（监测仪） 

   android设备监视器 

   前身是DDMS ，两者十分相似  

10. 9path 已有

    ​

    ​



