import 'package:flutter/material.dart';
import 'demos.dart';

void main() => runApp(const Chapter6Screen());

class Chapter6Screen extends StatelessWidget {
  const Chapter6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ch6 可滚动组件',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Chapter6Home(),
    );
  }
}

/// 汇总首页：列出所有子章节，点击进入演示
class Chapter6Home extends StatelessWidget {
  const Chapter6Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('第6章 可滚动组件 — 全部示例'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: chapter6Demos.length,
        separatorBuilder: (_, __) => const Divider(indent: 72),
        itemBuilder: (context, index) {
          final demo = chapter6Demos[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade50,
              child: Icon(demo.icon, color: Colors.deepPurple),
            ),
            title: Text(demo.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(demo.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => demo.page));
            },
          );
        },
      ),
    );
  }
}
