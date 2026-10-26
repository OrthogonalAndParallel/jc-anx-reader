# WebDAV 连接问题诊断报告

## 问题描述
- APK 中测试 WebDAV 连接失败，提示：`Exception: Failed to create test directory`
- 使用 curl 测试连接成功
- WebDAV 地址：`http://jcfy.dpdns.org:5050`

## 诊断结果

### 1. WebDAV 服务器状态 ✅
使用 curl 测试证明服务器工作正常：
```bash
# PROPFIND 成功
curl -X PROPFIND -u "jinchenj:Jc@19940116" "http://jcfy.dpdns.org:5050/" -H "Depth: 1"

# MKCOL 成功
curl -X MKCOL -u "jinchenj:Jc@19940116" "http://jcfy.dpdns.org:5050/anx_test/"
# 返回: HTTP/1.1 201 Created
```

### 2. 应用代码问题 ❌

#### 问题 A: 超时设置过短
原代码：
```dart
..setConnectTimeout(8000);  // 8秒
```
对于远程服务器，8秒连接超时可能不够，特别是在网络状况不佳时。

**已修复**：增加到 15 秒，并添加了发送/接收超时。

#### 问题 B: 错误信息不够详细
原代码只抛出简单的异常消息，缺少详细错误信息。

**已修复**：在异常消息中包含了原始错误详情。

#### 问题 C: 未检查目录是否已存在
在创建测试目录前没有检查是否已存在，可能导致重复创建失败。

**已修复**：添加了存在性检查。

## 已应用的修复

### 1. 增加超时时间
文件：`lib/service/sync/webdav_client.dart`

修改：
- 连接超时：8s → 15s
- 添加发送超时：30s
- 添加接收超时：30s

### 2. 改进错误处理
- 在 `mkdirAll` 方法中添加详细日志
- 在 `testFullCapabilities` 中改进错误消息
- 添加目录存在性检查

### 3. 添加详细日志
在关键操作点添加了日志记录，便于调试：
- 目录创建前后
- 文件上传下载
- 错误详情

## 测试建议

### 1. 重新编译应用
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### 2. 测试步骤
1. 在应用中填写 WebDAV 配置：
   - URL: `http://jcfy.dpdns.org:5050`
   - 用户名: `jinchenj`
   - 密码: `Jc@19940116`

2. 点击"测试连接"按钮

3. 查看日志输出（如果应用支持日志查看）：
   ```bash
   # Android
   adb logcat | grep -i "webdav\|anx"
   ```

### 3. 如果仍然失败

检查以下可能原因：

1. **网络安全策略**
   - Android 9+ 默认禁止 HTTP 明文传输
   - 解决：在 `android/app/src/main/AndroidManifest.xml` 中添加：
     ```xml
     <application
         android:usesCleartextTraffic="true"
         ...>
     ```

2. **DNS 解析**
   - `jcfy.dpdns.org` 是否能在设备上解析
   - 测试：在设备浏览器中访问该地址

3. **防火墙/端口**
   - 端口 5050 是否被设备网络阻止
   - 尝试在设备浏览器中访问：`http://jcfy.dpdns.org:5050/`

4. **查看详细日志**
   - 使用 Android Studio 的 Logcat
   - 过滤关键字：`WebDAV`、`mkdirAll`、`testFullCapabilities`

## 代码变更摘要

### lib/service/sync/webdav_client.dart

1. **第 30-46 行**：增加超时配置
2. **第 101-112 行**：改进目录创建逻辑
3. **第 183-193 行**：添加详细日志

### 下一步建议

如果问题仍然存在，建议：

1. 启用 debug 模式查看详细 HTTP 请求：
   ```dart
   _client = newClient(
     _config['url'],
     user: _config['username'],
     password: _config['password'],
     debug: true,  // 启用调试日志
   );
   ```

2. 抓包查看实际 HTTP 请求：
   - 使用 Charles 或 mitmproxy
   - 检查认证头是否正确
   - 检查请求路径是否正确

3. 尝试使用 HTTPS（如果服务器支持）：
   - 避免明文传输的安全限制
   - 更好的兼容性

## 相关文件

- WebDAV 客户端实现：`lib/service/sync/webdav_client.dart`
- 认证处理：`third_party/webdav_client/lib/src/auth.dart`
- HTTP 请求处理：`third_party/webdav_client/lib/src/webdav_dio.dart`
- 连接测试：`lib/service/sync/sync_connection_tester.dart`