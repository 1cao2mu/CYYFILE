Android体系和系统架构

随便记记,没啥意思

1. Google生态系统

   android是google的富二代???

2. android的系统架构

   linux内核层,库和运行时,Framework层和应用层

3. linux内核层

   主要包括硬件驱动,进程管理,安全系统等

4. Dalvilk和ART(运行时)

   Dalvilk:运行时编译   ART:安装时编译  5.0开始ART

5. FrameWork 

   Activity Manager , window manager ,Content Providers,  View System, Package Manager

   Telephony Manager,Resource Manager,Location Manager ,XMPP

6. Standard libraries (库)

   眼瞎

7. Application

   NDk app  SDK app

8. android app组件架构

   四大组件  使用Intent传递

9. 应用运行上下文对象

   Context 当前对象所在的环境   Aciticity Service Application

10. android 系统源代码目录  (无用)

11. Android 系统目录(就这个不是废)

    主要是system和data

    /system/app/ :系统的一些app

    /system/bin/:linux自带的组件

    /system/build.prop: 系统的一些属性信息

    /system/fonts/ 系统字体存放目录

    /system/framework/ 系统的核心文件和框架层

    /system/lib/ 存放几乎所有的共享库文件

    /system/media/ 保存系统提示音和系统铃声

    /system/usr/ 保存用户的配置文件

    /data/app/ 包含用户的大部分数据信息,键盘布局,共享,时区文件

    /data/data/ 开发者访问的最多的目录,包含数据信息,文件信息,数据库信息

    /data/stystem 手机的各项系统信息

    /datamisc 保存大部分的wifi vpn 信息

12. Android App 文件目录(我又更好的)

总结:扯淡哩,我记这个

