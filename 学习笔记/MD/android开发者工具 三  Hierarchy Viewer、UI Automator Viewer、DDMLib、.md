android开发者工具 三  Hierarchy Viewer、UI Automator Viewer、DDMLib、开发者选项

1. Hierarchy Viewer (分层的视图)

   ubuntu环境,在sdk/tool文件夹中找不到,打不开,在as中打开Tool->android->ADM 在android devices monitor 中可以切换为Hierarchy Viewer

   真机不经过处理无法使用步骤如下

   1).添加依赖

   ```groovy
   debugImplementation 'com.hanhuy.android:viewserver:1.0.3'//在debug中才有效
   ```

   2).添加权限

   ```xml
   <uses-permission android:name="android.permission.INTERNET" />
   ```

   3).activity添加代码

   ```java
   package com.example.caoyang.day20171201;
   import android.os.Bundle;
   import android.support.v7.app.AppCompatActivity;
   //这一行还是没办法处理  遗憾  需要在正式打包的时候去除
   import com.android.debug.hv.ViewServer;
   public class MainActivity extends AppCompatActivity {

       @Override
       protected void onCreate(Bundle savedInstanceState) {
           super.onCreate(savedInstanceState);
           setContentView(R.layout.activity_main);
           if (BuildConfig.DEBUG)//在debug中才有效
               ViewServer.get(this).addWindow(this);
       }
       
       @Override
       protected void onDestroy() {
           super.onDestroy();
           if (BuildConfig.DEBUG)//在debug中才有效
               ViewServer.get(this).removeWindow(this);
    
       }
    
       @Override
       protected void onResume() {
           super.onResume();
           if (BuildConfig.DEBUG)//在debug中才有效
               ViewServer.get(this).setFocusedWindow(this);
    
       }
   }

   ```

2. UI Automator Viewer

   ubuntu可以在终端打开

   sdk/tools/bin/:    sudo chom +x uiautomatorviewer

   sdk/tools/bin/:    ./uiautomatorviewer

   **UIAutomator** 自动化测试框架 需要了解

3. DDMlib 

   好东西,未来详细了解

4. 开发者选项

   1).Process Stats 进程统计 

   在genymotion中.4.3到7.1,只有4.4.4 有这个功能

   找到所有前后台运行的所有进程,点击可查看进程的详细信息,内存使用情况和运行时间 

   其他手机有类似的 **正在进行服务**

   2).**Show Touches**(触摸反馈) 和**Pinter Location**(指针位置)

   这个感觉比较有用,尤其调试一些组件的时候

   3).Show Layout Bounds  显示布局边界

   其实类似 UI Automator  Viewer 

   4).Animation Scale 三个选项 对标准的动画时间进行倍数改变

   对调试动画会有帮助

   5).Simulate Secondary Displays 模拟辅助显示设备

   类似as中xml的多设备预览,但是在这里的这个效果非常不好,看不出来什么东西

   可能是公司配的屏幕太渣

   6).Debug GPU Overdraw

   根据绘制的view层数,显示不同的颜色

   没什么卵用,使用6.0的模拟器.显示,自带的设置页面都绘制四层!!!

   7).Show CPU Usage cpu利用的情况显示

   app没到这个水准.用不到

   8).Profit GPU Rending　ＧＰＵ呈现模式分析

   RN的webviewde 模式分析　　突破边际

   9).Stirck mode 严格模式，检测主线程的耗时操作

   10).**不保留活动**

   打开一个activty,关闭上一个activity.

   可以检测功能，比startAcitityForResult方法的丢失，回调方法的丢失，局部变量不保存状态丢失，可以使用这个属性进行调试

