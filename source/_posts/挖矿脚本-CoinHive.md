---
title: 挖矿脚本-CoinHive
tags:
  - CoinHive
  - 挖矿
categories: 杂记
abbrlink: e799390a
date: 2019-03-22 13:56:47
updated: 2019-07-19 21:05:32
keywords: [CoinHive, 挖矿]
---

自从虚拟加密货币一出现，有关于挖矿的新闻就从来没有中断消失过，尤其是在网页上，相比于广告这样明显的方式，后台挖矿脚本可以在用户不知情的情况下，通过使用 CPU 甚至是 GPU 的计算力来获取收益，而这样做用户一般是不知情的（例如海盗湾）在网页渲染越来越复杂的趋势下，加载网页甚至浏览网页会消耗大量硬件资源已不再是什么新鲜事。虽然有时候会在网上看到一些用户浏览网站时遇到挖矿脚本的讨论贴，不过那终究是别人遇到过，换自己也遇上时，又会是什么反应呢？ <!--more--> 

![YGCQYaV0uC.png](https://storage.live.com/items/5582C1D07E2893FB!132987?authkey=APiqr1tjl5KIc1Q "coin-hive.com瞩目")

整个事情还要追溯到上周六，正在浏览网页的我突然发现许久没有弹出消息的 Windows Defender 突然弹了一个消息通知出来，报告“发现威胁”，我还以为又是电脑里哪个第三方破解器或是注册器补丁“惨遭毒手”，因为 WD 经常这样先斩后奏，于是我直接点击通知，然而界面上出现的并不是“xx破解”，而是这么个玩意儿：  

![UkNFuIjCrY.png](https://storage.live.com/items/5582C1D07E2893FB!132988?authkey=APiqr1tjl5KIc1Q "画红圈的地方")

刚一看到这个的我还有些许没回过神儿，这是什么东西？再仔细一看：<span style="background-color: #222; color: white;">**&nbsp;Trojan:JS/CoinHive.B&nbsp;**</span>，这不是 CoinHive 的挖矿脚本吗。这一下才反应过来，原来刚刚 WD 拦截的并不是什么破解或是注册机，而是一个后台挖矿的脚本！  

再放一张图：  

![Ibyr1IT6dS.png](https://storage.live.com/items/5582C1D07E2893FB!132990?authkey=APiqr1tjl5KIc1Q "Windows Defender截图")

这张图看的就比较明显了，**这个脚本位于 Google Chrome 的本地代码缓存文件夹里**，也就是说，这个脚本在被缓存后就被 Windows Defender 给灭了（顺带给 WD 赞一个👍），不过 Windows Defender 也是个“手起刀落”的主儿，等我去这个文件夹里找的时候，已经什么痕迹都没有了...  

![xWXJ5hGPGp.png](https://storage.live.com/items/5582C1D07E2893FB!132992?authkey=APiqr1tjl5KIc1Q "毫无结果...")

**大致猜测一下，uBlock Origin 检测到了这个脚本并且阻止了它在当前页面上执行，然而这个脚本仍旧被下载到本地缓存，这时被 Windows Defender 发现，后面的事情想必也都清楚了**。这真是不折不扣的“午夜惊魂”。  

对于虚拟加密货币，可能最令人印象深刻的就是去年 5 月的比特币“永恒之蓝”事件了，而这次的 CoinHive 又是挖掘什么的呢？

![xmJB4teG0e.png](https://storage.live.com/items/5582C1D07E2893FB!132994?authkey=APiqr1tjl5KIc1Q "已被拦截emm")

尝试访问了一下官网，果不其然，直接被拦截了...看来这条路行不通，不过，从其它途径也能够查到相关资料：

![m7ctSupZ8X.png](https://storage.live.com/items/5582C1D07E2893FB!132996?authkey=APiqr1tjl5KIc1Q "百科资料")

> 门罗币（Monero）是一个诞生于 2014 年 4 月的开源加密货币，其注重可替代性、隐私和去中心化。    ——来源于 Wikipedia

而 CoinHive 正是通过加载一段 JS 脚本，来借助机器算力计算哈希来挖掘门罗币的：  

> In late 2017 malware and antivirus service providers blocked a [JavaScript]>(https://en.wikipedia.org/wiki/JavaScript) implementation of Monero miner Coinhive that was embedded in websites and apps, in some cases by hackers. 

虽然 CoinHive 声称网站的拥有者可以通过开关来关闭 CoinHive 的挖矿脚本，或者是通过修改脚本内设置，以一种“更加友好”的方式来挖掘门罗币（即将 CPU 的工作率控制在一定范围以内），但是，显然不是所有引用了这段脚本的人都会这么做，而且这些脚本已经被一些黑客利用来进行恶意挖矿，大幅消耗用户电脑的运行资源。可以说，CoinHive 本意是希望挖掘加密货币、取得收益和网站拥有者、访问用户之间获得双赢，现在看来，整个情况并不像他们预先计划好的那样。而随着不少用户注意到挖矿脚本对电脑的影响，以及来自政府监管、安全公司警告以及**加密货币行业本身的发展的不确定性**，CoinHive 也在自家博客上宣布将于 3 月 8 号关停服务。  

> Some of you might have anticipated this, some of you will be surprised. The decision has been made. We will discontinue our service on March 8, 2019. It has been a blast working on this project over the past 18 months, but to be completely honest, it isn' t economically viable anymore.
>
> The drop in hash rate (over 50%) after the last Monero hard fork hit us hard. So did the "crash" of the crypto currency market with the value of XMR depreciating over 85% within a year. This and the announced hard fork and algorithm update of the Monero network on March 9 has lead us to the conclusion that we need to discontinue Coinhive.
>
> Thus, mining will not be operable anymore after March 8, 2019. Your dashboards will still be accessible until April 30, 2019 so you will be able to initiate your payouts if your balance is above the minimum payout threshold.
>
> Thank you all for the great time we had together.

虽然 CoinHive 已死，**但并不代表门罗币（Monero）和其它加密货币的挖掘会就此停止**，由于核心脚本开源，这意味着人们还可以对脚本进行修改来继续挖掘门罗币。而为了让用户注意到了解到后台挖矿对电脑的不利影响，也有人做了网站，来让用户亲身感受一下：

![TW1mYQluZb.png](https://storage.live.com/items/5582C1D07E2893FB!132998?authkey=APiqr1tjl5KIc1Q "测试网址截图")

网页地址：[单击此处](<http://tools.ldstu.com/miner/?utm_sources=/archives/41039.html>)（需要把 uBlock 或 MinerBlock 这类扩展关了再测试，不然无效）

**如果没有安装能够拦截挖矿脚本的扩展，很快你的电脑 CPU 占用率会直冲到 100%，如果是笔记本的话，风扇马上就会开始全速工作起来。**

现在看来，MinerBlock 还是很有用的，虽然我一般都是用 uBlock，如果你不想为了拦截挖矿脚本载单独安装一个新扩展，**uBlock 也可以达到相同的效果，生效的规则实际上已经在展示的第五张图片里出现了**😉  

![5cXF54I3HE.png](https://storage.live.com/items/5582C1D07E2893FB!133000?authkey=APiqr1tjl5KIc1Q "一切正常，报告完毕!")   
