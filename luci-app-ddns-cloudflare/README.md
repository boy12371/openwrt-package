# luci-app-ddns-cloudflare

OpenWrt LuCI界面支持Cloudflare动态DNS服务

## 功能特性

- 提供Web界面配置Cloudflare DDNS
- 支持设置：
  - 启用/禁用服务
  - 更新间隔(分钟)
  - Cloudflare API密钥
  - 域名(Zone)
  - DNS记录名称

## 安装方法

1. 将软件包上传到OpenWrt设备
2. 使用opkg安装：
   ```bash
   opkg install luci-app-ddns-cloudflare
   ```

## 配置说明

1. 登录LuCI界面
2. 导航到"服务" → "DDNS Cloudflare"
3. 配置以下参数：
   - 启用服务
   - 设置更新间隔
   - 输入Cloudflare API密钥
   - 输入域名(如example.com)
   - 输入记录名称(如www)

## 后续开发建议

<!-- - 在index.lua添加"启动"，"停止"和"重启"按钮，并在本页显示相应文字 -->
