@echo off
REM XAI Finance 快速部署脚本 (Windows版)
REM 使用方法: 双击此文件或在命令行中运行 scripts\deploy.bat

echo ===== XAI Finance 部署脚本 =====
echo 正在检查环境...

REM 检查 Node.js 版本
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
  echo 错误: Node.js 未安装，请安装 Node.js 18.0.0 或更高版本
  exit /b 1
)

for /f "tokens=1,2,3 delims=." %%a in ('node -v') do (
  set NODE_MAJOR=%%a
)
set NODE_MAJOR=%NODE_MAJOR:~1%

if %NODE_MAJOR% LSS 18 (
  echo 错误: Node.js 版本太低，请安装 18.0.0 或更高版本
  exit /b 1
)

echo Node.js 已安装 - 符合要求 ✓

REM 检查 npm 版本
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
  echo 错误: npm 未安装
  exit /b 1
)

echo npm 已安装 - 符合要求 ✓

REM 环境变量配置
if not exist .env (
  if exist .env.example (
    echo 未找到 .env 文件，正在从 .env.example 创建...
    copy .env.example .env
    echo .env 文件已创建，请检查并更新其中的 API 密钥 ⚠
  ) else (
    echo 错误: 未找到 .env.example 文件，无法创建 .env
    exit /b 1
  )
) else (
  echo 发现 .env 文件 ✓
)

REM 清理缓存
echo 正在清理缓存...
if exist .next rmdir /s /q .next
echo 缓存已清理 ✓

REM 安装依赖
echo 正在安装依赖...
call npm install --legacy-peer-deps
echo 依赖安装完成 ✓

REM 构建项目
echo 正在构建项目...
call npm run build
echo 构建完成 ✓

REM 启动服务
echo ===== 部署完成 =====
echo 您可以使用以下命令启动服务:
echo npm start
echo.

set /p START_NOW="是否现在启动服务? (y/n): "
if /i "%START_NOW%"=="y" (
  call npm start
) else (
  echo 您可以稍后使用 'npm start' 启动服务
) 