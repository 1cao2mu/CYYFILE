Gradle 学习 六  思考

实践出真知。

学而不思则罔(迷惑而无所得)，思而不学则殆(精神疲倦而无所得)。

1. Grvoovy 特点

   Grvooy之于gradle，等同于java之于android

   基于JVM运行的一种语言

   sdk地址：http://www.groovy-lang.org/api.html

2. Groovy Task 

   hello world 最简单的Task

   ```groovy
   task hello {
       println("hello world")
   }
   ```

   包含Action的Task

   ```groovy
   task ctest {
       println("hello world")

       doFirst {
           println("do first")
       }
       doLast {
           println("do last")
       }
   }
   //输出结果  两个阶段配置（configration）阶段，编译阶段（build）
   //> Configure project :
   //hello world

   //> Task :ctest
   //do first
   //do last
   ```

   包含Action的简写

   ```groovy
   task ctestDoFirst<< {
       println("hello world first ")
   }
   //等于
   task ctest {
          doFirst {
          println("hello world first")
          }
   }
   //Action方便在编译生命周期中完成自己的指定操作
   ```

   UP-TO-DATE

   在编译过程中，有时发现的日志

   ：projectName：taskName：UP-TO-DATE

   代表这个任务没有做出更改，使用缓存，跳过编译过程，加快编译速度

3. Groovy Task 依赖

   ```groovy
   //dependsOn
   task cctest1<<{
       println('cctest1')
   }
   task cctest2<< {
       println('cctest2')
   }
   cctest1.dependsOn cctest2
   //gradle cctest1结果
   //> Task :cctest2
   //cctest2

   //> Task :cctest1
   //cctest1
   cctest1.finalizedBy cctest2
   //gradle cctest1结果
   //> Task :cctest2
   //cctest2

   //> Task :cctest1
   //cctest1
   //可以通过finalizedBy做清理和回收任务
   cctest1.enabled=false
   //enabled 是否可用
   //gradle cctest1结果
   //> Task :cctest2
   //cctest2
   cctest2.enabled=false
   //gradle cctest1结果
   //> Task :cctest1
   //cctest1
   ```

   ```groovy
   //跳过测试的编译，提高速度
   tasks.whenTaskAdded { task ->
       if (task.name.contains('test')) {
           task.enabled = false
       }
   }
   ```

4. Groovy 类型

   jar类型

   ```groovy
   task makeJar(type: Jar) {
       delete "libs/sdk.jar"
       baseName "sdk"
       from('build/intermediates/classes/pr1/debug/com/example/caoyang/ctest/')
       into('com/example/caoyang/')
       exclude('test/', 'BuildConfig.class', 'R.class')
       exclude { it.name.startsWith('R$'); }
   }
   ```

   copy

   ```groovy
   task testCopy(type: Copy) {
       from 'app/src/main/res/layout'
       into 'app/tsrc'
   }
   //使用时，请不要使用上面跳过测试的方法/笑哭
   ```

5. Gradle 项目架构

   gradle projects 查看所有的工程   app和module

   gradle task 查看所有的任务 

6. Gradle 生命周期

   Initiliazation 初始化阶段 执行项目中的setting.gradle

   configration 解析所有build.gradle 解析所有的编译选项，生成有限关系图 taskgraph

   build 按照configration阶段获取的关系图，进行具体的编译

7. Gradle 生命周期的监听

   ```groovy
   gradle.addBuildListener new MyListener()

   class MyListener implements TaskExecutionListener, BuildListener {

       private Clock clock
       private execution = []

       @Override
       void buildStarted(Gradle gradle) {

       }

       @Override
       void settingsEvaluated(Settings settings) {

       }

       @Override
       void projectsLoaded(Gradle gradle) {

       }

       @Override
       void projectsEvaluated(Gradle gradle) {

       }

       @Override
       void buildFinished(BuildResult result) {
           println 'task execute time'
           for (time in execution) {
               printf "%7sms  %s\n", time
           }
       }

       @Override
       void beforeExecute(Task task) {
           clock = new Clock();
       }

       @Override
       void afterExecute(Task task, TaskState state) {
           def ms = clock.timeInMs
           execution.add([ms, task.path])
           println "task:${task.path} took ${ms}ms"
       }
   }
   ```

8. android studio 的图像化界面

   选中项目右键 ->open module settiings 可对应对gradle的各个选项进行修改，

   包括 peoperties(编译的一些属性配置),signing(签名配置),flavors(多渠道配置)，buildTypes(编译类型配置),dependencies(依赖项目的配置）

   窗口右侧有gradle的导航栏，有具体的gradle task