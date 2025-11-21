# 影梭(YingSuo) - 百度地图 API 配置完整指南

## 🔒 安全警告

⚠️ **重要提示**：
- **本文档中的 API Key、SHA1 等信息均为示例占位符**
- **请勿将真实的 API Key 上传到 GitHub！**
- **`local.properties` 和 `keystore/` 目录已在 `.gitignore` 中被忽略**
- **上传前请务必检查没有包含任何个人敏感信息**

---

## 📋 项目信息

- **项目名称**: 影梭 (GoGoGo)
- **包名**: `com.zcshou.gogogo`
- **项目路径**: `E:\GitHub\YingSuo`

---

## 🎯 问题背景

原作者的百度地图 API Key 已失效，导致地图无法加载、搜索功能不可用。

---

## ✅ 解决方案概述

1. 注册百度地图开发者账号并创建应用
2. 获取新的 API Key (AK)
3. **修改项目代码**（重要！）
4. 配置 `local.properties` 文件
5. 获取 APK 的 SHA1 签名
6. 在百度后台配置 SHA1 白名单
7. 编译并安装 APK

---

## 🔧 详细步骤

### 第一步：注册百度地图开发者

1. 访问：https://lbsyun.baidu.com/
2. 登录/注册百度账号
3. 完成个人开发者认证（需要身份证）
4. 创建 Android 应用
   - 应用名称：`YingSuo` 或任意名称
   - 应用类型：Android SDK
   - 包名：`com.zcshou.gogogo`
   - 临时 SHA1：随便填一个（后面会更新）
5. 获取 API Key (AK)

**配置示例**：
```
API Key: YOUR_BAIDU_API_KEY_HERE（替换成你从百度地图后台获取的AK）
应用名称: YingSuo（或任意名称）
包名: com.zcshou.gogogo
```

---

### 第二步：修改项目代码 ⭐⭐⭐（关键！）

#### 📝 文件1：`app/src/main/java/com/zcshou/gogogo/MainActivity.java`

**位置**：第 921 行

**原代码**：
```java
final String safeCode = BuildConfig.MAPS_SAFE_CODE;
```

**修改为**：
```java
// final String safeCode = BuildConfig.MAPS_SAFE_CODE;
final String safeCode = "";
```

**说明**：注释掉或删除 `BuildConfig.MAPS_SAFE_CODE`，因为这个变量没有配置，会导致编译错误。

---

### 第三步：配置 local.properties 文件

#### 📝 文件2：`local.properties`（项目根目录）

**文件路径**：`E:\GitHub\YingSuo\local.properties`

**完整内容**：
```properties
## This file must *NOT* be checked into Version Control Systems,
# as it contains information specific to your local configuration.
#
# Location of the SDK. This is only used by Gradle.
# For customization when using a Version Control System, please read the
# header note.

# Android SDK 路径（自动生成）
sdk.dir=D:\\AndroidSDK

# 百度地图 API Key（重要！替换成你自己的）
MAPS_API_KEY=YOUR_BAIDU_API_KEY_HERE
```

**说明**：
- `sdk.dir` 是 Android Studio 自动配置的
- `MAPS_API_KEY` 是你从百度地图后台获取的 AK
- ⚠️ **下次换 API Key 只需要修改这一行！**

---

### 第四步：获取 SHA1 签名

#### 方法1：使用 Android Studio（推荐）

1. 打开 Android Studio
2. 右侧点击 **Gradle** 图标 🐘
3. 展开：`YingSuo → app → Tasks → android`
4. 双击 **signingReport**
5. 底部会显示 SHA1

#### 方法2：使用命令行

在项目根目录运行：
```powershell
cd E:\GitHub\YingSuo
$env:JAVA_HOME="D:\Android Studio\jbr"
.\gradlew.bat signingReport
```

**SHA1 示例**：
```
AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD
（这是示例格式，请替换成你自己运行 signingReport 后获取的真实SHA1）
```

---

### 第五步：更新百度地图后台配置

1. 访问：https://lbsyun.baidu.com/apiconsole/key
2. 登录百度账号
3. 找到应用 **YingSuo**
4. 点击 **修改**
5. 填写：
   - **包名**: `com.zcshou.gogogo`
   - **发布版SHA1**: `你的真实SHA1`（从上一步获取）
   - **开发版SHA1**: `你的真实SHA1`（与发布版相同）
6. 点击 **提交**
7. 等待 1-2 分钟生效

---

### 第六步：编译 APK

#### 在 Android Studio 中：

1. 点击顶部菜单 **Build**
2. 选择 **Build Bundle(s) / APK(s)**
3. 点击 **Build APK(s)**
4. 等待编译完成（3-5分钟）
5. 点击提示中的 **locate** 打开 APK 文件夹

**APK 位置**：
```
E:\GitHub\YingSuo\app\build\outputs\apk\debug\
Go_1.12.3_arm64-v8a_debug.apk
```

---

### 第七步：安装并测试

1. 把 APK 传到手机
2. 卸载旧版影梭（如果有）
3. 安装新 APK
4. 打开影梭 APP
5. 授予位置权限
6. 测试搜索功能（搜索"天安门"等地点）
7. ✅ 地图正常显示、搜索有结果 = 成功！

---

## 🔄 下次更换 API Key 的步骤

如果以后需要更换百度地图 API Key（比如超过配额、想用新账号等）：

### 只需要 2 步：

#### 1️⃣ 修改 `local.properties` 文件

把第 10 行的 API Key 改成新的：
```properties
MAPS_API_KEY=YOUR_NEW_BAIDU_API_KEY
```

#### 2️⃣ 重新编译 APK

在 Android Studio 中：
- **Build → Clean Project**
- **Build → Build Bundle(s) / APK(s) → Build APK(s)**

**就这么简单！**

⚠️ **注意**：
- **不需要再改代码**（MainActivity.java 那个只改一次）
- **不需要改 SHA1**（签名文件没变就不用改）
- **只改 local.properties 中的 MAPS_API_KEY**

---

## 📁 重要文件位置总结

| 文件 | 路径 | 作用 |
|------|------|------|
| **MainActivity.java** | `app/src/main/java/com/zcshou/gogogo/MainActivity.java` | 第921行需要修改一次 |
| **local.properties** | 项目根目录 `local.properties` | 配置 API Key（常改） |
| **签名文件** | `keystore/GoGoGo.jks` | 用于签名 APK |
| **build.gradle** | `app/build.gradle` | 项目配置（一般不改） |
| **编译输出** | `app/build/outputs/apk/debug/` | APK 输出位置 |

---

## 🛠️ 常用命令

### 获取 SHA1：
```powershell
cd E:\GitHub\YingSuo
$env:JAVA_HOME="D:\Android Studio\jbr"
.\gradlew.bat signingReport
```

### 清理并重新编译：
```powershell
.\gradlew.bat clean assembleDebug
```

### 编译 Release 版本：
```powershell
.\gradlew.bat assembleRelease
```

---

## ⚠️ 常见问题

### Q1: 地图还是不显示？
**解决**：
1. 检查百度后台的 SHA1 是否正确
2. 等待 2-3 分钟让配置生效
3. 完全退出 APP 重新打开（从后台也关闭）

### Q2: 搜索没有结果？
**解决**：
1. 确认 API Key 配置正确
2. 确认 SHA1 已更新到百度后台
3. 检查网络连接

### Q3: 编译失败？
**解决**：
1. 确认 MainActivity.java 第921行已修改
2. 确认 local.properties 中 API Key 格式正确（没有多余空格）
3. 清理项目：Build → Clean Project

### Q4: 安装失败？
**解决**：
1. 先卸载旧版本
2. 允许安装未知来源应用
3. 检查手机系统版本（需要 Android 8.0+）

---

## 🎓 技术说明

### 为什么需要修改 MainActivity.java？

原代码使用了 `BuildConfig.MAPS_SAFE_CODE`，这是一个在 `build.gradle` 中通过 `buildConfigField` 定义的变量。但项目中没有配置这个变量，导致编译时找不到符号。

两种解决方案：
1. **注释掉**（我们采用的方法）- 简单直接
2. 在 `build.gradle` 中添加 `buildConfigField "String", "MAPS_SAFE_CODE", "\"\""`

### 为什么需要 SHA1？

百度地图通过 **包名 + SHA1** 的组合来验证应用的合法性，防止 API Key 被盗用。
- **包名**：应用的唯一标识
- **SHA1**：APK 签名的指纹，确保 APK 来自可信来源

### local.properties 的作用？

`local.properties` 是 Gradle 的本地配置文件：
- 不会被提交到 Git（已在 .gitignore 中）
- 存储本地特定的配置（SDK路径、密钥等）
- 通过 `BuildConfig.MAPS_API_KEY` 注入到代码中

---

## 📞 联系与支持

- **原项目地址**: https://github.com/ZCShou/GoGoGo
- **百度地图开放平台**: https://lbsyun.baidu.com/
- **百度地图控制台**: https://lbsyun.baidu.com/apiconsole/key

---

## 🎉 完成！

配置完成后，你的影梭 APP 应该可以正常使用百度地图功能了！

**祝使用愉快！** ✨

---

**最后更新**: 2025-11-21
**配置人**: Cui
**Android Studio 版本**: 最新版
**Android Studio 安装路径**: D:\Android Studio\
**Android SDK 路径**: D:\AndroidSDK\

