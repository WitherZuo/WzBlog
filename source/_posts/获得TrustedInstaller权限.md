---
title: 获得 TrustedInstaller 权限
titlename: 358c8d05
date: 2019-07-17 09:36:36
updated: 2019-07-19 21:13:09
tags: [Windows, TrustedInstaller]
categories: Windows
keywords: [Windows, TrustedInstaller, 权限，帮助，WindowsApps]
---

在 Windows 中，有时候需要访问一些系统重要文件夹，这时大概率会碰到比如“无权访问”的问题，尤其是在原版的 Windows 7 或更高版本的系统上。在 Windows 10 中，一些系统文件夹比如`Program Files`也被上了锁，还有存储着商店应用数据的`WindowsApps`文件夹，这个文件夹就必须要获得 TrustedInstaller 这样的权限组用户的权限才能访问，普通用户一般是访问不了的。如果必须要进去访问该怎么办？可以通过系统的“安全”选项卡来设置。<!--more-->  

先按常规的普通用户权限来试图进入`WindowsApps`，看看是什么情况：

![无法访问](https://s3.ax1x.com/2020/12/14/rnE5YF.png "无法访问")  

如果单击“继续”呢，又会是什么情况？ 

![仍然无法访问...](https://s3.ax1x.com/2020/12/14/rnE4FU.png "仍然无法访问...")   

仍然是拒绝，提示**我们需要使用“安全”选项卡来修改**。  

## 获取权限  

要想更改所在的用户组，改变文件夹的所有者，我们需要先找到“安全”选项卡的位置。  

首先在你想要更改用户组的文件夹上右键，弹出的菜单中单击“属性”，然后在弹出的“属性”窗口中单击“安全”选项卡。如下图所示：  

![“属性”窗口-“安全”选项卡](https://s3.ax1x.com/2020/12/14/rnEfoT.png "“属性”窗口-“安全”选项卡")  

在选项卡界面中找到“高级”按钮并单击，接下来会进入“高级安全设置”窗口。  

有时候会发现在这个窗口中，“所有者”一栏显示为“无法显示当前所有者”，“权限”选项卡中提示我们“必须具有读取权限才能查看此对象属性，单击`继续`以尝试用管理权限执行此操作”的字样，下方会出现一个带盾牌图标的“继续”按钮，这表明目前的**用户组权限不够，需要提升到管理员权限。单击“继续”**，**取得管理员权限后**，如下图所示：  

![取得管理员权限后](https://s3.ax1x.com/2020/12/14/rnEWwV.png "取得管理员权限后")  

在“所有者”一栏中，所有者显示为 TrustedInstaller，在“权限”选项卡中，“权限条目”没有属于当前普通用户的主体，为了能够访问该文件夹，我们需要添加新的用户主体并将所有者设置为我们自己。**在“所有者”一栏上，单击“更改”**。  

![选择用户或组](https://s3.ax1x.com/2020/12/14/rnE6Qs.png "选择用户或组")  

在新弹出的“选择用户或组”的对话框中，分为三部分：对象类型、查找位置和对象名称，其中对象类型默认为“用户、组或内置安全主体”不要修改；查找位置为你当前设备的名称，因此也不用修改；重点在最后一项上，单击下方的“高级”按钮，在弹出的窗口中单击“立即查找”，**在下面的列表中选择你所在的用户，单击选中它**，然后单击“确定”回到上一级窗口。  

这时会在下方的“对象名称”中出现你所在用户组的名称，确认无误后，单击“确定”。保存所有的改动。  

![示例图 1](https://s3.ax1x.com/2020/12/14/rnEcyn.png "示例图 1")  

![示例图 2](https://s3.ax1x.com/2020/12/14/rnEgLq.png "示例图 2")  

上面的所有者已经改变，确认无误后，再次单击下方的“确定”，修改完成。这次再试试访问`WindowsApps`这个文件夹。  

![修改后的截图](https://s3.ax1x.com/2020/12/14/rnERe0.png "修改后的截图")  

![演示图，现在可以访问了](https://s3.ax1x.com/2020/12/14/rnEIW4.gif "演示图，现在可以访问了")  

**如果弹出其它的对话框，选择“确定”即可。**  

## 改回权限  

**TrustedInstaller 的用户组权限极高，不建议在平时正常使用时一直使用，在完成需要提权的操作后最好还是将受保护的文件夹改回到原来的用户组。**（当然你一直保持着也没问题）  

在“高级安全设置”窗口中，单击“所有者”右侧的“更改”按钮，在弹出的对话框中将光标定位到“对象名称”的输入框中，输入`NT SERVICE\TrustedInstaller`然后单击右侧的“检查名称”，这时会自动识别为 TrustedInstaller。  

{% note warning %}  

注意：不可以直接输入 TrustedInstaller，系统会提示找不到对应的名称，**必须输入`NT SERVICE\TrustedInstaller`才能识别！**  

{% endnote %}  

正确识别后，单击“确定”保存修改。返回上一级窗口后，再单击“确定”，**如果出现“可能会造成文件夹和文件继承权限”之类的提示信息，全部单击“取消”，然后关闭窗口**。  

## TrustedInstaller 是什么  

TrustedInstaller 是从 Windows Vista 开始出现的一个内置安全主体，为 [Windows](https://baike.baidu.com/item/Windows/165458) 系统中众多系统内置安全主体中的一个，本身是系统重要服务，用户无法直接在此服务的上下文中运行程序或另一个 [服务](https://baike.baidu.com/item/服务/10393131)。它是操作系统上用来对系统进行维护、更新等操作的组。它的 SID 是 S-1-5-80-956008885-3418522649-1831038044-1853292631-2271478464。TrustedInstaller 权限的意义是用来防止程序或用户无意或恶意破坏系统文件。 这个安全主体本身是一个服务，名称为：Windows Modules Installer。  
