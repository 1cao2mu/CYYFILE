Gradle 学习 二

1. Gradle 动态参数配置

   ```groovy
   //在gradle.properties中
   SystemProp.vc=1 //System.properties引用方式的变量定义
   xxx.vn="1.0" //project.property引用方式的变量定义
   MS=15 // 直接引用方式的变量定义
   ```

   ```groovy
   //在app/build.gradle
   minSdkVersion MS  //System.properties引用变量
   versionCode System.properties['vc'] //project.property引用变量
   versionName project.property('xxx.vn') //直接引用变量
   ```

   这个方法重要运用于  打包签名的配置

2. 系统参数

   在build.gradle中,根目录或者app目录都可以

   ```groovy
   //新建一个打印系统参数任务
   task pr << {
       println project project标识
       println project.name project名字
       println project.buildDir project构建目录
       println project.buildFile project构建文件
       println project.version project版本信息
       println name Task的名字
       println buildDir project构建文件的存放位置
       println path task的定位的路径地址
   } 
   //在terminal中
   gradlew pr
   //就会这些信息
   ```

3. 多渠道打包

   感觉鸡肋 不学 还是记录一下

   ```xml
   <meta-data
       android:name="PRODUCT"
       android:value="${CHANNEL_VALUE}"
       />
   ```

   ```groovy
   //app目录下build.gradle android 闭包中
   productFlavors {
       pr1 {
           manifestPlaceholders = [CHANNEL_VALUE: "pr1"]
       }
       pr2 {
           manifestPlaceholders = [CHANNEL_VALUE: "pr2"]
       }
       pr3 {
           manifestPlaceholders = [CHANNEL_VALUE: "pr3"]
       }
   }
   //termail中执行gradlew build,生成的是注意未签名的包
   ```

4. 多渠道打包脚本优化

   ```groovy
   //app目录下build.gradle android 闭包中修改
   productFlavors {
           pr1 {
   //            manifestPlaceholders = [CHANNEL_VALUE: "pr1"]
           }
           pr2 {
   //            manifestPlaceholders = [CHANNEL_VALUE: "pr2"]
           }
           pr3 {
   //            manifestPlaceholders = [CHANNEL_VALUE: "pr3"]
           }
       }
       productFlavors.all { flavor ->
           flavor.manifestPlaceholders = [CHANNEL_VALUE:name]
       }
   ```

5. 生成包重新命名

   ```groovy
   //app目录下build.gradle android 闭包中添加
   applicationVariants.all { variant ->
       variant.outputs.each { output ->
           def outputFile = output.outputFile
           if (outputFile != null && outputFile.name.endsWith('.apk')) {
               def fileName = "自定义_${defaultConfig.versionName}_${variant.buildType.name}_${variant.productFlavors[0].name}.apk"
               output.outputFile = new File(outputFile.parent, fileName)
           }
       }
   }
   ```

6. 不同的版本添加不同的代码

   ```groovy
   buildTypes {
       release {
           minifyEnabled false
           proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
       }
       ttt.initWith(buildTypes.release)
       ttt {
           applicationIdSuffix ".ttt"
           buildConfigField "boolean","textflag","true"
           buildConfigField "String","textflag1","\"aaa\"" 
       }
       sss.initWith(buildTypes.release)
       ttt {
           applicationIdSuffix ".sss"
           buildConfigField "boolean","textflag","false"
           buildConfigField "String","textflag1","\"bbb\""
       }
   }
   //在代码中可以通过获取buildConfig,做不同的代码

   //可在defaultConfig中设置默认配置
   defaultConfig {
           applicationId "com.example.caoyang.ctest"
           minSdkVersion MS
           targetSdkVersion 26
           versionCode System.properties['vc']
           versionName project.property('xxx.vn')
           testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
           resValue  "string", "textflag1", "\"moren\""
       }
   //可以通过这个方法在不同的buildType中的设置不同的 app_name等属性
   //相当与res/string中加入<string name="textflag1" translatable="false">"moren"</string>
   ```

7. 依赖

   ```groovy
   dependencies {
       compile fileTree(dir: 'libs', include: ['*.jar']) 
       //app/libs目录里面存储的jar文件依赖
       androidTestCompile('com.android.support.test.espresso:espresso-core:2.2.2', {
           exclude group: 'com.android.support', module: 'support-annotations'
       })
       //android单测试依赖包
       compile 'com.android.support:appcompat-v7:26.+'
       compile 'com.android.support.constraint:constraint-layout:1.0.2'
       //  
       compile files('libs/logcollect.jar')
       //某文件地址里面的jar文件的依赖 
       testCompile 'junit:junit:4.12'
       //junit单元测试依赖包
   }
   ```

8. Gradle编译成jar,编译测试之后,不可使用,有缺陷

9. so依赖 

   src/main/jnilibs文件夹 分别CPU分类 armeabi armeabi-v7a等等

   可以在build.gradle中指定一个目录做为jniLibs

   ```groovy
   sourceSets {
       main {
           jniLibs.srcDirs = ['src/yyy']
       }
   }
   ```

10. 本地库项目依赖

   1),new Module  

   2).setting.gradle中

   ```groovy
   include ':app', ':mylibrary'
   //':mylibrary'是加入的
   ```

   3)build.gradle 中

   ```groovy
   compile project(':mylibrary')
   ```

