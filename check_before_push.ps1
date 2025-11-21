# 上传 GitHub 前的安全检查脚本
# 使用方法：在项目根目录运行 .\check_before_push.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GitHub 上传前安全检查" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$hasError = $false

# 检查1：local.properties
Write-Host "[1/6] 检查 local.properties..." -NoNewline
$localProps = git ls-files | Select-String "local.properties"
if ($localProps) {
    Write-Host " ❌ 错误！" -ForegroundColor Red
    Write-Host "  local.properties 在Git跟踪中！请立即移除：" -ForegroundColor Red
    Write-Host "  git rm --cached local.properties" -ForegroundColor Yellow
    $hasError = $true
} else {
    Write-Host " ✅ 通过" -ForegroundColor Green
}

# 检查2：keystore目录
Write-Host "[2/6] 检查 keystore/ 目录..." -NoNewline
$keystore = git ls-files | Select-String "keystore/"
if ($keystore) {
    Write-Host " ❌ 错误！" -ForegroundColor Red
    Write-Host "  keystore/ 目录在Git跟踪中！请立即移除：" -ForegroundColor Red
    Write-Host "  git rm -r --cached keystore/" -ForegroundColor Yellow
    $hasError = $true
} else {
    Write-Host " ✅ 通过" -ForegroundColor Green
}

# 检查3：APK文件
Write-Host "[3/6] 检查 APK 文件..." -NoNewline
$apk = git ls-files | Select-String "\.apk$"
if ($apk) {
    Write-Host " ⚠️  警告" -ForegroundColor Yellow
    Write-Host "  发现 APK 文件在Git中，建议移除" -ForegroundColor Yellow
    $hasError = $true
} else {
    Write-Host " ✅ 通过" -ForegroundColor Green
}

# 检查4：build目录
Write-Host "[4/6] 检查 build/ 目录..." -NoNewline
$build = git ls-files | Select-String "app/build/"
if ($build) {
    Write-Host " ⚠️  警告" -ForegroundColor Yellow
    Write-Host "  build/ 目录在Git中，建议移除" -ForegroundColor Yellow
} else {
    Write-Host " ✅ 通过" -ForegroundColor Green
}

# 检查5：.gitignore配置
Write-Host "[5/6] 检查 .gitignore 配置..." -NoNewline
$gitignore = Get-Content ".gitignore" -Raw
$required = @("local.properties", "*.jks", "*.keystore", "keystore/")
$missing = @()
foreach ($item in $required) {
    if ($gitignore -notmatch [regex]::Escape($item)) {
        $missing += $item
    }
}
if ($missing.Count -gt 0) {
    Write-Host " ❌ 错误！" -ForegroundColor Red
    Write-Host "  .gitignore 缺少以下配置：" -ForegroundColor Red
    $missing | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
    $hasError = $true
} else {
    Write-Host " ✅ 通过" -ForegroundColor Green
}

# 检查6：代码中的硬编码API Key
Write-Host "[6/6] 检查代码中的敏感信息..." -NoNewline
$javaFiles = Get-ChildItem -Path "app/src" -Filter "*.java" -Recurse
$foundSensitive = $false
foreach ($file in $javaFiles) {
    $content = Get-Content $file.FullName -Raw
    # 查找长度>30的字符串（可能是API Key）
    if ($content -match '"[A-Za-z0-9]{30,}"' -and $content -notmatch "YOUR_.*API") {
        $foundSensitive = $true
        break
    }
}
if ($foundSensitive) {
    Write-Host " ⚠️  警告" -ForegroundColor Yellow
    Write-Host "  发现可能的硬编码API Key，请手动检查" -ForegroundColor Yellow
} else {
    Write-Host " ✅ 通过" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

if ($hasError) {
    Write-Host "❌ 检查未通过！请修复上述问题后再上传" -ForegroundColor Red
    Write-Host ""
    Write-Host "建议执行：" -ForegroundColor Yellow
    Write-Host "  git rm --cached local.properties" -ForegroundColor Yellow
    Write-Host "  git rm -r --cached keystore/" -ForegroundColor Yellow
    Write-Host "  git rm -r --cached app/build/" -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "✅ 所有检查通过！可以安全上传到 GitHub" -ForegroundColor Green
    Write-Host ""
    Write-Host "执行以下命令上传：" -ForegroundColor Cyan
    Write-Host "  git add ." -ForegroundColor White
    Write-Host "  git commit -m '你的提交信息'" -ForegroundColor White
    Write-Host "  git push origin master" -ForegroundColor White
    exit 0
}

