as实战 重构代码

1. refactor this

   ctrl+alt+shift+t

2. 重命名

   shift+f6

3. 修改签名(方法的可见性,名称,返回类型,参数,抛出的异常)

   光标在方法名上,ctrl+f6

4. 类型迁移(变量类型修改)

   ctrl+shift+f6

5. 移动 f6

6. 复制 f5

7. 安全删除 delete

8. 抽取

   抽取变量:ctrl+shift+v 字符串(或其他类型)->变量

   抽取常量:ctrl+shift+c 字符串(或其他类型)->变量

   抽取字段:ctrl+shift+f  方法内变量->类内变量

   抽取参数:ctrl+shift+p  

   抽取方法:ctrl+shift+m

9. 高级重构

   下推成员和上拉成员(继承关系,子类和父类): 

   refactor|pull members up 和refactor |push members down

   使用代理代替继承:

   refactor|replace inheritance with delegation

   封装字段:(类似getter和setter)

   refactor|encapsulate fields

   封装方法返回值:

   refactor|warp method return value 无法确认

   使用工厂方法代替构造函数

   refactor| repalce constructor with factor method 

   使用建筑者方法代替构造函数

   refactor| repalce constructor with fbuilder

   将匿名类转换为内部类

   ​

   ​