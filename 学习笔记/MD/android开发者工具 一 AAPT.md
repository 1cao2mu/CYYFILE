android开发者工具 一  APPT

SDK  英Software Development Kit 

1. AAPT初探

   英Android Asset Packageing Tool 

2. 列举apk内容文件

   进入某个build-tools 例：进入23.0.1（cd 23.0.1，需先进入sdk/build-tools）

   ./aapt l[ist] <APk path>

   可将日志文件定向到txt文件

   ./aapt l[ist] <APk path>  >×××.txt

   可将过滤一些信息（其它输出信息的也可使用）

   ./aapt l[ist] <APk path>  | grep package

   可加入-v（以表格的形式展示） 可加入-a(？看不太懂)  

3. 查看指定文件信息

   ```shell
   ./aapt d[ump]  [--values] <apk path>
   ```

   values 参数值

   badging  输出label和icon的信息

   permissions  输出权限的信息

   resources 输出资源的信息

   configurations  输出配置的信息

   xmltree  输出（？）的信息 assets中的xml

   xmlstrings  输出（？）的信息 assets中的string

4. 修改apk包

   aapt p(ackage) 打包生成资源压缩包 

   aapt r(emove) 从压缩包中删除指定文件

   aapt a(dd) 向压缩包中添加指定文件

5. 显示aapt版本信息

   ./aapt v 

6. 查看所有命令

   ./aapt





