# Release v1.12.3 - 添加百度地图API配置指南

## 🎉 更新内容

### ✨ 新增功能
- ✅ 添加完整的百度地图API配置教程文档
- ✅ 添加上传前安全检查工具和脚本
- ✅ 添加GitHub描述和社交媒体分享文案

### 🐛 Bug修复
- ✅ 修复 `MainActivity.java` 中 `BuildConfig.MAPS_SAFE_CODE` 编译错误
- ✅ 移除所有硬编码的敏感信息

### 🔒 安全改进
- ✅ 更新 `.gitignore` 防止敏感信息泄露
- ✅ 添加自动安全检查脚本 `check_before_push.ps1`
- ✅ 创建详细的安全检查清单文档

### 📖 文档更新
- ✅ 更新 README 添加醒目的配置提示
- ✅ 新增 [配置百度地图API完整指南.md](./配置百度地图API完整指南.md)
- ✅ 新增 [上传GitHub前安全检查清单.md](./上传GitHub前安全检查清单.md)
- ✅ 新增 [GITHUB_DESCRIPTION.md](./GITHUB_DESCRIPTION.md)

---

## ⚠️ 重要提示

### 🔑 需要自行配置百度地图 API Key

**本APK不包含API Key，无法直接使用！**

使用前必须：
1. 在[百度地图开放平台](https://lbsyun.baidu.com/)注册并申请API Key
2. 按照 [配置百度地图API完整指南.md](./配置百度地图API完整指南.md) 进行配置
3. 修改代码后重新编译APK

### 📚 配置步骤

详细步骤请查看：[配置百度地图API完整指南.md](./配置百度地图API完整指南.md)

简要步骤：
1. 申请百度地图 API Key
2. 修改 `MainActivity.java` 第921行
3. 创建 `local.properties` 配置文件
4. 获取APK签名SHA1
5. 在百度后台配置SHA1白名单
6. 使用Android Studio编译APK

---

## 📱 安装要求

- Android 8.0 (API 26) 或更高版本
- 需要授予位置权限
- 需要开启"模拟位置"权限

---

## 📥 下载说明

### Debug版本（本Release）
- 文件：`Go_1.12.3_arm64-v8a_debug.apk`
- 架构：arm64-v8a
- 签名：Debug签名
- 用途：测试和学习

### Release版本
如需Release版本，请：
1. Clone本仓库
2. 按照配置指南配置API Key
3. 使用Android Studio编译Release版本

---

## 🆕 本次发布特点

### 🎓 学习友好
- 📖 详细的新手配置教程
- 🔍 常见问题解答
- 💡 技术原理说明
- 🛠️ 安全检查工具

### 🔒 安全优化
- 移除所有敏感信息
- 完善的 .gitignore 配置
- 自动化安全检查
- 详细的安全指南

### 📚 文档完善
- 配置教程（已脱敏）
- 安全检查清单
- GitHub发布指南
- 社交媒体分享文案

---

## 🙏 致谢

感谢原作者 [ZCShou](https://github.com/ZCShou) 开源此项目！

本Fork版本主要添加了完整的配置文档和安全工具，方便新手学习使用。

---

## 📜 许可证

GPL-3.0-only © ZCShou

---

## ⚖️ 免责声明

本项目仅供学习研究使用，请勿用于：
- 游戏作弊
- 校园运动打卡作弊
- 任何违反法律法规的行为

使用本项目产生的一切后果由使用者自行承担。

---

## 🔗 相关链接

- 📖 [配置百度地图API完整指南](./配置百度地图API完整指南.md)
- 🔒 [上传GitHub前安全检查清单](./上传GitHub前安全检查清单.md)
- 📝 [GitHub描述文档](./GITHUB_DESCRIPTION.md)
- 🌟 [原项目地址](https://github.com/ZCShou/GoGoGo)
- 🗺️ [百度地图开放平台](https://lbsyun.baidu.com/)

---

**如有问题，欢迎提交 Issue！**

