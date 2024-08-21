#!/bin/bash  
  
# 显示菜单  
function show_menu() {  
    echo "请选择一个操作："  
    echo "1. 选项一"  
    echo "2. 选项二"  
    echo "3. 选项三"  
    echo "0. 退出"  
}  
  
# 主函数  
function main() {  
    while true; do  
        show_menu  
        read -p "请输入你的选择 [0-3]: " CHOICE  
  
        # 检查输入是否为数字0-3  
        if ! [[ "$CHOICE" =~ ^[0-3]$ ]]; then  
            echo "无效选择，请输入 0-3。"  
            continue  # 跳过当前循环的剩余部分，回到循环开始  
        fi  
  
        case $CHOICE in  
            0)  
                echo "退出脚本。"  
                exit 0  
                ;;  
            1)  
                echo "执行选项一的操作。"  
                ;;  
            2)  
                echo "执行选项二的操作。"  
                ;;  
            3)  
                echo "执行选项三的操作。"  
                ;;  
        esac  
  
        # 如果需要，可以在这里添加让用户按回车键返回菜单的逻辑  
        # 但在这个简化的例子中，我们直接回到循环的开始  
    done  
}  
  
# 调用主函数  
main