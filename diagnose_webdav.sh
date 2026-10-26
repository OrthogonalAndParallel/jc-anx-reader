#!/bin/bash

# WebDAV 连接诊断脚本

URL="https://dufs.jc-fn-pc.fnos.net"
USER="jinchenj"
PASS="Jc@19940116"

echo "========== WebDAV 诊断开始 =========="
echo "URL: $URL"
echo "用户: $USER"
echo ""

echo "1. 测试 OPTIONS 方法（检查 WebDAV 支持）"
curl -X OPTIONS -u "$USER:$PASS" "$URL/" -v 2>&1 | grep -E "HTTP/|Allow:|DAV:"
echo ""

echo "2. 测试根路径 PROPFIND（列出文件）"
curl -X PROPFIND -u "$USER:$PASS" "$URL/" -H "Depth: 1" -H "Content-Type: application/xml" --data '<?xml version="1.0"?><d:propfind xmlns:d="DAV:"><d:prop></d:prop></d:propfind>' 2>&1 | head -20
echo ""

echo "3. 尝试在根路径创建测试目录"
curl -X MKCOL -u "$USER:$PASS" "$URL/anx_test/" -v 2>&1 | grep "HTTP/"
echo ""

echo "4. 测试常见的 WebDAV 路径"
for path in "/dav" "/webdav" "/files" "/home" "/public"; do
    echo "测试路径: $path"
    curl -X PROPFIND -u "$USER:$PASS" "$URL$path/" -H "Depth: 0" 2>&1 | grep "HTTP/"
done
echo ""

echo "========== 诊断完成 =========="