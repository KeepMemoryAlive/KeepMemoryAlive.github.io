---
layout: post
title: "octopress怎么添加文章"
date: 2016-03-15 10:56:57 +0800
comments: true
categories: Git
tags: [Git, Octopress]
keywords: octopress, git, 
---

# 添加文章 #
1. `rake new_post['my first octopress blog']` 这样可以生成一片文章的源文件。  
注意，rake new_post['my first octopress blog']中的my first octopress blog 并不是博客标题，而是和生成的文件名以及url地址有关，该名称不支持中文。博客标题可以在生成的markdown文件中修改。生成的markdown文件在octopress/source/_posts目录中。

	可以用*markdownpad*直接编译这个文件，来写blog内容。  

<!-- more -->

2.	每次写完blog后，需要执行rake generate，这时生成真正的网页文件。

3.	然后再执行命令rake deploy 就可以将本地的内容发布到Github上。

4.	最后保存文章的code文件，提交到source目录下  

	git add .  
	git commit -m “your message”  
	git push origin source  



