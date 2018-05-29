  Android多点触控

1.单点触控重点属性

| 事件类型           | 含义                       |
| -------------- | ------------------------ |
| ACTION_DOWN    | 手指 **初次接触到屏幕** 时触发。      |
| ACTION_MOVE    | 手指 **在屏幕上滑动** 时触发，会多次触发。 |
| ACTION_UP      | 手指 **离开屏幕** 时触发。         |
| ACTION_CANCEL  | 事件 **被上层拦截** 时触发。        |
| ACTION_OUTSIDE | 手指 **不在控件区域** 时触发。(久见)   |

| 方法          | 含义                     |
| ----------- | ---------------------- |
| getAction() | 获取事件类型。                |
| getX()      | 获得触摸点在当前 View 的 X 轴坐标。 |
| getY()      | 获得触摸点在当前 View 的 Y 轴坐标。 |
| getRawX()   | 获得触摸点在整个屏幕的 X 轴坐标。     |
| getRawY()   | 获得触摸点在整个屏幕的 Y 轴坐标。     |

2. ACTION_OUTSIDE 在普通的是视图外部不会触发 Dialog和悬浮窗的时候可能触发  需要设置视图的 WindowManager 布局参数的 flags为FLAG_WATCH_OUTSIDE_TOUCH  

3. Android 在 2.0 版本的时候开始支持多点触控 API 5以上

4. 多点触控事件类型

   | 事件类型                    | 含义                             |
   | ----------------------- | ------------------------------ |
   | ACTION_DOWN             | **第一个** 手指 **初次接触到屏幕** 时触发。    |
   | ACTION_MOVE             | 手指 **在屏幕上滑动** 时触发，会多次触发。       |
   | ACTION_UP               | **最后一个** 手指 **离开屏幕** 时触发。      |
   | **ACTION_POINTER_DOWN** | 有非主要的手指按下(**即按下之前已经有手指在屏幕上**)。 |
   | **ACTION_POINTER_UP**   | 有非主要的手指抬起(**即抬起之后仍然有手指在屏幕上**)。 |
   | 还有一些不在推荐过期的             | 等等                             |

   | 方法                              | 含义                                       |
   | ------------------------------- | ---------------------------------------- |
   | getActionMasked()               | 与 `getAction()` 类似，**多点触控必须使用这个方法获取事件类型**。 |
   | getActionIndex()                | 获取该事件是哪个指针(手指)产生的。 **只在 down 和 up 时有效，move 时是无效的。** |
   | getPointerCount()               | 获取在屏幕上手指的个数。                             |
   | getPointerId(int pointerIndex)  | 获取一个指针(手指)的唯一标识符ID，在手指按下和抬起之间ID始终不变。     |
   | findPointerIndex(int pointerId) | 通过PointerId获取到当前状态下PointIndex，之后通过PointIndex获取其他内容。 |
   | getX(int pointerIndex)          | 获取某一个指针(手指)的X坐标                          |
   | getY(int pointerIndex)          | 获取某一个指针(手指)的Y坐标                          |

5. **PointerId和PointerIndex的变化规律** 

   同一根手指的id是不会变化的，而index是会变化的，但总是以0、1或者0、1、2这样的形式出现

6. ```java
   //完善版  多点触碰 拖拽图片 感觉还有不晚上的地方
   //等到我自己需要用的时候再修改
   public class DragViewSingleTouch extends View {
       String TAG = "DragViewSingleTouch";
       Bitmap mBitmap;// 图片
       RectF mBitmapRectF;// 图片所在区域
       Matrix mBitmapMatrix;// 控制图片的 matrix
       boolean canDrag = false;
       PointF lastPoint = new PointF(0, 0);
       private Paint mDeafultPaint;

       public DragViewSingleTouch(Context context) {
           this(context, null);
       }

       public DragViewSingleTouch(Context context, @Nullable AttributeSet attrs) {
           super(context, attrs);
           mDeafultPaint = new Paint(Paint.ANTI_ALIAS_FLAG | Paint.DITHER_FLAG);
           BitmapFactory.Options options = new BitmapFactory.Options();
           options.outWidth = 960 / 5;
           options.outHeight = 800 / 5;
           mBitmap = BitmapFactory.decodeResource(this.getResources(), R.drawable.yujin, options);
           mBitmapRectF = new RectF(0, 0, mBitmap.getWidth(), mBitmap.getHeight());
           mBitmapMatrix = new Matrix();
       }

       private int mActivePointerId;
       /**
        * A null/invalid pointer ID.
        */
       private final int INVALID_POINTER = -1;

       // 记录活动手指的id（activePointerId），通过此ID获取move事件的坐标。
       // 在手指按下的时候，记录下activePointerId
       // 第二根手指按下的时候，更新activePointerId。（我们让第二根手指作为活动手指，忽略第一个手指的move）
       // 当其中一根手指抬起时，如果是第一根手指，那么不做处理，如果是第二根手指抬起，也就是活动手指抬起的话，
       // 将活动手指改回第一根。
       @Override
       public boolean onTouchEvent(MotionEvent event) {
           final int action = event.getActionMasked();
           final int actionIndex = event.getActionIndex();
           switch (action) {
               case MotionEvent.ACTION_DOWN: // 判断按下位置是否包含在图片区域内
                   if (mBitmapRectF.contains((int) event.getX(), (int) event.getY())) {
                       mActivePointerId = event.getPointerId(0);
                       Log.d("ACTION_DOWN", "mActivePointerId = " + mActivePointerId);
                       canDrag = true;
                       lastPoint.set(event.getX(0), event.getY(0));
                   }
                   break;
               case MotionEvent.ACTION_POINTER_DOWN: // 将新落下来那根手指作为活动手指
                   mActivePointerId = event.getPointerId(actionIndex);
                   lastPoint.set(event.getX(actionIndex), event.getY(actionIndex));
                   Log.d("ACTION_POINTER_DOWN", "mActivePointerId = " + mActivePointerId);
                   break;
               case MotionEvent.ACTION_POINTER_UP:
                   if (mActivePointerId == event.getPointerId(actionIndex)) {
                       // 如果松开的是活动手指, 让还停留在屏幕上的最后一根手指作为活动手指
                       // This was our active pointer going up. Choose a new
                       // active pointer and adjust accordingly.
                       // pointerIndex都是像0, 1, 2这样连续的
                       final int newPointerIndex = actionIndex == 0 ? 1 : 0;
                       mActivePointerId = event.getPointerId(newPointerIndex);
                       lastPoint.set(event.getX(newPointerIndex), event.getY(newPointerIndex));
                       Log.d("ACTION_POINTER_UP", "松开的是活动手指");
                   }
                   Log.d("ACTION_POINTER_UP", "mActivePointerId = " + mActivePointerId);
                   break;
               case MotionEvent.ACTION_UP: // 代表用户的最后一个手指离开了屏幕
                   mActivePointerId = INVALID_POINTER;
                   canDrag = false;
                   Log.d("ACTION_UP", "mActivePointerId = " + mActivePointerId);
               case MotionEvent.ACTION_MOVE:
                   if (mActivePointerId == INVALID_POINTER) {
                       Log.e("ACTION_MOVE", "Got ACTION_MOVE event but don't have an active pointer id.");
                       return false;
                   }
                   if (canDrag) {
                       final int pointerIndex = event.findPointerIndex(mActivePointerId);
                       mBitmapMatrix.postTranslate(event.getX(pointerIndex) - lastPoint.x, event.getY(pointerIndex) - lastPoint.y); // 更新上一次点位置
                       lastPoint.set(event.getX(pointerIndex), event.getY(pointerIndex)); // 更新图片区域
                       mBitmapRectF = new RectF(0, 0, mBitmap.getWidth(), mBitmap.getHeight());
                       mBitmapMatrix.mapRect(mBitmapRectF);
                       invalidate();
                   }
                   break;
           }
           return true;
       }


       @Override
       protected void onDraw(Canvas canvas) {
           canvas.drawBitmap(mBitmap, mBitmapMatrix, mDeafultPaint);
       }
   }
   ```