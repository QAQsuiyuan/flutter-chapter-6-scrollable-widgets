import 'package:flutter/material.dart';

// 应用入口

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: GridViewDemo());
  }
}

/// 6.3 GridView 演示
/// GridView 以二维网格的形式展示可滚动内容
class GridViewDemo extends StatelessWidget {
  const GridViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.3 GridView 网格组件')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. GridView.count（指定列数）
            const Text('1. GridView.count (固定列数 = 3)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: GridView.count(
                crossAxisCount: 3, // 3 列
                mainAxisSpacing: 4, // 行间距
                crossAxisSpacing: 4, // 列间距
                childAspectRatio: 1.0, // 宽高比 1:1 (正方形)
                children: List.generate(
                  6,
                  (i) => Container(
                    color: Colors.primaries[i % Colors.primaries.length],
                    alignment: Alignment.center,
                    child: Text('$i', style: const TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. GridView.extent（指定最大宽度）
            const Text('2. GridView.extent (每项最大宽度 100)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: GridView.extent(
                maxCrossAxisExtent: 100, // 每个子项最大宽度 100px，自动计算列数
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  8,
                  (i) => Container(
                    color: Colors.blue.shade300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.star, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. GridView.builder（懒加载，适合大量数据）
            const Text('3. GridView.builder (懒加载，适合大量数据)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1.2,
                ),
                itemCount: 40,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.green.shade200 : Colors.green.shade500,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 4. SliverGridDelegateWithMaxCrossAxisExtent
            const Text('4. GridView.builder + maxCrossAxisExtent', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 80, // 自适应列数
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1.0,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.orange.shade300,
                    alignment: Alignment.center,
                    child: Text('G$index', style: const TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
