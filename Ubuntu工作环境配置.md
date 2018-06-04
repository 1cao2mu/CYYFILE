配置键盘 
	切换输入法按键设置都改成shift

1. git     

    安装，拉取cyyfile项目，获取各种资料
    sudo apt install git
    cd 桌面&&mkdir cyy
    git init 
    git remote add origin  https://github.com/1cao2mu/CYYFILE.git
    git pull
    git pull origin master

2. 火狐浏览器

    设置中文：
    sudo apt install firefox
    sudo apt-get install firefox-locale-zh-hans
    导入书签

3. chrome浏览器

    安装
    sudo wget http://www.linuxidc.com/files/repo/google-chrome.list -P /etc/apt/sources.list.d/
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install google-chrome-stable
    /usr/bin/google-chrome-stable
    锁定桌面图标
    导入书签

4. vsode

    下载地址 https://code.visualstudio.com/docs/?dv=linux64_deb
    安装插件 
    3024Night Theme ,Auto Close Tag , AutoFileName , Chinese... , Eslint , 
    GitLens... , IntelliJ IDEA... , React Native Tools ,vscode-fileheader,vscode-icons
    复制setting vscode.json

5. jdk

    gedit ~/.bashrc
    source ~/.bashrc
    tar -zxvf jdk.tar.gz  //解压到home目录
    下载地址:http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

6. as&&sdk

    打开的时候 不要使用sudo打开
    sudo chmod 777 **** 给每个人添加权限   
    sudo rm -rf 删除文件夹 
    sh studio.sh
    添加桌面图标 文件：Studio.desktop
    as:/home/cyy/as
    sdk:/home/cyy/sdk
    Project:/home/cyy/Project
    下载地址：http://www.android-studio.org/

7. ndk

    sudo apt-get install libc6-dev-i386
    如果报错 没有此文件或目录安装这个文件
    chmod 777 ndk.bin
    ./ndk.bin

8. node

    sudo apt install curl
    sudo apt-get install -y build-essential
    curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash - #(这一步需要有耐心)
    sudo apt-get install -y nodejs
    sudo ln -s /usr/bin/nodejs /usr/bin/node

9. React Native的命令行工具

    npm install -g yarn react-native-cli
    yarn config set registry https://registry.npm.taobao.org --global
    yarn config set disturl https://npm.taobao.org/dist --global
    npm install -g flow-bin
    touch ~/.gradle/gradle.properties && echo "org.gradle.daemon=true" >> ~/.gradle/gradle.properties

10. genymotion&&virtualbox

    sudo apt install libsdl1.2debian
    sudo dpkg -i virtualbox-5.2_5.2.12-122591_Ubuntu_xenial_amd64.deb
    sudo chmod 777 genymotion.bin
    genymotion 设置adb
    genymontion
    下载地址：https://www.genymotion.com/download/
    下载地址：https://www.virtualbox.org/

11. ubuntu和window的时间同步

      sudo apt-get install ntpdate
      sudo ntpdate time.windows.com
      sudo hwclock --localtime --systohc

12. Gpick和KolourPaint

      在ubuntu软件中心安装

13. wps替代libreOffice

      wps下载地址：http://wps-community.org/download.html
      字体下载地址：https://pan.baidu.com/s/1eS6xIzo
      sudo mv /home/cyy/下载/wps_symbol_fonts /usr/share/fonts
      sudo mkfontscale
      sudo mkfontdir
      sudo fc-cache
      sudo apt-get remove libreoffice-common

14. git保存密码

      gedit .git-credentials
      https://{username}：{password}@github.com
      git config --global credential.helper store

15. qq安装

      安装32位库的支持
      sudo dpkg --add-architecture i386  
      sudo apt-get update  
      sudo apt-get install lib32z1 lib32ncurses5
      安装CrossOver
      sudo dpkg -i crossover-15_15.0.3-1_all.deb
      sudo dpkg -i crossover-15_15.0.3-1_all-free.deb
      sudo dpkg -i deepin-crossover-helper_1.0deepin0_all.deb
      如果中途出现依赖问题
      sudo apt-get install -f
      sudo dpkg -i apps.com.qq.im_8.1.17255deepin11_i386.deb
      mv /opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so.bak
      cp winewrapper.exe.so /opt/cxoffice/lib/wine/
      设置字体
      cp simsun.ttf /opt/cxoffice/share/wine/fonts
      mv /opt/cxoffice/share/wine/fonts/ume-ui-gothic.ttf /opt/cxoffice/share/wine/fonts/ume-ui-gothic.ttf.bak
      sudo gedit /usr/bin/killqq
      内容如下
      ps aux|grep -v grep|grep wine|cut -c 9-15|xargs kill   
      ps aux|grep -v grep|grep QQ|cut -c 9-15|xargs kill   
      ps aux|grep -v grep|grep qq|cut -c 9-15|xargs kill   
      pkill  plugplay.exe  
      pkill  explorer.exe  
      pkill  services.exe 
      赋予执行权限
      sudo chmod 777 /usr/bin/killqq

16. Typora
      sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
      sudo add-apt-repository 'deb https://typora.io/linux ./'
      sudo apt-get update
      sudo apt-get install typora


​	




​	



​	





​	 	

​	




