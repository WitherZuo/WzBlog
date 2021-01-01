---
title: PowerShell 脚本更新 Bing 壁纸
date: 2020-12-11 21:51:36
updated: {{ date }}
tags: 
  - PowerShell
  - Bing
  - 壁纸
categories:
  - PowerShell
titlename: update-BingWallpaper-using-PowerShell
---
微软家的 Bing（必应）搜索引擎虽然综合搜索体验并不算太好，但相比百度和 Google 仍然是有一定的可取之处的，最显而易见的一点就是必应每天都会更换的背景图片，这也让必应成为了最不务正业的搜索引擎；又因为这些图片（或照片）质量极高，很多人也考虑将这些图片作为壁纸使用，微软也推出了一款官方的 Bing Wallpaper 应用，可是这应用有一点问题，那就是因为中美时差缘故，我只有在当天下午四五点的时候才会获取到当天的壁纸（内地下午四五点大约对应美国时间的凌晨零点和一点），再加上白占了一个托盘图标，总不是最好的选择。那么有其它方式吗？当然有，而且**可以用 Windows 10 系统自带的 PowerShell 做到**[^1]。<!-- more -->  

## Step1：配置 PowerShell 和包管理器（PowerShellGet）  

目前大部分电脑都预装了 Windows 10，而且不少人日常使用的操作系统也是 Windows 10，加上 Windows 10 默认预装搭载的 PowerShell 为 5.1，**这里以 Windows PowerShell 5.0 为例**[^2]，先来配置 PowerShellGet（一个 PowerShell 的包管理器）：  

若要在 Windows 10、Windows Server 2016、任何安装了 WMF 5.0 或 5.1 的系统或任何安装了 PowerShell 6 的系统上安装 PowerShellGet，请通过**提升的 PowerShell 会话（即“以管理员身份运行”）**运行以下命令。  

```powershell
Install-Module -Name PowerShellGet -Force
```

输入以上命令后敲下回车键，等待 PowerShell 完成安装过程。如果 PowerShell 报告已安装 PowerShellGet，那可以跳过这一步。如果想要更新 PowerShellGet，那么执行下面的命令即可（使用 `Update-Module` 获取更高版本）：  

```powershell
Update-Module -Name PowerShellGet
Exit
```

完成后，接下来获取对应的模块。  

## Step2：从仓库获取需要的模块包  

成功安装 PowerShellGet 后，**以管理员身份重新启动 PowerShell**，接下来获取需要的模块包。运行以下命令安装`BingWallpaper`[^4]模块：  

```powershell
Find-Module -Name 'BingWallpaper' | Install-Module
```

顺带说一句，这个模块是开放了源代码的[^3]。如果在安装过程中出现“不受信任的仓库”的警告，输入“Y”或“A”然后敲下回车键继续即可。安装完成后，如果要测试安装是否成功，输入以下命令查看输出的信息：  

```powershell
Get-Help Set-BingWallpaper
```

如果输出了 `BingWallpaper`模块的帮助信息，那么表明安装成功，准备工作已经基本完成，可以在 PowerShell 的控制台窗口中输入`Set-BingWallpaper`命令，稍等片刻，你的电脑的桌面壁纸就会自动刷新为当天的必应背景图片了。  

除此之外，这个命令还有其它参数，可以进行其它的操作，如：

- `Set-BingWallpaper -Text '每天都要开心呀~'`：设置壁纸，并在壁纸右下角设置文字水印，文字为“每天都要开心呀~”。  
- `Set-BingWallpaper -Offset 1`：更换为昨天的壁纸。数值 1 表示昨天，2 表示前天，依次类推，**最大为 7**。  
- `Set-BingWallpaper -Text '每天都要开心呀~' -Offset 3 -FontName '微软雅黑' -FontSize 30 -FontStyle Bold`：设置壁纸，修改字体、字号大小、是否加粗等。

那么也可以这样写：  

```powershell
Set-BingWallpaper -Text ('Updated on '+(get-date -Format 'yyyy-MM-dd HH:mm:ss')) -Force
```

**上面的命令作用：**执行该命令将**强制设置**壁纸为当天的必应壁纸，且会在壁纸右下角**附加水印**，水印显示的内容是**该壁纸最后更新的获取时间**。  

![rZsS8e.md.png](https://s3.ax1x.com/2020/12/12/rZsS8e.md.png)  

## Step2-1：使用 AutoHotKey 达到无感运行  

将上面的命令写入到 PowerShell 脚本文件（`.ps1`）后保存并运行，你会发现虽然能够成功更换壁纸，但**更换的过程中也会显示一个控制台窗口**，这样比较突兀，即便给上述命令中添加`-WindowStyle`参数也无法避免控制台窗口的显示，如果可以**在执行过程中隐藏控制台窗口**就好了，这可以用 [AutoHotKey](https://www.autohotkey.com/) 来完成。  

虽然 AutoHotKey 功能强大且命令繁多，这里只需要一个`Run`命令就够了：  

```AutoHotKey
Run, "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe" -WindowStyle Hidden -command "Set-BingWallpaper -Text ('Updated on '+(get-date -Format 'yyyy-MM-dd HH:mm:ss')) -Force" , , Hide
```

新建一个 AutoHotKey 脚本文件（后缀名为`.ahk`），然后将上面的文本复制到新建的脚本文件中保存，运行这个脚本，就可以达到不显示（即隐藏）控制台的“无感”更换壁纸的效果了

## Step3：自动更换，脱离手动  

虽然经过上面的操作，可以手动更换新的必应壁纸了，但是这一切还需要人工操作，我们需要自动操作，当每次开机时自动更新一次当日的必应壁纸，每天零点后也要自动更新一次当日的必应壁纸，这样的操作也可以**完全借助系统自带的工具来实现**，那就是“**任务计划程序**”。我们可以设定一个计划任务，再给这个任务设定**多个触发器**，就可以达到上面的目的了。  

接下来用几张图片来说明过程：

![rZDhSH.png](https://s3.ax1x.com/2020/12/12/rZDhSH.png)  

![rZDWfe.png](https://s3.ax1x.com/2020/12/12/rZDWfe.png)  

![rZD6w6.png](https://s3.ax1x.com/2020/12/12/rZD6w6.png)  

![rZDcTK.png](https://s3.ax1x.com/2020/12/12/rZDcTK.png)  

![rZDyex.png](https://s3.ax1x.com/2020/12/12/rZDyex.png)  

![rZD2FO.png](https://s3.ax1x.com/2020/12/12/rZD2FO.png)  

![rZDRYD.png](https://s3.ax1x.com/2020/12/12/rZDRYD.png)  

![rZD4ld.png](https://s3.ax1x.com/2020/12/12/rZD4ld.png)  

完成以上操作后，**在电脑每次开机后、每当时间经过零点后，都会触发自动更换壁纸的计划任务，无需人工干预**，over。  

[^1]: 通过快捷方式快速更换桌面壁纸（必应每日壁纸） https://blog.csdn.net/hokis/article/details/106675803  

[^2]: 安装 PowerShellGet - PowerShell | Microsoft Docs https://docs.microsoft.com/zh-cn/powershell/scripting/gallery/installing-psget?view=powershell-5.1   

[^3]: Jaykul/Bing: My PowerShell Bing modules for searching, translating and ... Bing wallpapers. https://github.com/Jaykul/Bing   

[^4]: PowerShell Gallery | BingWallpaper 1.2.0 https://www.powershellgallery.com/packages/BingWallpaper/1.2.0   

