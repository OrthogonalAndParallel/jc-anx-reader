import 'package:anx_reader/service/sync/webdav_client.dart';
import 'package:anx_reader/utils/log/common.dart';

void main() async {
  AnxLog.init();

  final client = WebdavClient(
    url: 'http://jcfy.dpdns.org:5050',
    username: 'jinchenj',
    password: 'Jc@19940116',
  );

  print('=== 开始 WebDAV 连接测试 ===');

  try {
    print('\n1. 测试 ping...');
    await client.ping();
    print('✓ Ping 成功');
  } catch (e) {
    print('✗ Ping 失败: $e');
  }

  try {
    print('\n2. 测试完整功能...');
    await client.testFullCapabilities();
    print('✓ 完整功能测试成功');
  } catch (e) {
    print('✗ 完整功能测试失败: $e');
  }

  try {
    print('\n3. 测试创建 anx 目录...');
    await client.mkdirAll('anx');
    print('✓ 创建 anx 目录成功');
  } catch (e) {
    print('✗ 创建 anx 目录失败: $e');
  }

  try {
    print('\n4. 测试创建 anx/.test 目录...');
    await client.mkdirAll('anx/.test');
    print('✓ 创建 anx/.test 目录成功');
  } catch (e) {
    print('✗ 创建 anx/.test 目录失败: $e');
  }

  print('\n=== 测试完成 ===');
}