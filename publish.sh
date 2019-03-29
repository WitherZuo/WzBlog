echo Cleaning public repo cache.
hexo clean
echo Generating md to HTML files.
hexo g
echo Compressing files...Waiting for a moment!
python test.py>nul
echo Publishing all files to repo.
hexo d
echo Published all files!
echo Submitting your urls to Baidu...
cd public/
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://www.wzblog.fun&token=TwFhN5gM4BMIe0a9" 
cd /g/HexoBlog