Material Design

1. Toolbar

   ```xml
   //android:layout_height="?attr/actionBarSize" actionBarSize获取系统设置的高度写wrap_content
   //android:background="?attr/colorPrimary" //其实不用设置默认是这颜色,不过可以设置其它颜色
   //android:theme="@style/ThemeOverlay.AppCompat.Dark.ActionBar" 导航栏颜色
   //app:popupTheme="@style/ThemeOverlay.AppCompat.Light" 弹出菜单栏颜色
   //app:layout_scrollFlags="scroll|enterAlways|snap" 滑动类型
   //
   <android.support.v7.widget.Toolbar
       android:id="@+id/toolbar"
       android:layout_width="match_parent" 
       android:layout_height="?attr/actionBarSize" 
       android:background="?attr/colorPrimary" //其实不用设置默认是这颜色
       android:theme="@style/ThemeOverlay.AppCompat.Dark.ActionBar"
       app:popupTheme="@style/ThemeOverlay.AppCompat.Light"
       app:layout_scrollFlags="scroll|enterAlways|snap" />
   ```

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <menu xmlns:android="http://schemas.android.com/apk/res/android"
       xmlns:app="http://schemas.android.com/apk/res-auto">
     //app:showAsAction="always" 总是直接展示 
       <item
           android:id="@+id/backup"
           android:icon="@drawable/ic_backup"
           android:title="Backup"
           app:showAsAction="always"/>
     //app:showAsAction="ifRoom" 如果有空间直接展示
       <item
           android:id="@+id/delete"
           android:icon="@drawable/ic_delete"
           android:title="Delete"
           app:showAsAction="ifRoom"/>
     //app:showAsAction="never" 从不直接展示
       <item
           android:id="@+id/settings"
           android:icon="@drawable/ic_settings"
           android:title="Settings"
           app:showAsAction="never"/>
   </menu>
   ```

2. DrawerLayout

3. NavigationView

   android:layout_gravity="start"    start end right left

   ```xml
   <android.support.design.widget.NavigationView
       android:id="@+id/nav_view"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       android:layout_gravity="start"
       app:headerLayout="@layout/nav_header"
       app:menu="@menu/nav_menu" />
   ```

4. FloatingActionButton

   ```xml
   //app:elevation="8dp" 阴影
   //app:layout_anchor="@id/appBar" 锚点
   //app:layout_anchorGravity="bottom|end" 锚点位置
   <android.support.design.widget.FloatingActionButton
       android:layout_width="wrap_content"
       android:layout_height="wrap_content"
       android:layout_margin="16dp"
       android:src="@drawable/ic_comment"
       app:elevation="8dp"                                                 
       app:layout_anchor="@id/appBar"
       app:layout_anchorGravity="bottom|end" />
   ```

5. Snackbar

   ```java
   Snackbar.make(view, "Data deleted", Snackbar.LENGTH_SHORT)
           .setAction("Undo", new View.OnClickListener() {
               @Override
               public void onClick(View v) {
                   Toast.makeText(MainActivity.this, "Data restored", Toast.LENGTH_SHORT).show();
               }
           })
           .show();
   ```

6. CoordinatorLayout

   更好的支持滑动

7. CardView和SwipeRefreshLayout和RecyclerView

   ```xml
   //appbar_scrolling_view_behavior
   <android.support.v4.widget.SwipeRefreshLayout
               android:id="@+id/swipe_refresh"
               android:layout_width="match_parent"
               android:layout_height="match_parent"
               app:layout_behavior="@string/appbar_scrolling_view_behavior">

               <android.support.v7.widget.RecyclerView
                   android:id="@+id/recycler_view"
                   android:layout_width="match_parent"
                   android:layout_height="match_parent" />
    </android.support.v4.widget.SwipeRefreshLayout>
   ```

8. AppBarLayout     extends LinearLayout

   app:layout_behavior="@string/appbar_scrolling_view_behavior"

   appbar_scrolling_view_behavior   material design 提供的布局行为

   app:layout_scrollFlags="scroll|enterAlways|snap"

   scroll:底部滑动控件向上滑动时,顶部导航栏一起向上滑动并隐藏

   enterAlways:底部滑动控件向下滑动时,顶部导航栏一起向下滑动并显示

   snap:顶部导航栏会根据当前滚动的距离,自动选择是否隐藏还是显示

9. CollapsingToolbarLayout 可折叠式标题栏

   ```xml
   <android.support.design.widget.AppBarLayout
       android:id="@+id/appBar"
       android:layout_width="match_parent"
       android:layout_height="250dp"
       android:fitsSystemWindows="true">

       <android.support.design.widget.CollapsingToolbarLayout
           android:id="@+id/collapsing_toolbar"
           android:layout_width="match_parent"
           android:layout_height="match_parent"
           android:theme="@style/ThemeOverlay.AppCompat.Dark.ActionBar"
           android:fitsSystemWindows="true"
           app:contentScrim="?attr/colorPrimary"
           app:layout_scrollFlags="scroll|exitUntilCollapsed">

           <ImageView
               android:id="@+id/fruit_image_view"
               android:layout_width="match_parent"
               android:layout_height="match_parent"
               android:scaleType="centerCrop"
               android:fitsSystemWindows="true"
               app:layout_collapseMode="parallax" />

           <android.support.v7.widget.Toolbar
               android:id="@+id/toolbar"
               android:layout_width="match_parent"
               android:layout_height="?attr/actionBarSize"
               app:layout_collapseMode="pin" />
       </android.support.design.widget.CollapsingToolbarLayout>
   </android.support.design.widget.AppBarLayout>
   ```

   app:contentScrim="?attr/colorPrimary" 折叠后背景色

   app:layout_scrollFlags="scroll|exitUntilCollapsed"    scroll:随着内容详情的滚动一起滚动 exitUntilCollapsed:滚动完成之后,留在页面内

   app:layout_collapseMode="parallax" 控件是否会根据滑动产生一定的偏差

   app:layout_collapseMode="pin" 折叠过程中,位置保持不变

10. 充分使用系统状态栏

    android:fitsSystemWindows="true"