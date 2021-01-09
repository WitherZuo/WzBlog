# 切换本地分支为 master 分支，并将 develop 分支合并至 master 分支
echo Publishing blog source-code to GitHub repo.
echo Switching branch to master and merging from develop...
git checkout master
git branch
git merge develop
# 输入 commit 的描述内容文本
echo -e "\n"
read -p "PLEASE ENTER COMMIT DESCRIPTION TEXT:" content
clear
# 显示 commit 的描述内容文本、提交并推送更改至远程分支
echo "YOUR COMMIT DESCRIPTION IS: $content"
echo -e "\n"
echo Adding all files modified to prepare commits.
git add -A
echo Checking status of all files before committing.
git status
echo Committing all files.
git commit -m "$content"
echo Push all commits to GitHub repo.
git push origin master --force
echo Published all files to GitHub!
echo ======FINISHED!======
echo GitHub was Done!
# 提交网址到百度站长平台
echo -e "\n"
echo Submitting all urls to Baidu.
echo Generating url file with hexo g.
hexo g
echo Navigate to /public and find urls.txt.
cd public
ls
echo Submit urls to Baidu with Curl-cli.
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://wzblog.fun&token=TwFhN5gM4BMIe0a9"
echo Submitted all urls to Baidu!
echo ======FINISHED!======
# 将本地分支由 master 分支切换为 develop 分支，结束
git checkout develop
read -p "Press any key to continue." var
