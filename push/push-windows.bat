@echo off
chcp 65001
title publish
echo 请选择要提交哪一个分支？[master/develop]
set /p branch_name=请输入分支名[master/develop]：

if %branch_name%==master goto master
if %branch_name%==develop goto develop
:: 若传入的参数非 master 和 develop，则直接跳出
echo 传入的参数错误，请重新运行脚本，然后再试一次。&& pause
exit

:: 提交到 master 分支
:master
:: 切换本地分支为 master 分支，并将 develop 分支合并至 master 分支
echo 该脚本将会提交【所有本地 master 分支的内容改动】到远端 master 分支
echo 【请注意：master 分支主要用于公开浏览而非开发预览】
echo.
echo 正在从本地 develop 分支切换到本地 master 分支，并将 develop 分支合并到 master 分支中...
git checkout master
git merge develop
:: 输入 commit 的描述内容文本
echo.
set /p content=请输入本次 commit 的简短描述：
cls
:: 显示 commit 的描述内容文本、提交并推送更改至远程分支
echo 你输入的本次 commit 的简短描述是：%content%
echo.
echo 添加改动的文件...
git add -A
echo 检查文件状态...
git status
echo 生成 commit，开始提交...
git commit -m "%content%"
echo 推送本地 master 分支的所有改动到远端 master 分支...
git push origin master --force
echo 已推送。
echo ======FINISHED!======
echo GitHub 任务结束。
:: 提交网址
echo.
echo 正在提交网址到百度站长平台...
echo 使用 'hexo g' 生成 urls.txt 文件...
hexo g
echo 导航到 ‘/public’ 目录并定位 urls.txt 文件...
cd public
dir
echo 使用 curl 命令行工具提交网址到百度站长平台...
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://wzblog.fun&token=TwFhN5gM4BMIe0a9"
echo 已提交网址到百度站长平台！
echo ======FINISHED!======
:: 将本地分支由 master 分支切换为 develop 分支，结束
git checkout develop
goto okay

:: 提交到 develop 分支
:develop
:: 显示提示信息、切换分支为 develop
echo 该脚本将会提交【所有本地 develop 分支的内容改动】到远端 develop 分支
echo.
git checkout develop
:: 输入 commit 的描述内容文本
echo.
set /p content=请输入本次 commit 的简短描述：
cls
:: 显示 commit 的描述内容文本、提交并推送更改至远程分支
echo 你输入的本次 commit 的简短描述是：%content%
git status
git add -A
git status
git commit -m "%content%"
git push
echo 所有改动已提交到远端 develop 分支。
goto okay

:okay
pause
exit
