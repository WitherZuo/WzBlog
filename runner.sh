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