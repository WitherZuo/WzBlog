# 显示提示信息、切换分支为 develop
echo 该脚本将会提交【所有本地 develop 分支的内容改动】到远端 develop 分支
echo -e "\n"
git checkout develop
# 输入 commit 的描述内容文本
echo -e "\n"
read -p "请输入本次 commit 的简短描述：" content
clear
# 显示 commit 的描述内容文本、提交并推送更改至远程分支
echo "你输入的本次 commit 的简短描述是：$content"
git status
git add -A
git status
git commit -m "$content"
git push
echo 所有改动已提交到远端 develop 分支。
read -p "请按任意键继续..." var
exit