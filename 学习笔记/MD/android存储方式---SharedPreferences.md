android存储方式---SharedPreferences

1. 存储路径

   data/data/<package name>/shared_prefs/ 文件夹下  模拟器中的这个文件夹可以看到,真机看不到

2. 存储模式

   目前只有MODE_PRIVATE模式可用,其余的模式,已经在4.2之后被废弃

3. 具体的存储数据编码

   首先实例化SharedPreferences，然后获取SharedPreferences.Editor，再然后对Editor进行存储数据，最后对Editor应用提交，存储数据成功

   ```java
    SharedPreferences sharedPreferences=getSharedPreferences("myname",Context.MODE_PRIVATE);//实例化SharedPreferences
           SharedPreferences.Editor editor=sharedPreferences.edit();//获取SharedPreferences.Editor
           editor.putInt("intkey",0);
           editor.putBoolean("booleankey",true);
           editor.putLong("longkey",1000l);
           editor.putFloat("floatkey",100f);
           editor.putString("stringkey","heheda");//对Editor进行存储数据
           editor.apply();//对Editor应用提交
   ```

4. 具体的读取数据编码

   ```java
   SharedPreferences sp=getSharedPreferences("myname",Context.MODE_PRIVATE);
   sp.getBoolean("booleankey",false);
   sp.getInt("intkey",-1);
   sp.getLong("longkey",-1);
   sp.getFloat("floatkey",-1f);
   sp.getString("stringkey","");
   ```

