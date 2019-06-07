---
title: 'Img Share: OneDrive 图床?'
tags:
  - OneDrive
  - 图床
  - UWP
categories: 使用体验
abbrlink: b036879a
date: 2018-12-14 13:19:52
keyword:
---

在写文章的时候不免要插入一些图片进去，如果用本地插入的方式，在本地上浏览倒还好，要是在线上浏览的话，一个又一个的红叉极其影响观赏体验。因此图床就应运而生了。虽然 GitHub 上建立的 Hexo 博客，可以通过将图片放入博客源目录`/sources/images/`的方式来引入图片，再通过外链来展示，**但限于 GitHub 在内地的速度，这样做并不一定好用，经常会出现网页基本加载完成但图片迟迟不出现的情况，在网络情况较差时更甚**。<!--more-->  

选用第三方图床，但因为要准备上传到图床的图片一般都在本地，上传上去之后往往就忘记了在本地的文件位置，如果再找起来无异于大海捞针，有没有一种更好的办法呢？  

办法当然有，就是**用 OneDrive 来作为图床**，而 Img Share 就是为此而生的。  

作者对这款软件的介绍也很直接，**最不错的一点是：这软件是 UWP 应用，意味着 UWP 平台上也出现了一款好用的图床工具。**  

![imgshare-winstore.png](https://storage.live.com/items/5582C1D07E2893FB!83088?authkey=APiqr1tjl5KIc1Q "Img Share的宣传图，很心动有木有？")  

> 这软件功能很简单
> 
> OneDrive 图床
> 简单，直接，好看还TM好用。我做的东西，设计上不用担心
> 目前这款工具仅针对 OneDrive 设计，因为你可以确保 OneDrive 的稳定性和私密性，而其它云服务本钦件不予考虑

三言两语便将这款应用的特点概括出来：**简单直接、界面漂亮、设计流畅、仅支持 OneDrive**。  

为什么要用OneDrive来当图床而不是其它的服务呢，**简单来说，用 Img Share 生成的图片外链，都会自动在 OneDrive 下新建一个文件夹存放起来，也就是说，之后在找这些图片的时候，就不用在本机硬盘上东翻西翻了，OneDrive 将会自动同步这些内容在任何设备上可用**，方便了不少。  

### 与 OneDrive 授权：

要想通过Img&nbsp;Share来创建 OneDrive 图床，**首先需要提供给 Img Share 我们的 OneDrive 的 authkey**，OneDrive 通过这个 authkey 来验证我们的请求。作者也十分贴心，在第一次进入应用时就会告诉我们如何添加这个 authkey。  

**作者的说明：[单击此处](https://blog.richasy.cn/document/basic/onedrive_authkey.html)**  

{% note warning %}  

**注意：这一步骤需要通过网页端 OneDrive 来完成，如果您在中国内地，可能需要科学上网**

{% endnote %}  

**概括来说，就是给予 Img Share 图片文件夹的访问权限，这样就可以使用图床外链了。**  

放两张图示意一下，**authkey 字段后面的字符串就是我们需要的 authkey（不需要复制两边的双引号)**

![howtoauth-1.png](https://storage.live.com/items/5582C1D07E2893FB!83090?authkey=APiqr1tjl5KIc1Q "注意红框标注的位置")

![howtoauth-2.png](https://storage.live.com/items/5582C1D07E2893FB!83084?authkey=APiqr1tjl5KIc1Q "画红线的地方，authkey=之后的一串字符就是我们需要的authkey")  

然后将这一串字符串复制到 Img Share 弹出的窗口中，单击“确定”，等待 Img Share 验证完成即可。  

### 创建图片外链：

一切准备就绪之后，接下来就可以添加图片了，**将图片拖拽到红框所示区域内：**  

![addpic.png](https://storage.live.com/items/5582C1D07E2893FB!83086?authkey=APiqr1tjl5KIc1Q)  

这里会让你选择一个分组，**如果没有存在任意一个分组，那么 Img Share 会要求你首先新建一个**，然后继续。这里也是我觉得做的非常好的一个地方，在**之后查找图片的时候，只需要找到对应的分组即可，不需要乱翻了**。  

![addgroup.png](https://storage.live.com/items/5582C1D07E2893FB!83085?authkey=APiqr1tjl5KIc1Q "在输入框内输入分组名称")  

一切完成之后，等待 Img Share 将图片上传，然后就会自动生成 OneDrive 的外链：  

![picinfo.png](https://storage.live.com/items/5582C1D07E2893FB!83087?authkey=APiqr1tjl5KIc1Q "支持普通链接、Markdown链接和HTML嵌入")  

可以看到，**Img Share 不仅会生成普通的图片外链链接，还提供了生成 Markdown 图片链接格式和 HTML 内嵌入格式的选项**，可谓十分贴心，考虑到不同的情况。  

本段最后附一张效果图：  

<video src="https://t1.aixinxi.net/o_1cvhe8et71thc8ap1qae256861a.mp4" controls="controls" class="video-container" width="640px">如果看到此消息，这说明您的浏览器需要更新一下下以便支持HTML5了🙃</video>  

### 一点总结：

先放上下载链接（Microsoft Store）：[单击此处](https://www.microsoft.com/zh-cn/p/img-share/9ncxnz52g9q8?activetab=pivot:overviewtab)

UWP 的生态目前的境况很多人都是有目共睹，而这种情况下 Img Share 的出现无异于给 UWP 一缕曙光，**界面清爽（遵循了 Fluent Design，但又在里面加入了作者自己的设计，两者完美融合）、操作方便（只需将图片拖拽入图片框内即可）、功能完善（多余的功能一个没有，麻雀虽小五脏俱全，自带的分组简直好用有木有），充分利用了 OneDrive 的特性，可以在本地管理这些图片，所有已上传的外链图片可以在任何设备上管理**。唯一略麻烦的一点是需要先配置  authkey，网页端的 OneDrive 需要翻出去（科学上网），但与这些实用的功能相比，这些小瑕疵可以手动忽略掉了。😁    

另外这个作者还有一款应用：Acrylic&nbsp;Markdown，是一款 UWP 的 markdown 编辑器，与 Img Share 一样，美观与实用并存，践行了作者一贯的风格，如果对 Img Share 的印象不错，也可以试试这款 Acrylic Markdown，这里必须给作者打 call。[单击此处](https://www.microsoft.com/zh-cn/p/acrylic-markdown/9mx0mgjmjnbj?cid=msft_web_chart&activetab=pivot%3Areviewstab)   

**更新：由于作者无法提交软件更新，原 Img Share 更名为 Picture Share 重新发布。微软商店中即可搜索到，同时作者已将此项目[开源](https://github.com/Richasy/Img-Share?files=1)**  

**12 月 22 日更新：部分图片添加为外链后可能不是 HTTPS 链接，浏览器控制台会报 https 错误，解决方法为自行在图片外链接中将 http 改为 https 即可。 **  

<head><script defer src="https://use.fontawesome.com/releases/v5.5.0/js/all.js"></script><script defer src="https://use.fontawesome.com/releases/v5.5.0/js/v4-shims.js"></script> </head> <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">

