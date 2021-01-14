#!bin/bash
echo 1 - 显示 one
echo 2 - 显示 two
read -p "你想显示哪一个数：" number
case $number in
    1)
    echo one
    ;;
    2)
    echo two
    ;;
    *)
    echo error!
    ;;
esac
read -p "按任意键退出" var
exit