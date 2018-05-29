Gradle 学习 三

1. 远程仓库 jcenter和mavenCentral

   mavenCentral的地址:http://mvnrepository.com/

2. 本地私有仓库maven

   ```groovy
   buildscript {
       repositories {
           mavenLocal()
           maven {
               url "http://mvnrepository.com"
           }
           jcenter()
           mavenCentral()
       }
       dependencies {
           classpath 'com.android.tools.build:gradle:2.3.3'

           // NOTE: Do not place your application dependencies here; they belong
           // in the individual module build.gradle files
       }
   }

   allprojects {
       repositories {
           mavenLocal()
           maven {
               url "http://mvnrepository.com"
           }
           jcenter()
           mavenCentral()
       }
   }
   ```

3. 本地arr依赖

   1)新建module之后,编译通过后

   2)选择工程  new  module->import arr

   3)build.gradle中加入 compile project(':arr名字')

4. 使用Gradle上传arr到Maven库  暂略

5. Gradle依赖库缓存 

   不懂  ./gradle文件夹里面存储缓存??

6. Gradle通知机制

   ```groovy
   compile('org.springframework:spring-web:5.0.0.RELEASE') {
       transitive = true //去除在下载spring-web时,是否下载其它的springframework组件
   }
   ```

7. Gradle的依赖检查

   grdlew androidDependencies 可以简写为gradle androidD

   显示依赖关系图

8. Gradle的依赖传递 

   不懂  用了几个方法不好用

9. Gradle依赖的统一参数管理

   在根目录build.gradle中

   ```groovy
   ext {
       android = [cSV: 26,
                  bTV: '26.0.1']
       dependencies=[v7:'com.android.support:appcompat-v7:26.+']
   }    
   ```

   在app目录build.gradle中引用这些值

   ```groovy
   compileSdkVersion rootProject.ext.android.cSV
   buildToolsVersion rootProject.ext.android.bTV
   compile rootProject.ext.dependencies.v7
   ```

   也可以单独写一个文件,但是需要在app目录build.gradle中引用这个文件apply from:'xxx.gradle'   xxx.gradle文件名

   ​

