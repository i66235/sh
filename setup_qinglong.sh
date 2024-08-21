#!/bin/bash

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'  # 重置颜色

# 描述区域
echo -e "${BLUE}#########################################################${RESET}"
echo -e "${BLUE}#                  Qinglong 容器安装脚本                #${RESET}"
echo -e "${BLUE}#                                                       #${RESET}"
echo -e "${BLUE}# 这个脚本将帮助你安装 Docker 并部署 Qinglong 容器。   #${RESET}"
echo -e "${BLUE}#                                                       #${RESET}"
echo -e "${BLUE}# 你可以自定义容器的端口号、主机名和名称。            #${RESET}"
echo -e "${BLUE}#                                                       #${RESET}"
echo -e "${BLUE}# 在运行脚本之前，请确保你以 root 用户身份运行。      #${RESET}"
echo -e "${BLUE}#########################################################${RESET}"
echo ""

# 检查 Docker 安装状态
echo -e "${BLUE}检查 Docker 安装状态...${RESET}"
if command -v docker &> /dev/null; then
  echo -e "${GREEN}Docker 已安装。${RESET}"
else
  echo -e "${RED}Docker 未安装。${RESET}"
fi

# 提示用户按回车键继续
read -p "${YELLOW}按回车键继续安装 Docker（如果未安装）并启动 Qinglong 容器...${RESET}"

# 安装 Docker（如果尚未安装）
if ! command -v docker &> /dev/null; then
  echo -e "${BLUE}Docker 未安装，正在安装 Docker...${RESET}"
  curl -sSL get.docker.com | sh
  if [ $? -ne 0 ]; then
    echo -e "${RED}Docker 安装失败！${RESET}"
    exit 1
  fi
  echo -e "${GREEN}Docker 安装成功！${RESET}"
else
  echo -e "${GREEN}Docker 已安装。${RESET}"
fi

# 获取用户输入的端口、主机名和容器名称
read -p "${YELLOW}请输入 Qinglong 容器的端口号 [默认为 5700]: " QL_PORT
# 如果用户没有输入，使用默认值 5700
QL_PORT=${QL_PORT:-5700}

read -p "${YELLOW}请输入 Qinglong 容器的主机名 [默认为 qinglong]: " QL_HOSTNAME
# 如果用户没有输入，使用默认值 qinglong
QL_HOSTNAME=${QL_HOSTNAME:-qinglong}

read -p "${YELLOW}请输入 Qinglong 容器的名称 [默认为 qinglong]: " QL_NAME
# 如果用户没有输入，使用默认值 qinglong
QL_NAME=${QL_NAME:-qinglong}

# 运行 Qinglong Docker 容器
echo -e "${BLUE}正在启动 Qinglong Docker 容器...${RESET}"
docker run -dit \
  -v $PWD/ql/data:/ql/data \
  -p ${QL_PORT}:${QL_PORT} \
  -e QlBaseUrl="/" \
  -e QlPort="${QL_PORT}" \
  --name ${QL_NAME} \
  --hostname ${QL_HOSTNAME} \
  --restart unless-stopped \
  whyour/qinglong:latest

# 检查 Docker 容器运行状态
echo -e "${BLUE}检查 Qinglong 容器运行状态...${RESET}"
if docker ps --filter "name=${QL_NAME}" | grep -q "${QL_NAME}"; then
  echo -e "${GREEN}Qinglong 容器正在运行。${RESET}"
else
  echo -e "${RED}Qinglong 容器未运行。${RESET}"
fi

# 提示用户按任意键退出
read -n 1 -p "${YELLOW}按任意键退出...${RESET}"
