---
layout: post
title: "Octopress+GitHub 搭建个人博客"
date: 2016-03-15 10:56:57 +0800
comments: true
categories: Git
---

**1. Octopress是博客工具，一套用来生成blog的系统。**  

**2. GitHub是用来托管blog网页的网站**  

# 安装依赖工具  #

**Git：**
> http://msysgit.googlecode.com/files/Git-1.8.1.2-preview20130201.exe

**Ruby：**
> http://files.rubyforge.vm.bytemark.co.uk/rubyinstaller/rubyinstaller-1.9.3-p429.exe

**DevKit：**
> http://cloud.github.com/downloads/oneclick/rubyinstaller/DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe

**Python：**
>  http://www.python.org/ftp/python/2.7.5/python-2.7.5.msi




- 安装Git：
Windows下安装Git很简单，一路next就可以了。



- 安装Ruby：
Ruby的安装也是一路next就可以，不过记得勾选“Add Ruby executables to your PATH”，**将Ruby的执行路径加入到环境变量中**，如果忘记勾选，也可以手动设置。安装完后可以在命令提示符中输入ruby –version 来确认是否安装成功。



- 安装DevKit：
DevKit下载下来的是一个自压缩文件，我们将其解压到D:/DevKit，有两点需要注意：

	1. 解压目录中没有有中文和空格；
	2. 必须先安装Ruby，而且Ruby需要是RubyInstallser包安装。

	解压DevKit后，在命令行输入以下命令来进行安装：

    	d:   
    	cd DevKit  
    	ruby dk.rb init   
    	ruby dk.rb install  



- 安装Python：
安装Python,也是一路next就可以  


#  配置octopress   #



- 通过Git Shell 进入bash界面，把octopress代码拉到本地  
	`git clone git://github.com/imathis/octopress.git octopress`  



- 然后安装Octopress的依赖项，安装依赖项需要用到Ruby的gem，使用下面的命令可以更换gem的更新源，使用国内的淘宝镜像速度相对快点。
> 
>     gem sources -a https://ruby.taobao.org/  
>     gem sources -r http://rubygems.org/  
>     gem sources -l  



- 修改Octopress目录下的Gemfile文件，将第一行的http://rubygems.org/ 修改为http://ruby.taobao.org/



- 在git bash界面进入到Octopress目录，输入下面命令进行依赖项的安装

> 	gem install bundler  
> 	bundle install  
> 	rake install    

**到此 octopress就已经配置OK！**  

# 将Octopress发布到Github #  

- 首先在自己的github下新建一个` https://github.com/username/username.github.io`的repository. **注意username替换为自己的github帐号名**    




- 进入octopress目录，执行：  
	`rake setup_github_pages`  
	这个命令的功能是 octopress的自带的功能，其实就是执行octopress/Rakefile里的命令。  
	执行后，会要求你输入上一条的repository的地址。  

	这个命令背后会做这几个事情：  
	
		
		1. 把git://github.com/imathis/octopress.git这个远程库的别名从origin改为octopress  
		2. 把https://github.com/username/username.github.io这个远程库作为默认的origin远程库  
		3. 把本地octopress目录切换到source分支  
		4. 新建octopress/_deploy目录，也设置为另一个git库且是master分支，对应的远程库也是https://github.com/username/username.github.io 



- 接着执行`rake generate`，该命令会真正生成blog的页面文件。  

- 再执行`rake deploy`，它的作用是:   
	把生成的页面拷贝到deploy目录，并且把他们push到对应的远程库里去，如果发现push失败，则需要我们手动到deploy去把git对应关系建立好 `“git branch --set-upstream master origin/master”`,  
	再执行rake deploy,就成功了~  
	到这里，blog所需要的网页文件已经上传到了github对应库的**master分支**。


- 最后我们需要把octopress工程目录，也就是我们生成blog的源目录文件，提交上传  
	 
 
		git add .  
		git commit -m 'your message'
		git push origin source  

	需要注意的是，**这之前我们在github上是没有source分支的**，执行“git push origin source”时，git发现远程库没有对应的分支，就会自动创建。  


# 最后总结下 ：   
- 1、我们的工程目录是octopress，它是source分支，对应github上的也是source分支，它里面的内容是生成blog的代码源文件。  
 
- 2、octopress/_deploy目录是blog网站文件的目录，访问网站需要的文件都在这个目录里，它对应github上的master分支，所以要想更新blog，内容必须提交到master分支才会有效。