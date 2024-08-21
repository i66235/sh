#!/bin/bash

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'  # 重置颜色

# 描述区域
echo -e "${BLUE}#########################################################${RESET}"
echo -e "${BLUE}#                  青龙面板安装脚本                #${RESET}"
echo -e "${BLUE}#                                                       #${RESET}"
echo -e "${BLUE}# 这个脚本将帮助你安装 Docker 并部署 Qinglong 容器。   #${RESET}"
echo -e "${BLUE}#                                                       #${RESET}"
echo -e "${BLUE}# 你可以自定义容器的端口号、主机名和名称。            #${RESET}"
echo -e "${BLUE}#                                                       #${RESET}"
echo -e "${BLUE}# 在运行脚本之前，请确保你以 root 用户身份运行。      #${RESET}"
echo -e "${BLUE}#########################################################${RESET}"
echo ""

# 显示菜单并获取用户选择
function show_menu() {
  clear
  echo -e "${BLUE}请选择一个操作：${RESET}"
  echo -e "1. ${YELLOW}开始安装青龙面板${RESET}"
  echo -e "2. ${YELLOW}查看青龙Docker容器列表${RESET}"
  echo -e "3. ${YELLOW}重启青龙Docker服务${RESET}"
  echo -e "0. ${RED}退出脚本${RESET}"
}

function install_docker() {
  echo -e "${BLUE}正在安装 Docker...${RESET}"
  curl -sSL https://get.docker.com | sh
  if [ $? -ne 0 ]; then
    echo -e "${RED}Docker 安装失败！${RESET}"
    exit 1
  fi
  echo -e "${GREEN}Docker 安装成功！${RESET}"
}

function check_docker_status() {
  echo -e "${BLUE}检查 Docker 安装状态...${RESET}"
  if command -v docker &> /dev/null; then
    echo -e "${GREEN}Docker 已安装。${RESET}"
  else
    echo -e "${RED}Docker 未安装。${RESET}"
  fi
}

function main() {
  while true; do
    #show_menu
    read -p "${YELLOW}请输入你的选择 [0-3]:" CHOICE

    case $CHOICE in
      1)
        # 开始安装并检查 Docker 安装状态
        install_docker
        check_docker_status
        ;;
      2)
        # 查看 Docker 容器列表
        echo -e "${BLUE}查看 Docker 容器列表...${RESET}"
        docker ps
        ;;
      3)
        # 重启 Docker 服务
        echo -e "${BLUE}重启 Docker 服务...${RESET}"
        systemctl restart docker
        if [ $? -ne 0 ]; then
          echo -e "${RED}Docker 服务重启失败！${RESET}"
        else
          echo -e "${GREEN}Docker 服务已重启。${RESET}"
        fi
        ;;
      0)
        # 退出脚本
        echo -e "${GREEN}退出脚本。${RESET}"
        exit 0
        ;;
      *)
        # 处理无效选择
        echo -e "${RED}无效选择，请输入 0-3。${RESET}"
        sleep 5  # 等待2秒钟，以便用户看到错误信息
        ;;
    esac

    # 提示用户按回车键返回菜单
    read -p "${YELLOW}按回车键返回菜单...${RESET}" discard
  done
}

# 进入菜单循环
main
