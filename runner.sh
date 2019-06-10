echo Publishing blog to GitLab Pages.
read -p "PLEASE ENTER COMMIT DESCRIPTION TEXT:" content
echo -e " \n"
echo "YOUR  COMMIT DESCRIPTION IS: $content"
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