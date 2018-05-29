android存储---文件存储

1. 存储路径

   data/data/<packagename>/files/目录下  文件名在openFileOutput时定义,在真机上,这个文件是隐藏的

2. 存储模式

   主要模式有两种  Context.MODE_APPEND和Context.MODE_PRIVATE

   Context.MODE_PRIVATE:同样文件名时会被覆盖

   Context.MODE_PRIVATE:同样文件名是,会往后面追加内容

   Context.MODE_WORLD_READABLE和Context.MODE_WORLD_WRITEABLE,这两个过时了,可能被其他应用访问

3. 存值方法例子

   ```java
   private void save() {
       String data = "要存储的字符串";
       FileOutputStream fos = null;
       BufferedWriter writer = null;
       try {
           fos = openFileOutput("data", Context.MODE_APPEND);
           writer = new BufferedWriter(new OutputStreamWriter(fos));
           writer.write(data);
       } catch (IOException e) {
           e.printStackTrace();
       } finally {
           try {
               if (writer != null) {
                   writer.close();
               }
           } catch (IOException e) {
               e.printStackTrace();
           }
       }
   }
   ```

   4. 取值方法

      ```java
       private String load() {
                  FileInputStream in = null;
                  BufferedReader reader = null;
                  StringBuilder content = new StringBuilder();
                  try {
                      in = openFileInput("data");
                      reader = new BufferedReader(new InputStreamReader(in));
                      String line = "";
                      while ((line = reader.readLine()) != null) {
                          content.append(line);
                      }
                  } catch (IOException e) {
                      e.printStackTrace();
                  } finally {
                      if (reader != null) {
                          try {
                              reader.close();
                          } catch (IOException e) {
                              e.printStackTrace();
                          }
                      }
                  }
                  return content.toString();
          }
      ```