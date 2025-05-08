#!/bin/bash

# XAI Finance 快速部署脚本
# 使用方法: bash scripts/deploy.sh

set -e

echo "===== XAI Finance 部署脚本 ====="
echo "正在检查环境..."

# 检查 Node.js 版本
if ! command -v node &> /dev/null; then
  echo "错误: Node.js 未安装，请安装 Node.js 18.0.0 或更高版本"
  exit 1
fi

NODE_VERSION=$(node -v | cut -d 'v' -f 2)
NODE_MAJOR=$(echo $NODE_VERSION | cut -d '.' -f 1)

if [ $NODE_MAJOR -lt 18 ]; then
  echo "错误: Node.js 版本 ($NODE_VERSION) 太低，请安装 18.0.0 或更高版本"
  exit 1
fi

echo "Node.js 版本: $NODE_VERSION - 符合要求 ✅"

# 检查 npm 版本
if ! command -v npm &> /dev/null; then
  echo "错误: npm 未安装"
  exit 1
fi

NPM_VERSION=$(npm -v)
NPM_MAJOR=$(echo $NPM_VERSION | cut -d '.' -f 1)

if [ $NPM_MAJOR -lt 9 ]; then
  echo "错误: npm 版本 ($NPM_VERSION) 太低，请安装 9.0.0 或更高版本"
  exit 1
fi

echo "npm 版本: $NPM_VERSION - 符合要求 ✅"

# 清理缓存
echo "正在清理缓存..."
rm -rf .next
echo "缓存已清理 ✅"

# 安装依赖
echo "正在安装依赖..."
npm install --legacy-peer-deps
echo "依赖安装完成 ✅"

# 构建项目
echo "正在构建项目..."
npm run build
echo "构建完成 ✅"

# 启动服务
echo "===== 部署完成 ====="
echo "您可以使用以下命令启动服务:"
echo "npm start"
echo ""
echo "或者直接现在启动:"
read -p "是否现在启动服务? (y/n): " START_NOW
if [[ $START_NOW == "y" || $START_NOW == "Y" ]]; then
  npm start
else
  echo "您可以稍后使用 'npm start' 启动服务"
fi 