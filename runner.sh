echo Publishing blog to GitLab Pages.
echo Adding all files modified to prepare commits.
git add -A
echo Checking status of all files before committing.
git status
echo Commit all files.
git commit -m "commit to blog, updated."
echo Push all commits to GitLab repo.
git push origin master
echo Published all files to GitLab!
echo ======FINISHED!======
echo GitLab was Done!
echo           
echo Publishing blog to GitHub Pages.
echo Please note: IF THERE ARE MANY FILES IN YOUR BLOG, THIS PROCESS WILL BE SO SLOW!
echo ======BEGIN!======
echo Cleaning public repo cache.
hexo clean
echo Generating md to HTML files.
hexo g
echo Publishing all files to repo.
hexo d
echo Published all files to GitHub
echo ======FINISHED!======
echo GitHub was Done!
echo *****WARNING!*****
echo YOU SHOULD NOTICE THE MAIL IF SOMETHING WENT WRONG!