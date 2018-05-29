Android 开发者工具新接触

强忍吐槽,记笔记

1. as常用设置

   设置一次之后,记得保存settings.jar 以后import

   settings->appearance->Override default font 解决乱码问题,之前没试过!!! 经常给字符类型不管用,以后有机会试试

   settings->Editor color&font 设置字体

   settings->Keymap 设置快捷键

   settings->Code Sensitive completion 选择none 当输入代码时，弹出代码提示 部分大小写

2. ADB 命令基本技巧

   adb version 查看版本号

   adb shell  不知道shell是，以后了解

   adb list targets 显示系统中的所有Android平台

   adb install -f ***8.apk 安装apk

   adb push 向手机写入文件

   adb pull  从手机获取文件

   adb shell &logcat  查看log

   adb rm 删除应用

   adb shell df 查看系统盘符

   adb shell pm list packages -f  输入所以安装的软件

   adb shell input keyevent * 模拟输入

   adb shell input touchscreen swipe * * * * 模拟滑动输入

   adb start -n 包名/包名+类名

   adb shell screenrecord /sdcard/demo.mp4 录制屏幕  https://jingyan.baidu.com/article/6f2f55a1429fecb5b93e6ced.html 默认的录制时间是180秒，可以按Ctrl+C键终止录制。

   adb reboot 重新启动

