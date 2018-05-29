Gradle 学习 一

1. android的目录结构里面

   项目下的 (1)gradle文件夹  其实是gradle这个工具的架包和它的版本号信息

   项目下的(2)build.gradle 文件主要是用运用gradle语言来引入针对android的gradle的插件和一些android需要的依赖仓库,gradle和android gradle 有区别

   项目下app文件夹下的(3)build.gradle 是运用android的gradle的插件对工程的编译配置和一些架包的依赖引用

2. app build.gradle

   1) apply plugin 领域

   ```groovy
   apply plugin: 'com.android.application'   
   //表示这是一个应用,同时应用的是这个编译application的插件
   apply plugin: 'com.android.library'
   //表示这是一个library,同时应用的是这个编译library的插件
   ```

   2)  android 闭包领域

   ```groovy
   compileSdkVersion 编译的sdk版本
   buildToolsVersion 编译工具版本 其实这两个不冲突
   还有其它 附表
   ```

   3) dependencies 闭包领域

   compile fileTree (dir: ‘libs’, include: *.jar) 

   把libs文件夹里面的后缀.jar都依赖编译了 

   当然如果你任性删了,也可以的,你可以单独的引用 

   compile files(‘libs/xxx.jar’) 

   当然这是比较任性的人 

   compile ‘com.android.support:appcompat-v7:25.2.0’ 

   这是当年,忽悠我用as人说的,引用网络jar方便,确实方便,就是这么简单的一句代码\  androidTestCompile 

   测试的东西,我也不懂,没用过,用过再装逼. 

   testCompile 

   同上

3. local.properties

   本地化适应的属性 写入ndk和sdk 的安装路径

   ```groovy
   ndk.dir=/usr/android-ndk-r10c
   sdk.dir=/home/caoyang/Android/Sdk
   ```

4. gradlew aR=assembleRelease

   相见恨晚啊

   直接使用gradle +一些任务名  没有安装gradle 使用gradlew+任务名

   以前听大神说的gradle编程多牛逼呐原来原理就这两句啊

   gradlew clean  clean的功能

   gradlew build  build的功能

   gradlew task 查看所有的任务

   很多不再列举  在android studio 右侧边栏(gradle projects)中 列举也有

5. 全局变量的引用

   ```groovy
   //根目录下的gradle.build中第一层加如变量
   ext {
       cs = 26
   }
   //在app目录下的gradle.build或者library目录下的gradle.build中可以引用
   compileSdkVersion rootProject.ext.cs
   ```

6. 方法引用

   可以动态配置一些参数

   ```groovy
   //方法定义
   def getVc() {
       return 1;
   }
   //方法引用
   versionCode getVc()
   ```

7. android gradle  官方网址 各个闭包领域解读 不翻墙打不开

8. buildTypes 闭包领域  生成不同类型的apk的配置

   ```groovy
   release {//正常情况下就这一个
       minifyEnabled false
       proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
   }

   ttt {//自定义
       applicationIdSuffix ".ttt" //正常的包名后加后缀 可区分app
       minifyEnabled false
       proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
   }
   //或者
   ttt.initWith(buildTypes.release) //继承release的属性
   ttt {
        applicationIdSuffix ".ttt"
   }
   //通过gradlew build 命令行或者在as中选择  顶部导航栏 Build->Build apk 
   //可在app/build/output/apk/文件夹中查看生成的apk文件 不过都是未签名的请注
   ```

   一些其他感觉有用的属性

   | applicationIdSuffix | 正常的包名后加后缀                         |
   | ------------------- | --------------------------------- |
   | packageNameSuffix   | 已经过时了和 applicationIdSuffix效果一致    |
   | signingConfig       | 签名配置,React Native 打包使用这种方式,配置打包信息 |
   | debuggable          | 是否可以debug  ???                    |
   |                     |                                   |
   |                     |                                   |

   Error:(24, 0) Could not find method packageNameSuffix() for arguments [aaa] on BuildType_Decorated{name=ttt, debuggable=false, testCoverageEnabled=false, jniDebuggable=false, pseudoLocalesEnabled=false, renderscriptDebuggable=false, renderscriptOptimLevel=3, minifyEnabled=false, zipAlignEnabled=true, signingConfig=null, embedMicroApp=true, mBuildConfigFields={}, mResValues={}, mProguardFiles=[/home/caoyang/AndroidStudioProjects/CTest/build/intermediates/proguard-files/proguard-android.txt-2.3.3, /home/caoyang/AndroidStudioProjects/CTest/app/proguard-rules.pro], mConsumerProguardFiles=[], mManifestPlaceholders={}} of type com.android.build.gradle.internal.dsl.BuildType.
   报的错,里面的属性集合可以一看

9. signingConfig 闭包领域配置

   以RN为例

   ```groovy
   //定义一个signingConfigs集合
   signingConfigs {
           release {
               storeFile file("key.jks")
               storePassword "123456" 
               keyAlias "xys"
               keyPassword "123456"
           }
         //可在gradle.properties文件中定义
         //MYAPP_RELEASE_STORE_FILE=key.jks
         //MYAPP_RELEASE_KEY_ALIAS=123456
         //MYAPP_RELEASE_STORE_PASSWORD=xys
         //MYAPP_RELEASE_KEY_PASSWORD=123456   
          release2 {
               storeFile file(MYAPP_RELEASE_STORE_FILE)
               storePassword MYAPP_RELEASE_STORE_PASSWORD
               keyAlias MYAPP_RELEASE_KEY_ALIAS
               keyPassword MYAPP_RELEASE_KEY_PASSWORD
           }
       }
   //在buildTypes中引用
   buildTypes {
           release {
               minifyEnabled enableProguardInReleaseBuilds
               proguardFiles getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro"
               signingConfig signingConfigs.release
           }
       }
   ```

10. compileOptions

   ```groovy
   compileOptions{
       sourceCompatibility JavaVersion.VERSION_1_8
       targetCompatibility JavaVersion.VERSION_1_8
   }
   //有坑 感觉不用这样就可以使用,鸡肋
   ```

11. lintOptions

    ```groovy
    lintOptions{ //语法拼写检查配置
        abortOnError false //在发生语法错误不抛出,编译文件时
    }
    ```