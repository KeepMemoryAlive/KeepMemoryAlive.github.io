---
layout: post
title: "git基础知识"
date: 2016-03-15 10:32:49 +0800
comments: true
categories: Git
---

# Git原理 #

1. Git是一个开源的分布式版本控制系统，用以有效、高速的处理从很小到非常大的项目版本管理。重点在于**分布式**，每个人的电脑上都是一个完整的版本库，所以**使用Git Commit的时候，不是提交到服务器，而是提交到本地的版本库**。
 
2. 工作区有一个隐藏目录.git，这就是Git在本机的版本库。 Git的版本库里存了很多东西，其中最重要的就是称为stage（或者叫index）的暂存区，还有Git为我们自动创建的第一个分支master，以及指向master的一个指针叫HEAD。
   

3. 我们把文件往Git版本库里添加的时候，是分两步执行的：

	第一步是用**git add把文件添加进去，实际上就是把文件修改添加到暂存区**；

	第二步是用**git commit提交更改，实际上就是把暂存区的所有内容提交到当前分支。（注意这只是提交到本地库的分支）** 

1. 远程仓库，指保存在服务器上的仓库，这里主要指github上托管的仓库。
**这里有需要注意的地方：**

       A、github上建立仓库后，它也有分支的概念，本地仓库也有分支的概念，比如“https://github.com/KeepMemoryAlive/KeepMemoryAlive.github.io”这个仓库，其实它在github上可能有几个分支。

       B、本地仓库和远程库之间 必须要有tracking information，才能push 和 pull, 当我们用git clone时， 默认是建立的**本地master分支** 与 **远程master分支**之间的联系。


# Git常用命令 #

- git clone:如果不指定本地目录名，就同名，注意默认切出来的是master分支  
  `git clone: <版本库的网址> <本地目录名>`

- git remote: Git要求每个远程主机都必须指定一个主机名。git remote命令就用于管理主机名.  
    `git remote -v`  
 
     octopress       git://github.com/imathis/octopress.git (fetch)  
     octopress       git://github.com/imathis/octopress.git (push)  
	origin  https://github.com/KeepMemoryAlive/KeepMemoryAlive.github.io (fetch) 
	origin  https://github.com/KeepMemoryAlive/KeepMemoryAlive.github.io (push)  

	克隆版本库的时候，所使用的远程主机自动被Git命名为origin。如果想用其他的主机名，需要用git clone命令的-o选项指定。  
    `git clone -o jQuery https://github.com/jquery/jquery.git`  

	`git remote show <主机名>`: 查看该主机的详细信息  
	`git remote add <主机名> <网址>` : 命令用于添加远程主机。  
	` git remote rename <原主机名> <新主机名>`  
	  
   	**注意：**  remote只代表对应的远程主机，并没有列出本地分支和远程分支之间的tracking information

- git pull: 取回远程主机**某个分支**的更新，再与**本地的指定分支合并**。它的完整格式稍稍有点复杂。   
	`git pull <远程主机名> <远程分支名>:<本地分支名>`  
  
	在某些场合，Git会自动在本地分支与远程分支之间，建立一种**追踪关系**(tracking)。比如，**在git clone的时候，所有本地分支默认与远程主机的同名分支，建立追踪关系**，也就是说，本地的master分支自动”追踪”origin/master分支。  

	Git也允许手动建立追踪关系：  
	`git branch --set-upstream master origin/next`   
 
	上面命令指定**本地master**分支追踪origin/next分支，如果当前分支与远程分支存在追踪关系，git pull就可以省略远程分支名。  
    `git pull origin`  

	如果当前分支只有一个追踪分支，连远程主机名都可以省略。  
	`git pull`  
	**注意：用git pull时 一定要注意，本地分支与远程分支的对应关系，避免提错了**  


- git push:用于将本地分支的更新，推送到远程主机， 就是把本地库和远程库同步，相当于svn的提交。  
  ` git push <远程主机名> <本地分支名>:<远程分支名>` 
 
	**如果省略远程分支名，则表示将本地分支推送与之存在”追踪关系”的远程分支(通常两者同名)，如果该远程分支不存在，则会被新建。**  
	`git push origin master`  
上面命令表示，将**本地的master**分支推送到origin主机的master分支。如果后者不存在，则会被新建。  

	如果当前分支只有一个追踪分支，那么主机名都可以省略。  
	`git push`	**用这个命令一定要注意 当前的对应关系**  


- git status:查看当前工作区的修改  

- git log: 如果不带任何参数，它会列出所有历史记录，最近的排在最上方  
	`git log -n` : 选择显示前N条。  
    `git log --pretty=oneline` : 一行显示，只显示哈希值和提交说明。

- git reflog: 列出了head曾经指向过的一系列commit.  

- git reset：回退版本  
    `git reset --hard 66a4b03` 回退到66a4b03指定的版本，这个指通过 git reflog可以查看  

