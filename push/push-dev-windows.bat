@echo off
title push-dev
:: 显示提示信息、切换分支为 develop
echo This script will push all commits to remote develop branch,
echo --if you want to publish your blog to everyone, please use 
echo 'npm run push' command.--
echo.
git checkout develop
:: 输入 commit 的描述内容文本
echo.
set /p content=PLEASE ENTER COMMIT DESCRIPTION TEXT: 
cls
:: 显示 commit 的描述内容文本、提交并推送更改至远程分支
echo YOUR COMMIT DESCRIPTION IS: %content%
git status
git add -A
git status
git commit -m "%content%"
git push
echo All commits were pushed to remote develop branch.
pause
exit