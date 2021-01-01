echo Publishing blog source-code to GitHub repo.
echo Switching branch to master and merging from develop...
git checkout master
git branch
git merge develop

read -p "PLEASE ENTER COMMIT DESCRIPTION TEXT:" content
echo -e " \n"
echo "YOUR COMMIT DESCRIPTION IS: $content"

echo Adding all files modified to prepare commits.
git add -A
echo Checking status of all files before committing.
git status
echo Commit all files.
git commit -m "$content"
echo Push all commits to GitHub repo.
git push origin master --force
echo Published all files to GitHub!
echo ======FINISHED!======
echo GitHub was Done!
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
git checkout develop
read -p "Press any key to continue." var
