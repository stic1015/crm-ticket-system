# CRM Ticket System

CRM 工单系统真实工程骨架。

## 技术栈

- Frontend: Vue 3 + TypeScript + Vite + Vue Router + Pinia + Element Plus
- Backend: Java 21 + Spring Boot 3 + Spring Security + Spring Data JPA
- Database: PostgreSQL
- Cache/Queue: Redis
- Migration: Flyway

## 目录

- `apps/web`: 前端应用
- `apps/server`: Java 后端服务
- `infra`: 基础设施说明

## 当前状态

- 已完成项目骨架初始化
- 已预留 MVP 核心模块目录
- Java 工具链未在当前环境中安装，因此后端尚未执行本地编译验证

## MVP 一期

- 登录 / RBAC
- 首页总览
- 客户中心 CRUD
- 工单管理列表 / 创建 / 详情 / 分派 / 状态流转
- 审计日志
## Deployment Docs

- `DEPLOY_PUBLIC.md`
- `DEPLOY_VERCEL_RENDER.md`
