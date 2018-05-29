Gradle 学习 四

1. 生成Gradle编译脚本

   gradle init wrapper

   //需要安装gradle,鸡肋

2. Gradle peer not authenticated

   需要使用VPN访问,其实现在没问题了

   ```groovy
   //或者这样做,修改jcenter
   jcenter{
       url "http://jcenter.bintray.com"
   }
   //其实没遇到过
   ```

3. Gradle 性能检测

   win系统开发,使用as非常吃内存,现在不用固态,基本上处于自行车时代

   linux对as比较友好,自从换了系统感觉非常舒爽啊

   gradle build -profile //使用后无输出

4. Gradle加速

   换固态,或者mac,或者linux,或者设置一些属性,增加编译时分配的内存,前提是你有足够的内存可以使用,而且as用的内存多了,别的软件自然会卡,系统会卡,所以不解决根本问题

   在gradle.properties

   ```groovy
   org.gradle.jvmargs=-Xmx1536m  //如果虚拟编译运行内存够,还可以加,但是jdk必须是64位的
   org.gradle.parallel=true 
   org.gradle.daemon=true
   org.gradle.configureondmand=true  //开启多现成和多核心支持
   ```

   在build.gradle

   ```groovy
   dexOptions{
       incremental true //过时了,开启增量编译
       javaMaxHeapSize "4g" //增加编译内存到4g
   }
   //系统好最好,其次硬件,设置这些属性最次的方法,但是最廉价
   ```

5. Gradle调用终端命令

   ```groovy
   task tt() {
       println 'git log'.execute([],project.rootDir).text
   }
   //在gradlew tt  就是==git log的结果,速度会比较慢,不推荐
   ```

6. Gradle精简资源res

   从未引用过的资源在编译的时候删除

   一种可以在gradle中使用

   ```groovy
   buildTypes {
           release {
               minifyEnabled false
               shrinkResources true //只有minifyEnabled为true时shrinkResources才起效
               proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
           }
           }
   ```

   第二种，在as中直接调用remove unused resources  

   可以ctrl+shift+a 然后搜索或者在顶部导航栏Refactor中点击

7. 清除gradle缓存

   1）gradle clean 

   2）gradle --refresh-dependencies 强制刷新所依赖的库项目

8. 使用Gradle本地缓存？

9. Gradle 版本问题导致的编译问题

   一种.新建空工程,gradle-wrapper.properties和空工程保持一致,com.android.tools.build:gradle和空工程也保持一致

   二种.安装本地的gradle不使用gradle-wrapper

10. Gradle 资源冲突

   间常遇到包引用重复，尤其v4包,facebook的几个包

   Multiple dex files define XXXX

   检查包依赖关系，去除不同版本的依赖包

   grdlew androidDependencies 可以简写为gradle androidD

   显示依赖关系图 

   ​

   ​