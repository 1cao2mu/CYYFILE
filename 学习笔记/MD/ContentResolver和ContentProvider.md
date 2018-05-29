ContentResolver和ContentProvider

1. ContentResolver(内容解析器)

   ContentProvider(内容提供器)向外部提供数据(类似数据库),通过ContentResolver(内容解析器)来获取解析,先不说自定义的ContentProvider(内容提供器),以android系统自带的通讯录,短信,媒体库为例,大致理解一下

   ```java
   private void readContact() {
           //6.0和7.0,需要处理权限问题
           Cursor cursor = null;
           //查询联系人数据
           //获取ContentResolver(内容解析器),之后,查询获取游标
           //queryquery( Uri uri,String[] projection, String selection,String[] selectionArgs,String sortOrder)
    cursor=getContentResolver().query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null, null, null, null);
           if (cursor != null) {
               while (cursor.moveToNext()) {
                       String name=cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME));
                   String number=cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
               }
           }
       }
   ```

   |      query()方法参数       |         对应sql部分          |        描述         |
   | :--------------------: | :----------------------: | :---------------: |
   |        Uri uri         |     from table_name      |     指定应用程序和表名     |
   |  String[] projection   |  select column1,column2  |      指定查询的表名      |
   |    String selection    |    where column=value    |   指定where的约束条件    |
   | String[] selectionArgs |            -             | 为where中的占位符提供具体的值 |
   |    String sortOrder    | order by column1,column2 |    指定查询结果的排序方式    |

   增删改查,刚才的代码是查询

   增加插入示例

   ```java
   ContentValues values=new ContentValues();
   values.put("column1","text");
   values.put("column2",1);
   getContentResolver().insert(Uri,values);

   //insert(@RequiresPermission.Write @NonNull Uri url,@Nullable ContentValues values)
   //@RequiresPermission.Write 代表需要写入权限
   //@NonNull 不可为空
   //@Nullable  可为空
   ```

   删除示例

   ```java
   //delete(@RequiresPermission.Write @NonNull Uri url, @Nullable String where,@Nullable String[] selectionArgs);
   getContentResolver().delete(uri,"column=?",new String[]{"1"});
   //@RequiresPermission.Write 
   //@NonNull 不可为空
   //@Nullable  可为空
   ```

   修改示例

   ```java
   ContentValues values=new ContentValues();
   values.put("column1","text2");
   values.put("column2",2);
   getContentResolver().update(uri,values,"column1 = ? and column2 = ?",new String[]{"text","1"});
   //update(@RequiresPermission.Write @NonNull Uri uri, @Nullable ContentValues values, @Nullable String where, @Nullable String[] selectionArgs)
   //@RequiresPermission.Write 代表需要写入权限
   //@NonNull 不可为空
   //@Nullable  可为空
   ```

2. ContentProvider(内容提供器)

   1). URI 

   在电脑术语中，统一资源标识符（Uniform [Resource](http://baike.baidu.com/item/Resource) Identifier，或URI)是一个用于标识某一互联网资源名称的字符串。 该种标识允许用户对任何（包括本地和互联网）的资源通过特定的协议进行交互操作。URI由包括确定语法和相关协议的方案所定义。(百度百科-_-)

   大致我的理解就是资源地址，在ContentProvider中的URI开头content://,所以可以叫内容URI,URL其实就是URI开头为网络协议的,比如https://,http://(暂时我这是这么理解的)

   ```
   content://com.example.databasetest.provider/*
   content://com.example.databasetest.provider/table1/#
   ```

​       com.example.databasetest.provider   所指应用的包名

​        /table1/    所指的表名      *  代表任意长度的字符  # 代表任意长度的数字

​        2)通过UriMatcher   来匹配不同的访问,不同的uri访问不同的内容


   ```java
    //初始化 UriMatcher,  
    public static final String AUTHORITY = "com.example.databasetest.provider";
    public static final int BOOK_DIR = 0;
    public static final int BOOK_ITEM = 1;
    public static final int CATEGORY_DIR = 2;
    public static final int CATEGORY_ITEM = 3;
    static {
        uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
        uriMatcher.addURI(AUTHORITY, "book", BOOK_DIR);
        uriMatcher.addURI(AUTHORITY, "book/#", BOOK_ITEM);
        uriMatcher.addURI(AUTHORITY, "category", CATEGORY_DIR);
        uriMatcher.addURI(AUTHORITY, "category/#", CATEGORY_ITEM);
    }
   ```

​             初始化UriMatcher,并添加addURI,之后可以通过uriMatcher.match(uri).获取不同的tag(BOOK_DIR,BOOK_ITEM,CATEGORY_DIR,CATEGORY_ITEM),完成匹配

​         3)query()

```java
private MyDatabaseHelper dbHelper;

@Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) {
        // 查询数据
        SQLiteDatabase db = dbHelper.getReadableDatabase();//获取数据库
        Cursor cursor = null;
        switch (uriMatcher.match(uri)) {
            case BOOK_DIR:
                cursor = db.query("Book", projection, selection, selectionArgs, null, null, sortOrder);
                break;
            case BOOK_ITEM:
                String bookId = uri.getPathSegments().get(1);
                cursor = db.query("Book", projection, "id = ?", new String[] { bookId }, null, null, sortOrder);
                break;
            case CATEGORY_DIR:
                cursor = db.query("Category", projection, selection, selectionArgs, null, null, sortOrder);
                break;
            case CATEGORY_ITEM:
                String categoryId = uri.getPathSegments().get(1);
                cursor = db.query("Category", projection, "id = ?", new String[] { categoryId }, null, null, sortOrder);
                break;
            default:
                break;
        }
        return cursor;
    }

//其余三种类似,其实就是内嵌的SQLiteDatabase操作,唯一难理解的地方就是uri.getPathSegments()
//getPathSegments()方法返回的是元素为String的List对象。并且他将"/"符号的右边第一个截取下来。 下标从0开始。   get(1)也就是id   get(0)也就book或者category
```

​        4)getType  

```java
//用于获取Uri对象所对应的MIME类型
//MIME(Multipurpose Internet Mail Extensions)多用途互联网邮件扩展类型。是设定某种扩展名的文件用一种应用程序来打开的方式类型，当该扩展名文件被访问的时候，浏览器会自动使用指定应用程序来打开。多用于指定一些客户端自定义的文件名，以及一些媒体文件打开方式。(百度百科-_-)
//还是看不懂
//在ContentProvider的getType(Uri)方法中，可以显示的返回一个MIME类型，该方法返回一个字符串，可以是任意的字符串，当我们显示的返回该MIME类型的时候，相当于通过该方法的验证，Provider可以识别自身其他方法返回的Cursor的内容，不需要在进行更多的验证；如果返回其他的字符串(非android能够识别的MIME类型，例如直接返回当前的包名)，则Provider在执行其他方法后，返回Cursor类型的时候，需要再次进行验证。引用(http://blog.csdn.net/justljf/article/details/51115660)
//还是看不懂
//我放弃治疗了,等未来沉淀吧
@Override
    public String getType(Uri uri) {
        switch (uriMatcher.match(uri)) {
            case BOOK_DIR:
                return "vnd.android.cursor.dir/vnd.com.example.databasetest. provider.book";
            case BOOK_ITEM:
                return "vnd.android.cursor.item/vnd.com.example.databasetest. provider.book";
            case CATEGORY_DIR:
                return "vnd.android.cursor.dir/vnd.com.example.databasetest. provider.category";
            case CATEGORY_ITEM:
                return "vnd.android.cursor.item/vnd.com.example.databasetest. provider.category";
        }
        return null;
    }
```
​ 5). 读取数据    

```java
// 添加数据
Uri uri = Uri.parse("content://com.example.databasetest.provider/book");
ContentValues values = new ContentValues();
values.put("name", "A Clash of Kings");
values.put("author", "George Martin");
values.put("pages", 1040);
values.put("price", 55.55);
Uri newUri = getContentResolver().insert(uri, values);
newId = newUri.getPathSegments().get(1);

 // 查询数据
                Uri uri = Uri.parse("content://com.example.databasetest.provider/book");
                Cursor cursor = getContentResolver().query(uri, null, null, null, null);
                if (cursor != null) {
                    while (cursor.moveToNext()) {
                        String name = cursor.getString(cursor. getColumnIndex("name"));
                        String author = cursor.getString(cursor. getColumnIndex("author"));
                        int pages = cursor.getInt(cursor.getColumnIndex ("pages"));
                        double price = cursor.getDouble(cursor. getColumnIndex("price"));
                        Log.d("MainActivity", "book name is " + name);
                        Log.d("MainActivity", "book author is " + author);
                        Log.d("MainActivity", "book pages is " + pages);
                        Log.d("MainActivity", "book price is " + price);
                    }
                    cursor.close();
                }
 // 更新数据
                Uri uri = Uri.parse("content://com.example.databasetest.provider/book/" + newId);
                ContentValues values = new ContentValues();
                values.put("name", "A Storm of Swords");
                values.put("pages", 1216);
                values.put("price", 24.05);
                getContentResolver().update(uri, values, null, null);

// 删除数据
                Uri uri = Uri.parse("content://com.example.databasetest.provider/book/" + newId);
                getContentResolver().delete(uri, null, null);
```