# XAI Finance 部署指南

本文档提供了在不同环境下部署 XAI Finance 应用的详细步骤。

## 目录
1. [环境要求](#环境要求)
2. [本地部署](#本地部署)
3. [服务器部署](#服务器部署)
4. [Vercel部署](#vercel部署)
5. [环境变量配置](#环境变量配置)
6. [常见问题](#常见问题)

## 环境要求

- **Node.js**: 18.0.0 或更高版本
- **npm/pnpm**: 9.0.0 或更高版本
- **操作系统**: Windows, macOS, Linux 均支持

## 本地部署

### Windows环境

1. 克隆仓库或下载代码:
   ```bash
   git clone https://github.com/afsdfdf/xai1.git
   cd xai1
   ```

2. 使用快速部署脚本(推荐):
   - 运行 `scripts\deploy.bat`

3. 手动部署:
   ```bash
   # 创建环境变量文件
   copy .env.example .env
   
   # 安装依赖
   npm install --legacy-peer-deps
   
   # 构建应用
   npm run build
   
   # 启动服务
   npm start
   ```

### Linux/macOS环境

1. 克隆仓库或下载代码:
   ```bash
   git clone https://github.com/afsdfdf/xai1.git
   cd xai1
   ```

2. 使用快速部署脚本(推荐):
   ```bash
   chmod +x scripts/deploy.sh
   ./scripts/deploy.sh
   ```

3. 手动部署:
   ```bash
   # 创建环境变量文件
   cp .env.example .env
   
   # 安装依赖
   npm install --legacy-peer-deps
   
   # 构建应用
   npm run build
   
   # 启动服务
   npm start
   ```

## 服务器部署

### 使用PM2(推荐)

1. 安装PM2:
   ```bash
   npm install -g pm2
   ```

2. 完成本地部署的所有步骤

3. 使用PM2启动服务:
   ```bash
   pm2 start npm --name "xai-finance" -- start
   ```

4. 设置自动启动:
   ```bash
   pm2 startup
   pm2 save
   ```

### Nginx配置

如果使用Nginx作为反向代理，配置示例:

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

## Vercel部署

1. 注册/登录 [Vercel](https://vercel.com)

2. 导入GitHub仓库:
   - 点击 "Add New..." -> "Project"
   - 选择 GitHub 仓库
   - 点击 "Import"

3. 配置项目:
   - 配置环境变量(参考 `.env.example`)
   - 部署设置保留默认值
   - 点击 "Deploy"

## 环境变量配置

必需的环境变量:

| 变量名 | 描述 | 默认值 |
|--------|------|--------|
| NEXT_PUBLIC_AVE_API_KEY | Ave.ai API密钥 | (必填) |
| NEXT_PUBLIC_AVE_API_URL | Ave.ai API基础URL | https://api.ave.ai/v1 |
| NEXT_PUBLIC_CACHE_DURATION | 缓存持续时间(秒) | 3600 |
| NEXT_PUBLIC_ENABLE_CHARTS | 是否启用图表 | true |
| NEXT_PUBLIC_ENABLE_SEARCH | 是否启用搜索 | true |

## 常见问题

### 1. Node.js版本问题

错误: `The engine "node" is incompatible with this module.`

解决: 安装兼容的Node.js版本(18.x+):
```bash
# 使用nvm(推荐)
nvm install 18
nvm use 18

# 或直接从官网下载
# https://nodejs.org/
```

### 2. 依赖安装失败

错误: `npm ERR! code ERESOLVE`

解决: 使用`--legacy-peer-deps`标志:
```bash
npm install --legacy-peer-deps
```

### 3. 构建错误

错误: `Error: Cannot find module 'tailwindcss'`

解决: 重新安装依赖并确保没有丢失包:
```bash
rm -rf node_modules
npm cache clean --force
npm install --legacy-peer-deps
```

### 4. API连接问题

错误: `Failed to fetch data from API`

解决: 检查以下几点:
- 确认环境变量中的API密钥配置正确
- 验证网络连接是否正常
- 检查API服务是否可用

### 5. 样式加载问题

问题: 页面加载但样式丢失

解决: 
- 确保构建过程成功完成
- 检查浏览器控制台是否有CSS加载错误
- 尝试清除浏览器缓存
- 验证Tailwind CSS是否正确集成 