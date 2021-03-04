Clear-Host

Write-Host "请选择要提交哪一个分支？[master/develop]"

$BranchName = Read-Host -Prompt "请输入分支名[master/develop]"
switch ($BranchName) {
    # 提交到 master 分支
    master { 
        # 切换本地分支为 master 分支，并将 develop 分支合并至 master 分支
        Write-Host "该脚本将会提交【所有本地 master 分支的内容改动】到远端 master 分支"
        Write-Host "【请注意：master 分支主要用于公开浏览而非开发预览】"
        Write-Host 
        Write-Host "正在从本地 develop 分支切换到本地 master 分支，并将 develop 分支合并到 master 分支中..."
        git checkout master
        git merge develop
        # 输入 commit 的描述内容文本
        Write-Host 
        $CommitContent = Read-Host -Prompt "请输入本次 commit 的简短描述"
        Clear-Host
        # 显示 commit 的描述内容文本、提交并推送更改至远程分支
        Write-Output "你输入的本次 commit 的简短描述是：$CommitContent"
        Write-Host 
        Write-Output "添加改动的文件..."
        git add -A
        Write-Output "检查文件状态..."
        git status
        Write-Output "生成 commit，开始提交..."
        git commit -m $CommitContent
        Write-Output "推送本地 master 分支的所有改动到远端 master 分支..."
        git push origin master --force
        Write-Output "已推送。"
        Write-Output "======FINISHED!======"
        Write-Output "GitHub 任务结束。"
        # 提交网址到百度站长平台
        Write-Host
        Write-Output "正在提交网址到百度站长平台..."
        Write-Output "使用 'hexo g' 生成 urls.txt 文件..."
        hexo g
        Write-Output "导航到 ‘/public’ 目录并定位 urls.txt 文件..."
        Set-Location public
        Get-ChildItem
        Write-Output "使用 curl 命令行工具提交网址到百度站长平台..."
        Start-Process -FilePath "$env:wzblog/push/baidu-url-submit.bat" -WorkingDirectory "$env:wzblog/public"
        Write-Output "已提交网址到百度站长平台！"
        Write-Output "======FINISHED!======"
        # 将本地分支由 master 分支切换为 develop 分支，结束
        git checkout develop
        Break
    }
    # 提交到 develop 分支
    develop { 
        # 显示提示信息、切换分支为 develop
        Write-Output "该脚本将会提交【所有本地 develop 分支的内容改动】到远端 develop 分支"
        Write-Host 
        git checkout develop
        # 输入 commit 的描述内容文本
        Write-Host 
        $CommitContent = Read-Host -Prompt "请输入本次 commit 的简短描述"
        Clear-Host
        # 显示 commit 的描述内容文本、提交并推送更改至远程分支
        Write-Output "你输入的本次 commit 的简短描述是：$CommitContent"
        git status
        git add -A
        git status
        git commit -m $CommitContent
        git push
        Write-Output "所有改动已提交到远端 develop 分支。"
        Break
    }
    Default {
        Write-Output "传入的参数错误，请重新运行脚本，然后再试一次。"
        Break
    }
}

Write-Host "按任意键继续……"
Read-Host | Out-Null
Exit
