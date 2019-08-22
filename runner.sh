echo Publishing blog to GitLab Pages.
read -p "PLEASE ENTER COMMIT DESCRIPTION TEXT:" content
echo -e " \n"
echo "YOUR COMMIT DESCRIPTION IS: $content"
echo Adding all files modified to prepare commits.
git add -A
echo Checking status of all files before committing.
git status
echo Commit all files.
git commit -m "$content"
echo Push all commits to GitLab repo.
git push origin master
echo Published all files to GitLab!
echo ======FINISHED!======
echo GitLab was Done!
echo -e "\n"
echo Submitting all urls to Baidu.
echo Generating url file with hexo g.
hexo g
echo Navigate to /public and find urls.txt.
cd /g/HexoBlog/public
echo Submit these urls to Baidu with Curl-cli.
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://www.wzblog.fun&token=TwFhN5gM4BMIe0a9"
echo Submitted all urls to Baidu!
echo ======FINISHED!======
read -p "Press any key to continue." var