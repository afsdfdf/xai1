# XAI2 加密货币交易应用

XAI2是一个基于Next.js开发的加密货币交易应用，提供代币搜索、市场排行榜、K线图表等功能。

## 技术栈

- **前端框架**：Next.js 14 (App Router)
- **UI库**：Tailwind CSS + shadcn/ui
- **图表**：Lightweight Charts
- **类型系统**：TypeScript
- **API集成**：Ave.ai API
- **错误处理**：自定义ErrorBoundary
- **性能监控**：自定义性能跟踪工具

## 环境要求

- Node.js 18.0.0 或更高版本
- npm 9.0.0 或更高版本
- Git

## 安装步骤

1. 克隆项目：
```bash
git clone https://github.com/afsdfdf/xai1.git
cd xai1
```

2. 安装依赖：
```bash
# 使用 npm
npm install

# 或使用 pnpm
pnpm install
```

3. 环境配置：
- 复制 `.env.example` 文件为 `.env`
- 配置必要的环境变量（如果需要）

4. 开发环境运行：
```bash
npm run dev
# 或
pnpm dev
```

5. 构建生产版本：
```bash
npm run build
# 或
pnpm build
```

6. 启动生产版本：
```bash
npm start
# 或
pnpm start
```

## 常见问题解决

### 1. 依赖安装失败
如果遇到依赖安装问题，请尝试：
```bash
# 清除 npm 缓存
npm cache clean --force

# 删除 node_modules 和 .next
npm run clean

# 重新安装依赖
npm install
```

### 2. 构建错误
如果遇到构建错误：
```bash
# 清理 Next.js 缓存
rm -rf .next

# 重新构建
npm run build
```

### 3. 运行错误
如果遇到运行错误：
- 确保所有环境变量都已正确配置
- 检查 Node.js 版本是否符合要求
- 确保端口 3000 未被占用

### 4. 类型错误
如果遇到 TypeScript 类型错误：
```bash
# 清理 TypeScript 缓存
rm -rf .next
rm -rf node_modules/.cache

# 重新安装依赖
npm install

# 重新构建
npm run build
```

### 5. 样式问题
如果遇到样式问题：
```bash
# 清理缓存
rm -rf .next
rm -rf node_modules/.cache

# 重新安装依赖
npm install

# 重新启动开发服务器
npm run dev
```

## 项目结构

```
app/
  ├── api/                 # API路由
  │   ├── tokens/          # 代币数据API
  │   ├── token-details/   # 代币详情API
  │   └── token-kline/     # K线数据API
  ├── components/          # 组件
  │   ├── token-rankings/  # 代币排行组件(模块化)
  │   └── ui/              # UI组件
  ├── hooks/               # 自定义钩子
  ├── lib/                 # 业务逻辑库
  │   └── monitoring/      # 监控工具
  ├── types/               # 类型定义
  ├── utils/               # 工具函数
  └── constants/           # 常量定义
```

## 核心功能模块

### 1. 错误边界系统

应用实现了统一的错误边界组件，用于捕获和处理React渲染过程中的JavaScript错误。

```typescript
// 使用示例
<ErrorBoundary 
  filterErrors={(error) => error.message.includes('ethereum')}
  onError={(error, info) => logToService(error, info)}
>
  <YourComponent />
</ErrorBoundary>
```

### 2. 代币排行系统

代币排行模块采用了模块化设计，分离了视图和数据逻辑：

- `useTokenData` hook处理数据获取和状态管理
- 子组件处理不同的UI部分(TopicTabs, TokenCard等)
- 性能优化技术包括图像错误处理和懒加载

### 3. K线图表系统

K线图表系统基于LightweightCharts库，支持多种时间周期和指标：

- 支持实时数据更新
- 错误自动恢复机制
- 性能监控和诊断工具

### 4. API集成与缓存

项目使用Ave.ai API获取加密货币数据：

- 实现了API请求性能跟踪
- 错误处理和重试机制
- 本地缓存减少重复请求

## 主要组件说明

### ErrorBoundary

统一的错误边界组件，支持：

- 自定义错误UI
- 错误过滤器
- 重置功能
- 错误日志记录

### TokenRankings

代币排行模块，采用模块化设计：

- 位置: app/components/token-rankings/index.tsx
- 子组件: TokenCard.tsx, TopicTabs.tsx等

### 性能监控工具

自定义性能监控工具，支持组件渲染和API请求性能跟踪：

- 位置: app/lib/monitoring/performance.ts
- 相关hook: app/hooks/usePerformanceTracking.ts

## API服务

项目的后端API服务包括：

### 1. 代币排行API

```
GET /api/tokens?topic={topicId}
```

返回指定主题的代币排行数据。

### 2. 代币详情API

```
GET /api/token-details?blockchain={chain}&address={tokenAddress}
```

返回指定代币的详细信息。

### 3. K线数据API

```
GET /api/token-kline?blockchain={chain}&address={tokenAddress}&timeframe={timeframe}
```

返回指定代币的K线数据。

## 开发指南

### 1. 添加新组件

遵循以下模式添加新组件：

1. 在`app/components`目录下创建组件文件
2. 如果是复杂组件，创建子目录并拆分成多个子组件
3. 使用ErrorBoundary包裹组件以确保错误不会级联
4. 使用usePerformanceTracking监控组件性能

### 2. API扩展

添加新的API端点：

1. 在`app/api`目录下创建新的路由文件
2. 使用监控工具包装API调用
3. 实现适当的错误处理和响应格式化

## 性能优化建议

1. **代码分割**：对大型组件使用动态导入
2. **图像优化**：继续优化图像加载和错误处理
3. **缓存策略**：实现更智能的API响应缓存
4. **预取数据**：为常用路由预取数据

## 安全考虑

1. **API密钥保护**：确保API密钥不暴露在前端代码中
2. **数据验证**：在API端点实现严格的输入验证
3. **错误消息**：确保生产环境中不暴露敏感错误信息

## 常见问题排查

1. **API请求失败**：检查API密钥和日志中的错误消息
2. **图表加载问题**：使用ChartDiagnostic组件调试
3. **组件错误**：查看ErrorBoundary捕获的错误信息

## 代码规范

1. 使用TypeScript类型注解
2. 使用功能组件和React Hooks
3. 保持组件小而聚焦
4. 防止业务逻辑与UI混合