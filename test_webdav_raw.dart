import 'package:webdav_client/webdav_client.dart';

void main() async {
  print('=== 直接测试 webdav_client 库 ===');

  final client = newClient(
    'http://jcfy.dpdns.org:5050',
    user: 'jinchenj',
    password: 'Jc@19940116',
    debug: true,
  );

  client.setHeaders({
    'accept-charset': 'utf-8',
    'Content-Type': 'application/octet-stream',
  });
  client.setConnectTimeout(8000);

  try {
    print('\n1. 测试 ping...');
    await client.ping();
    print('✓ Ping 成功');
  } catch (e) {
    print('✗ Ping 失败: $e');
  }

  try {
    print('\n2. 测试创建 /anx 目录...');
    await client.mkdirAll('/anx');
    print('✓ 创建 /anx 目录成功');
  } catch (e) {
    print('✗ 创建 /anx 目录失败: $e');
  }

  try {
    print('\n3. 测试创建 /anx/.test 目录...');
    await client.mkdirAll('/anx/.test');
    print('✓ 创建 /anx/.test 目录成功');
  } catch (e) {
    print('✗ 创建 /anx/.test 目录失败: $e');
  }

  print('\n=== 测试完成 ===');
}