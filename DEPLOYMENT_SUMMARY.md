# 部署变更摘要

## 变更概述

为了简化部署流程，减少环境变量配置错误，我们对项目进行了以下关键变更：

1. **API密钥硬编码**：将Ave.ai API密钥直接硬编码到代码中，消除对环境变量的依赖
2. **简化部署流程**：移除了对.env文件的依赖，减少部署步骤
3. **更新部署文档**：修改了DEPLOYMENT.md和README.md，反映最新的部署要求
4. **更新部署脚本**：修改了部署脚本，移除了.env文件创建步骤

## 已修改的文件

1. **app/lib/ave-api-service.ts**：硬编码API密钥常量
2. **app/api/search-tokens/route.ts**：硬编码API密钥常量
3. **app/api/tokens/route.ts**：硬编码API密钥常量
4. **app/api/token-kline/route.ts**：硬编码API密钥常量
5. **DEPLOYMENT.md**：更新环境变量部分，反映API密钥已硬编码
6. **README.md**：更新安装步骤和安全考虑部分
7. **scripts/deploy.sh**：移除.env文件创建步骤
8. **scripts/deploy.bat**：移除.env文件创建步骤

## 硬编码的API密钥

已将以下API密钥硬编码到项目中：

```
NMUuJmYHJB6d91bIpgLqpuLLKYVws82lj0PeDP3UEb19FoyWFJUVGLsgE95XTEmA
```

## 部署步骤

现在部署流程大大简化：

1. **克隆或下载代码**：
   ```bash
   git clone https://github.com/afsdfdf/xai1.git
   cd xai1
   ```

2. **安装依赖**：
   ```bash
   npm install --legacy-peer-deps
   ```

3. **构建应用**：
   ```bash
   npm run build
   ```

4. **启动服务**：
   ```bash
   npm start
   ```

或者使用部署脚本：
- Windows: `scripts\deploy.bat`
- Linux/macOS: `./scripts/deploy.sh`

## 注意事项

1. **API密钥安全**：由于API密钥已硬编码到应用中，不再需要单独保护.env文件
2. **未来维护**：如需更换API密钥，需要修改以下文件：
   - app/lib/ave-api-service.ts
   - app/api/search-tokens/route.ts
   - app/api/tokens/route.ts
   - app/api/token-kline/route.ts 