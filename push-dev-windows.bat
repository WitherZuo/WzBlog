@echo off
title push-dev

echo This script will push all commits to remote develop branch,
echo if you want to publish your blog for everyone, please use 
echo 'npm run publish' command.
echo.
git branch 
git checkout develop
git branch
echo.
set /p content=PLEASE ENTER COMMIT DESCRIPTION TEXT:
cls
echo YOUR COMMIT DESCRIPTION IS: %content%
git status
git add -A
git status
git commit -m "%content%"
git push
echo All commits were pushed to remote develop branch.
pause
exit