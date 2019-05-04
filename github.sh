echo Publishing blog to GitHub Pages.
echo *****WARNING!*****
echo This blog also have GitLab repo, PLEASE REMENBER TO PUSH ALL COMMITS TO GITLAB!
echo ======BEGIN!======
echo Cleaning public repo cache.
hexo clean
echo Generating md to HTML files.
hexo g --watch
echo Publishing all files to repo.
hexo d
echo Published all files!
echo ======FINISHED!======
echo *****WARNING!*****
echo This blog also have GitLab repo, PLEASE REMENBER TO PUSH ALL COMMITS TO GITLAB!