import 'package:flutter/material.dart';

// 应用入口

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ListViewDemo());
  }
}

/// 6.2 ListView 演示
/// ListView 是最常用的可滚动组件，支持懒加载
class ListViewDemo extends StatelessWidget {
  const ListViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.2 ListView 列表组件')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. ListView 默认构造函数（适合少量子组件）
          const Text('1. ListView 默认构造函数', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                5,
                (i) => Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 100,
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: Text('Box $i', style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 2. ListView.builder（适合大量或动态数据，懒加载）
          const Text('2. ListView.builder (懒加载)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView.builder(
              // 指定列表项数量
              itemCount: 20,
              // itemExtent 指定固定高度，提高性能
              itemExtent: 40,
              // 构建每个列表项
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Item ${index + 1}'),
                  tileColor: index.isEven ? Colors.grey.shade100 : null,
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // 3. ListView.separated（带分割线）
          const Text('3. ListView.separated (带分割线)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('用户 ${index + 1}'),
                  subtitle: Text('user_${index + 1}@example.com'),
                  trailing: const Icon(Icons.chevron_right),
                );
              },
              // 分割线构建器
              separatorBuilder: (context, index) => const Divider(height: 1),
            ),
          ),
          const SizedBox(height: 20),

          // 4. 水平方向 ListView.builder
          const Text('4. 水平方向 ListView', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.amber.shade700, size: 30),
                        Text('No.${index + 1}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // 5. 注意事项
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.yellow.shade50,
            child: const Text(
              '💡 提示：\n'
              '• ListView.builder 按需构建可见项 → 适合长列表\n'
              '• itemExtent 指定固定高度 → 提升滚动性能\n'
              '• ListView.separated → 自动在项之间插入分割线\n'
              '• 添加在 Column 中需指定高度或使用 Expanded',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
