Android存储---SQLite数据库存储

1. 存储路径

   /data/data/<package name>/databases/文件夹下

2. 打开的模式

   借助SQLiteOpenHelper来实现数据库的管理的情况下,打开数据库(SQLiteDatabase),有两种模式

   ```java
   mySQLiteOpenHelper.getReadableDatabase();
   mySQLiteOpenHelper.getWritableDatabase();
   ```

​       两个方法相似,但是getWritableDatabase在磁盘已满的情况下话,会报异常,getReadableDatabase在这样的情况下会以只读的模式打开

3. SQLiteOpenHelper自定义

   插入的表有点多啊

   ```java

   /**
    * 建一个Sqlite帮助类
    */
   public class MySqliteHelper extends SQLiteOpenHelper {
       //数据库的名称
       private static String NAME = "school.db";
       //数据库的版本
       private static int VERSION = 1;
       /**
        * @param context 上下文对象
        * @param name    数据库的名称
        * @param factory 游标工厂
        * @param version 数据库的版本
        */
       public MySqliteHelper(Context context, String name, CursorFactory factory,
                             int version) {
           super(context, name, factory, version);
       }
       public MySqliteHelper(Context context) {
           super(context, NAME, null, VERSION);
       }
       /**
        * 数据库第一次创建时   回调此方法
        */
       @Override
       public void onCreate(SQLiteDatabase db) {
           // TODO Auto-generated method stub
           String sql = "create table person(_id integer primary key autoincrement,tel varchar(11),pwd varchar(16),name varchar(16),number varchar(16),image varchar(160))";
           //执行数据库语句
           db.execSQL(sql);
           sql = "create table loseThing(_id integer primary key autoincrement,uid integer,image varchar(160),name varchar(16),thingName varchar(16),tel varchar(11),address varchar(50))";
           //执行数据库语句
           db.execSQL(sql);
           sql = "create table help(_id integer primary key autoincrement,uid integer,time varchar(16),content varchar(160))";
           //执行数据库语句
           db.execSQL(sql);
           sql = "create table findTab(fid integer primary key autoincrement,uid integer,uname varchar(16),uimage varchar(160),content text,image varchar(160),topCount integer,bottomCount integer,commitCount integer,topId text,bottomId text,commitId text)";
           //执行数据库语句
           db.execSQL(sql);
           sql = "create table findTabCommit(_id integer primary key autoincrement,fid integer,uid integer,uname varchar(16),uimage varchar(160),content text)";
           //执行数据库语句
           db.execSQL(sql);
         
           sql = "create table adviseTab(fid integer primary key autoincrement,uid integer,uname varchar(16),uimage varchar(160),content text,image varchar(160),topCount integer,bottomCount integer,commitCount integer,topId text,bottomId text,commitId text)";
           //执行数据库语句
           db.execSQL(sql);
           sql = "create table adviseTabCommit(_id integer primary key autoincrement,fid integer,uid integer,uname varchar(16),uimage varchar(160),content text)";
           //执行数据库语句
           db.execSQL(sql);
           sql = "create table newTab(fid integer primary key autoincrement,uid integer,uname varchar(16),uimage varchar(160),content text,image varchar(160),topCount integer,bottomCount integer,commitCount integer,topId text,bottomId text,commitId text)";
           //执行数据库语句
           db.execSQL(sql);
           sql = "create table newTabCommit(_id integer primary key autoincrement,fid integer,uid integer,uname varchar(16),uimage varchar(160),content text)";
           //执行数据库语句
           db.execSQL(sql);
       }

       /**
        * 数据库版本发生改变时调用  newVersion>oldVersion  数据库版本升级
        */
       @Override
       public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
           if (newVersion > oldVersion) {
               Log.i("==onUpgrade==", "数据库版本升级");
           }
       }

       /**
        * 数据库版本发生改变时调用   newVersion<oldVersion 数据库版本降级
        * <p/>
        * 只有发生重大错误时才调用此方法
        */
       @Override
       public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
           super.onDowngrade(db, oldVersion, newVersion);
           if (newVersion < oldVersion) {
               Log.i("==onDowngrade==", "数据库版本降级");
           }
       }

       /**
        * 每次打开数据库时调用的方法   主要是验证数据库打没打开
        */
       @Override
       public void onOpen(SQLiteDatabase db) {
           // TODO Auto-generated method stub
           super.onOpen(db);
           Log.i("==onOpen==", "数据库打开");
       }

   }
   ```

   之前写的一个范例

   sql语句得会,不会这个就没办法学,

   4. 增删改查

      四种操作,需要sql基础,不要也可以,差不多就行了

      会sql的话,直接db.execSQL(sql语句)或者db.rawQuery();就可以了

      不会的话就麻烦了

      插入范例

      ```java

       public static boolean addFindTab(MySqliteHelper helper, String loginId, String uname, String uimage, String image, String content) throws JSONException {
              SQLiteDatabase db1 = helper.getReadableDatabase();
              ContentValues values = new ContentValues();
              values.put("uid", String.valueOf(loginId));
              values.put("uname", uname);
              values.put("uimage", uimage);
              values.put("content", content);
              values.put("image", image);
              long i = db1.insert("findTab", null, values);
              db1.close();
              if (i == -1) {
                  //失败
                  return false;
              } else {
                  //成功
                  return true;
              }
          }
      ```

      删除范例

      ```java
      public static boolean removeMyLossThingData(MySqliteHelper helper, int id, String loginId) throws JSONException {
              SQLiteDatabase db4 = helper.getReadableDatabase();
              /**
               * 参数1：数据库表名
               * 参数2：where 条件语句  _id = ?
               * 参数3： 条件语句的值   new String []{"1"}
               */
              int num1 = db4.delete("loseThing", "_id = ?", new String[]{String.valueOf(id)});
              db4.close();
              if (num1 > 0) {
                  return true;
              } else {
                  return false;
              }
          }
      ```

      ​  改更新,我这个工程里竟然没有

      ```java
           ContentValues values2 = new ContentValues();
            values2.put("pwd", passwrod);
            int num = db2.update("person", values2, "tel = ?", new String[]{phone});
            if (num > 0) {
                Utils.showToast(getContext(), "修改成功");
            } else {
                Utils.showToast(getContext(), "修改失败");
            }
      ```

      ​            

      查询,范例

      ```java
      public static JSONArray getLossThingData(MySqliteHelper helper, int page) throws JSONException {
          JSONArray jsonArray = new JSONArray();
          SQLiteDatabase db = helper.getReadableDatabase();
          /**
           * 参数1：表名
           * 参数2：字段数组
           * 参数2：字段数组
           * 参数3：查询的条件  _id = ?
           * 参数4：查询条件的值  new String{"1"}
           * 参数5：分组字段
           * 参数6：在where条件后再次筛选
           * 参数7：查询排序
           *
           */
          Cursor cursor = db.query("loseThing", null, null, null, null, null, "_id desc");
          Utils.sysout("+++++" + cursor.getCount());
          cursor.moveToPosition((page - 1) * Constants.PAGE_SIZE - 1);
          while (cursor.moveToNext()) {
              JSONObject object = new JSONObject();
              object.put("_id", cursor.getString(cursor.getColumnIndex("_id")));
              object.put("uid", cursor.getString(cursor.getColumnIndex("uid")));
              object.put("image", cursor.getString(cursor.getColumnIndex("image")));
              object.put("name", cursor.getString(cursor.getColumnIndex("name")));
              object.put("thingName", cursor.getString(cursor.getColumnIndex("thingName")));
              object.put("tel", cursor.getString(cursor.getColumnIndex("tel")));
              object.put("address", cursor.getString(cursor.getColumnIndex("address")));
              jsonArray.put(object);
              if (jsonArray.length() == Constants.PAGE_SIZE) {
                  break;
              }
          }
          db.close();
          return jsonArray;
      }
      ```

      完美

      ​