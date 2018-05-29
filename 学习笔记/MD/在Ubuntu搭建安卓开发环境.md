在Ubuntu搭建安卓开发环境

1. SDKMAN! CLI 

   ```groovy
   //SDKMAN安装
   curl -s "https://get.sdkman.io" | bash
   source "$HOME/.sdkman/bin/sdkman-init.sh"
   sdk version
   //安装gradle 
   sdk install gradle 4.1
   ```

2. 美化

   - 先装 Unity 图形管理工具

   ```
   sudo apt-get install unity-tweak-tool

   ```

   - 安装 Flatabulous 主题

   ```
   sudo add-apt-repository ppa:noobslab/themes
   sudo apt-get update
   sudo apt-get install flatabulous-theme

   ```

   - 安装配套图标

   ```
   sudo add-apt-repository ppa:noobslab/icons
   sudo apt-get update
   sudo apt-get install ultra-flat-icons
   ```

   - 安装字体(文泉)

   ```
   sudo apt-get install fonts-wqy-microhei
   ```

3. 安装wps

   ```
   //卸载libreoffice
   sudo apt-get remove libreoffice-common
   //安装wps
   //http://linux.wps.cn/
   sudo dpkg -i wps-office_10.1.0.5672~a21_amd64.deb
   sudo apt-get install -f
   ```