@echo off
title curl urls to Baidu.
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://wzblog.fun&token=TwFhN5gM4BMIe0a9"
pause