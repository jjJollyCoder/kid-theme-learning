# 项目总结：Kid Wall 项目部署与相关技术点回顾

## 📌 一、项目背景

为小朋友设计一个可视化的启蒙学习系统，基于 Docsify 展示英文句型卡片，结合 GitHub Pages 和 Docker 实现本地与线上部署。

---

## 🧱 二、技术模块与知识点整理

### 1. Docsify 静态文档框架

* 适合快速展示 Markdown 内容，无需构建步骤。
* 默认读取 `README.md` 文件作为首页。
* 通过 `index.html` 引入 Docsify 脚本实现动态渲染。
* 自定义配置：

  ```js
  window.$docsify = {
    name: 'KID WALL',
    repo: '',
    loadSidebar: true,
    themeColor: '#42b983'
  }
  ```
* 添加侧边栏：创建 `_sidebar.md`

### 2. GitHub Pages 部署

* 创建新仓库，如 `kid-wall`
* 启用 Pages（设置中选择：`main` 分支、`docs` 文件夹或 `root`）
* 自动部署方式：使用 GitHub Actions（需 `deploy.yml`）
* 手动部署方式：push 到 `main` 分支 + 启用 Pages 即可展示

### 3. Docker 打包部署 Docsify

* 使用 Node.js 官方镜像：`node:18-alpine`
* 安装 `docsify-cli` 工具：

  ```dockerfile
  RUN npm install -g docsify-cli
  ```
* 编写 `Dockerfile`：

  ```dockerfile
  FROM node:18-alpine
  WORKDIR /app
  COPY . .
  RUN npm install -g docsify-cli
  EXPOSE 3000
  CMD ["docsify", "serve", ".", "--port", "3000", "--no-open"]
  ```
* 构建镜像：

  ```bash
  docker build -t kid-wall .
  ```
* 启动容器：

  ```bash
  docker run -d -p 3000:3000 --name kid-wall-app kid-wall
  ```
* 常见问题：

  * 端口被占用 → 查找并释放 `3000`
  * 容器没有运行 → 用 `docker ps -a` 查看状态

### 4. 本地调试技巧

* 使用 Docsify 本地预览：

  ```bash
  docsify serve . --no-open
  ```
* 修改内容后如果在 Docker 中查看，需：

  1. 重新构建镜像 `docker build`
  2. 删除旧容器 `docker rm -f kid-wall-app`
  3. 重新 `run`

### 5. SSH Key 与 GitHub 远程操作

* 设置 SSH Key 后仍需创建远程仓库（无法用 CLI 自动创建）
* 使用 SSH 格式的 remote 地址如：

  ```
  git@github.com:yourname/kid-wall.git
  ```
* 常见错误：

  ```
  ERROR: Repository not found. Check access rights
  ```

  多数是因为没有在 GitHub 上手动创建仓库

---

## 📦 三、项目结构建议

```
kid-wall/
├── index.html        # Docsify 页面入口
├── README.md         # 默认主页面
├── _sidebar.md       # 侧边栏（可选）
├── Dockerfile        # Docker 构建文件
└── cards/            # 学习卡片内容（英文/识字/绘画等）
    ├── i-like.md
    ├── i-can-see.md
    └── colors.md
```

---

## 🎯 四、适合练习的场景题（面试式）

### 🧩 场景 1：如何快速部署一个静态 Markdown 网站？

* 答案应包含 Docsify、GitHub Pages 或 MkDocs 对比。

### 🧩 场景 2：如何将一个本地 Markdown 项目 Docker 化并运行？

* Dockerfile 编写 → 构建 → 端口暴露 → 容器运行。

### 🧩 场景 3：GitHub 上 SSH 配置正确，为什么还无法 push？

* 分析远程仓库是否存在、SSH remote 地址是否一致。

### 🧩 场景 4：Docker 端口已占用，如何排查？

* `lsof -i :3000` 或 `docker ps` + `docker rm -f` 清理。

---

## ✅ 五、总结

你已经完整经历了：Docsify 本地预览、GitHub Pages 托管、Docker 本地部署等完整流程，适用于构建个人知识墙、儿童学习平台、快速文档站点等场景。


## 📌 📘 2025-06-11 更新
# Kid-Wall 项目后续待办事项

## 1. 项目搭建与部署流程总结

- 技术框架选择及理由
- 项目搭建流程梳理
- Docker 化步骤说明
- GitHub Pages 部署步骤
- 代码改动后处理流程
  - 是否需重建 Docker 镜像
  - 是否需重启 Docker 容器
  - 是否需 Git 提交流程更新页面
- 常见问题及解决方案

## 2. 丰富 Kid-Wall 内容

- 扩展学习卡片主题及活动
- 3 个月学习计划示例
- 打印及线上浏览卡片模板制作
- 多媒体元素（图片、音频、小游戏）添加

## 3. 申请域名及绑定

- 域名购买渠道推荐
- 域名解析及配置（A 记录、CNAME）
- GitHub Pages 自定义域名绑定
- Docker 服务外网访问配置

## 4. 多项目域名绑定方案

- 单一域名绑定多个项目的可行性
- 子域名配置示例
- 反向代理服务器（如 Nginx）配置参考

---

