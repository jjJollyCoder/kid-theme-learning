# 1. 使用一个 Node.js 官方镜像（Docsify 依赖 Node 环境）
FROM node:18-alpine

# 2. 设置工作目录
WORKDIR /app

# 3. 拷贝项目文件
COPY . .

# 4. 安装 docsify-cli 工具（全局）
RUN npm install -g docsify-cli

# 5. 暴露端口
EXPOSE 3000

# 6. 启动 docsify 服务（绑定所有地址）
CMD ["docsify", "serve", ".", "--port", "3000", "--no-open"]
