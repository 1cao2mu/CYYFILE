Android弹性动画三种实现方式

1. 插值器测试查看网站 http://inloop.github.io/interpolator/

2. 一个简单的放大动画

   ```java
           ObjectAnimator animatorX = ObjectAnimator.ofFloat(view, "scaleX", 1.0f, 1.5f);
           ObjectAnimator animatorY = ObjectAnimator.ofFloat(view, "scaleY", 1.0f, 1.5f);
           AnimatorSet animatorSet = new AnimatorSet();
           animatorSet.setDuration(1000);
           animatorSet.playTogether(animatorX, animatorY);
           animatorSet.start();
   ```

3. 第一种实现方式,通过插值器来完成

   自定义一个插值器

   ```java
   public class SpringScaleInterpolator implements Interpolator {

       private float factor;

       public SpringScaleInterpolator(float factor) {
           this.factor = factor;
       }

       @Override
       public float getInterpolation(float x) {
           return (float) (pow(2, -10 * x) * sin((x - factor / 4) * (2 * PI) / factor) + 1);
         //这个公式在http://inloop.github.io/interpolator/中测试获取
       }
   }
   ```

    使用插值器,此处使用的属性动画,使用补间动画也可以使用

   ```java
   animatorSet.setInterpolator(new SpringScaleInterpolator(0.1f));
   ```

4. 第二种方式  facebook 

   build.gradle 中添加 com.facebook.rebound:rebound:0.3.8

   ```java
           SpringSystem springSystem = SpringSystem.create();
           Spring spring = springSystem.createSpring();
           spring.setCurrentValue(1.0f);
           spring.setSpringConfig(new SpringConfig(50, 5));
           spring.addListener(new SimpleSpringListener() {
               @Override
               public void onSpringUpdate(Spring spring) {
                   super.onSpringUpdate(spring);
                   float currentValue = (float) spring.getCurrentValue();
                   view.setScaleX(currentValue);
                   view.setScaleY(currentValue);
               }
           });
           spring.setEndValue(1.8f);
           //随便看看  弹性效果可以通过修改tension和friction的值来改变
   ```

5. 第三种方式

   暂不支持 依赖 compileSdkVersion 26,minSdkVersion 16 以上,有一定的局限性

   build.gradle文件中引入  com.android.support:support-dynamic-animation:25.3.1

   ```java
           SpringAnimation animationX = new SpringAnimation(imageView, SpringAnimation.SCALE_X,1.8f);
           SpringAnimation animationY = new SpringAnimation(imageView, SpringAnimation.SCALE_Y,1.8f);
           animationX.getSpring().setStiffness(SpringForce.STIFFNESS_LOW);
           animationX.getSpring().setDampingRatio(SpringForce.DAMPING_RATIO_MEDIUM_BOUNCY);
           animationX.setStartValue(1.0f);

           animationY.getSpring().setStiffness(SpringForce.STIFFNESS_LOW);
           animationY.getSpring().setDampingRatio(SpringForce.DAMPING_RATIO_MEDIUM_BOUNCY);
           animationY.setStartValue(1.0f);

           animationX.start();
           animationY.start();
   //stiffness的值越小，弹性效果越好，弹时间越长。  
   //DampingRatio的值越大，弹性效果越差。
   ```

   ​

   ​

   ​

