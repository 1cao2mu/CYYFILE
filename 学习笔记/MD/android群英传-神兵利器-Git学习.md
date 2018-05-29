android群英传-神兵利器-Git学习

1. 创始人 Linux Torvalds  林纳斯.托瓦兹

2. 分布式版本控制和集中式版本控制

3. git --version 查看版本

4. git config --list 查看配置信息

5. git config --list --global 加global查看全局 

6. git config user.name ccccc 配置信息中的姓名

7. git config --unset user.name 如果有多个对应的值  可以使用 --unset-all

8. git config --global alias.la pull

   git config --global alias.st status

   命令配置别名    q退出

   ```cmake
   git config --global alias.lg "log --color --graph --format=format:'%C(bold blue)%h%C(reset): %C(bold green)(%ad)%C(reset) %C(bold yellow)<%an>%C(reset)%C(bold red)%d%C(reset)%n'' %C(reset)%s%C(reset)' --date=local --abbrev-commit"
   ```

9. git init 创建初始化

10. git  clone 克隆复制  

11. git add .   git commit -m "XXX"

12. git commit --amend -m "XXX" 追加修改

13. git status (查看修改的文件) git diff  对比修改过的文件和仓库的文件 可加文件路径

14. git blame 文件路径  查看历史某文件的历史修改记录

15. git checkout 文件路径 回复原状,撤销修改,但是需要在git add 之前

16. git reset  从暂存区移除,在add或者 commit之后  +HEAD^ 或者 HEAD^^ 或者 HEAD ~100  

    推送到服务器的  不会改变服务器  只会改变本地仓库

17. git  log  查看历史修改记录

18. git rm +文件路径  删除文件 并直接add 添加到暂存区

19. git push  "远程仓库"  "分支"  推送到远程仓库 (本地仓库和远程仓库  分支git)

20. git branch "XXX" 创建分支   git branch  查看分支

21. git checkout -b "XXX" 创建并切换到此分支

22. git branch -d "XXX" 删除分支

23. git remote  查看远程仓库

24. git tag  类似分支 类似快照  -d 删除

    git show tagname 查看分支详情

    git tag -a v1 -m "v1" commit id

25. git push origin(远程仓库名) v1(tagname)  或者 --tags  推送全部

26. git push origin :refs/tags/v1  需要先删除本地仓库

      

