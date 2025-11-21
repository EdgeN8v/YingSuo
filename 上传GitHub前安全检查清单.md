# 📋 上传 GitHub 前安全检查清单

## ⚠️ 请在执行 `git push` 前，逐项检查以下内容！

---

## ✅ 必须检查的文件

### 1️⃣ **local.properties**
```bash
# 检查命令（在项目根目录）
git status local.properties
```

**预期结果**：
```
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	local.properties

nothing added to commit but untracked files present (use "git add" to track)
```

或者显示：`nothing to commit, working tree clean`（文件被忽略）

✅ **正确**：文件不在暂存区（staging area）
❌ **错误**：如果显示 `Changes to be committed:` 说明文件将被上传！

**紧急修复**：
```bash
git rm --cached local.properties
echo "local.properties" >> .gitignore
```

---

### 2️⃣ **keystore/ 目录**
```bash
# 检查命令
git status keystore/
```

**预期结果**：
```
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	keystore/
```

✅ **正确**：keystore 目录不在暂存区
❌ **错误**：如果显示将被提交，立即执行：

```bash
git rm -r --cached keystore/
echo "keystore/" >> .gitignore
```

---

### 3️⃣ **编译输出文件**
```bash
# 检查命令
git status app/build/
```

**预期结果**：不显示任何内容（被忽略）

✅ **正确**：build 目录被 .gitignore 忽略
❌ **错误**：如果显示 APK 文件将被上传：

```bash
git rm -r --cached app/build/
```

---

### 4️⃣ **检查 .gitignore**
```bash
cat .gitignore | grep -E "local.properties|keystore|*.jks"
```

**必须包含**：
```
local.properties
*.jks
*.keystore
keystore/
```

---

### 5️⃣ **检查代码中是否硬编码了敏感信息**
```bash
# 搜索可能的 API Key
git grep -i "api.*key" | grep -v "YOUR_.*API"
git grep "MAPS_API_KEY" | grep -v "BuildConfig"
```

✅ **正确**：只找到 `BuildConfig.MAPS_API_KEY`（从配置文件读取）
❌ **错误**：如果找到硬编码的 Key，立即删除！

---

## 📝 完整检查流程

### 第一步：查看即将提交的文件
```bash
git status
git diff --cached
```

### 第二步：检查敏感文件
```bash
# 检查是否包含敏感文件
git ls-files | grep -E "local.properties|keystore|*.jks|*.keystore"
```

**预期结果**：没有任何输出

### 第三步：检查文件内容
```bash
# 搜索所有即将提交的文件中的敏感信息
git diff --cached | grep -i "api.*key"
git diff --cached | grep -E "[A-Za-z0-9]{32,}"  # 搜索长字符串
```

### 第四步：安全提交
```bash
git add .
git commit -m "你的提交信息"
git push origin master
```

---

## 🔒 敏感信息示例（绝对不能出现在代码中！）

### ❌ 错误示例：

```java
// MainActivity.java
String apiKey = "KKyp5hZXyv9HD9ZMrwkE6NE0FtATIuxw";  // ❌ 硬编码
```

```properties
# build.gradle
buildConfigField "String", "API_KEY", "\"KKyp5hZXyv9HD9ZMrwkE6NE0FtATIuxw\""  // ❌ 硬编码
```

### ✅ 正确示例：

```java
// MainActivity.java
String apiKey = BuildConfig.MAPS_API_KEY;  // ✅ 从配置读取
```

```properties
# local.properties（被 .gitignore 忽略）
MAPS_API_KEY=KKyp5hZXyv9HD9ZMrwkE6NE0FtATIuxw
```

---

## 🚨 如果不小心已经上传了敏感信息

### 立即操作：

1. **撤销最后一次提交**（如果还没push）：
```bash
git reset --soft HEAD~1
```

2. **从历史记录中删除敏感文件**（如果已经push）：
```bash
git filter-branch --force --index-filter \
"git rm --cached --ignore-unmatch local.properties" \
--prune-empty --tag-name-filter cat -- --all

git push origin --force --all
```

3. **立即更换 API Key**：
   - 登录百度地图后台
   - 删除泄露的 API Key
   - 创建新的 API Key
   - 本地更新配置

---

## 📋 上传前最终检查清单

在执行 `git push` 前，确认：

- [ ] `local.properties` 不在暂存区
- [ ] `keystore/` 目录不在暂存区
- [ ] `.apk` 文件不在暂存区
- [ ] `build/` 目录不在暂存区
- [ ] 代码中没有硬编码 API Key
- [ ] 代码中没有硬编码 SHA1
- [ ] README 和文档中使用的是示例占位符
- [ ] `.gitignore` 已正确配置

**全部打勾后，才能安全上传！** ✅

---

## 🔐 最佳实践

1. **使用环境变量**：
   ```bash
   export BAIDU_API_KEY="your_key_here"
   ```

2. **使用 local.properties**：
   ```properties
   MAPS_API_KEY=your_key_here
   ```

3. **绝不在代码中硬编码**

4. **定期检查 GitHub 仓库**：
   - 搜索可能的敏感信息泄露
   - 使用 GitHub Secret Scanning

5. **使用 git-secrets 工具**：
   ```bash
   git secrets --install
   git secrets --register-aws
   ```

---

## 📞 紧急联系

如果发现敏感信息已泄露：

1. 立即更换所有密钥
2. 检查是否有异常调用
3. 联系平台客服说明情况
4. 删除 Git 历史记录中的敏感信息

---

**记住：安全第一！宁可多检查几遍，也不要让敏感信息泄露！** 🔒

