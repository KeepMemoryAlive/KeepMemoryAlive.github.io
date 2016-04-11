---
layout: post
title: "POJ 2796 单调栈"
date: 2016-03-15 12:22:24 +0800
comments: true
categories: algorithm
tags: [acm, poj, 2796]
keywords: acm, poj, 单调栈
description: poj 2796
---


题目：给你一个序列，求其中一个子序列使得这个子序列和乘以这个子序列中最小值后最大（注，序列的值>=0)  
  

**分析：**  

（序列和 * 序列最小值）最大；对于一个元素，假设它是一个序列的最小值，则这个序列越长，最后的乘积就越大。  

所以对于题目，我们只要对于**每个元素，计算出“以这个元素作为序列最小值时，得到的最大乘积”**，然后比较，取出最大值即可。   

那问题的关键就在于，怎么得到 **“以该元素作为序列最小值时的最长序列”，即从该元素开始像两边延伸到最大限度**  
<!-- more -->

这个问题的特性就可以用单调栈来解决：  

**单调栈:顾名思义就是在入栈时遵循单调原则，可以求出一个元素向左所能扩展到的最大长度，并不是说在这一段区间内是单调的，而是保证在该区间内该元素一定是最大或最小。**  
  
我们有如下的性质：  

1. 如果当前元素大于前一元素，那么前一元素能扩展到当前元素，同时说明前面的数对当前元素来说是没有贡献的  
2. 如果当前元素小于等于前一个元素，那么前面至少有一个元素不能扩展到当前元素的位置，那么这些不能继续扩展的元素的存在显的没有什么意义了，不妨删除它。  
  
我们得到两条结论：  

1.一旦一个元素已经进入栈中那么这个元素向左扩展的位置就确定下来了.  

2.一旦一个元素出栈被弹出栈,那么这个元素向右扩展的位置也确定下来了.  


附本题代码：

    
    #include<iostream 
    #include<stack>
    #include<stdio.h>
    using namespace std;
    #define maxx 110000
    __int64 str[maxx],t[maxx];
    struct node
    {
    	__int64 num,pre,next;//num记录数值，pre记录向前延伸多少个，next记录向后延伸多少个,k记录本身所处的位置
   	 	__int64 k;
    };
    int main()
    {
    	int n;
    	while(scanf("%d",&n)>0)
    	{
    		stack<node>Q;
    		node tmp;
    		__int64 ans=-100,sum=-100,num;
    		str[0]=0;
    		for(__int64 i=1;i<=n;i++)
    		{
    			scanf("%I64d",&t[i]);
    			if(i==1)
    				str[i]=t[i];
    			else
    				str[i]=str[i-1]+t[i];
    		}
    		tmp.num=t[1];
    		tmp.pre=1;
    		tmp.next=1;
    		tmp.k=1;
    		Q.push(tmp);
    		__int64 x=0,y=0;
    		for(__int64 i=2;i<=n;i++)
    		{
    			node tmp1;
    			tmp1.num=t[i];
    			tmp1.pre=tmp1.next=1;
    			tmp1.k=i;
    			while(!Q.empty()&&tmp1.num<=Q.top().num)
    			{
    				tmp=Q.top();
    				Q.pop();
    				if(!Q.empty())
    					Q.top().next+=tmp.next;
    				tmp1.pre+=tmp.pre;
    				ans=tmp.num*(str[tmp.k+tmp.next-1]-str[tmp.k-tmp.pre]);
    				if(ans>=sum)
    				{
    					sum=ans;
    					x=tmp.k-tmp.pre+1;
    					y=tmp.k+tmp.next-1;
    				}
    			}
    			Q.push(tmp1);
    		}
    
			while(!Q.empty())
    		{
    			tmp=Q.top();
    			Q.pop();
    			if(!Q.empty())
    				Q.top().next+=tmp.next;
    			ans=tmp.num*(str[tmp.k+tmp.next-1]-str[tmp.k-tmp.pre]);
    			if(ans>=sum)
    			{
    				sum=ans;
    				x=tmp.k-tmp.pre+1;
    				y=tmp.k+tmp.next-1;
    			}
    		}
     
    		if(n==0)x=y=0;
    		printf("%I64d\n%I64d %I64d\n",sum,x,y);
    	}
    	return 0;
    }
    
    
      

