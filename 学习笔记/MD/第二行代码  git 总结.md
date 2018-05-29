第二行代码  git 总结

1. ubuntu安装git

   sudo apt-get install git-core

2. 配置个人信息

   git config -g user.name "name"

   git config -g user.email "email@qq.com"

3. 初始化代码仓库

   git init

4. 提交本地代码

   git add "文件路径"或者 .(代表全部)

   git commit -m "提交信息"

5. 查看修改内容

   git status 查看修改的文件

   git diff 查看修改的位置内容

6. 撤销未提交(commit)的修改

   git reset HEAD

7. 查看提交记录

   git  log    Q键退出

8. 分支的用法

   1).创建分支 git branch "分支名"

   2).切换分支 git check "分支名"

   3).检查分支 git branch 

   4).合并分支 git merge "要合并的分支名"

   5).删除分支 git  branch -D "分支名" 

9. 与远程版本库协作

   1).链接下载远程仓库 git clone "git地址"

   2).推送代码到远程仓库 git push origin(指代远程仓库地址) "分支名"

   3).拉取代码两种方式 

   ​    git fetch origin 分支名   

   ​    git  merge origin/分支名 

   或者直接

      git pull origin/分支名