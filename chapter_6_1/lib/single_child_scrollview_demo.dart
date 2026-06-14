import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SingleChildScrollViewDemo());
  }
}

/// 6.1 SingleChildScrollView 演示
/// 当内容超过屏幕时，使用 SingleChildScrollView 包裹使其可滚动
class SingleChildScrollViewDemo extends StatelessWidget {
  const SingleChildScrollViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.1 SingleChildScrollView')),
      body: SingleChildScrollView(
        // 滚动方向：垂直 (默认)
        scrollDirection: Axis.vertical,
        // 反转滚动方向（内容从底部开始）
        reverse: false,
        // 内边距
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. 垂直滚动：放置大量子组件
            const Text('1. 垂直滚动 - 大量子组件', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...List.generate(
              3,
              (i) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                height: 80,
                color: Colors.primaries[i % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text('Item $i', style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),
            // 2. 水平滚动
            const Text('2. 水平滚动', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    10,
                    (i) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 80,
                      height: 80,
                      color: Colors.primaries[(i + 3) % Colors.primaries.length],
                      alignment: Alignment.center,
                      child: Text('H$i', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 3. physics 属性：控制滚动行为
            const Text('3. physics: BouncingScrollPhysics (弹性效果)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                // BouncingScrollPhysics 产生弹性效果 (iOS 风格)
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(
                    10,
                    (i) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text('$i', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 4. Clip 行为
            const Text('4. clipBehavior (默认裁剪超出边界的内容)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.hardEdge,
                child: Row(
                  children: List.generate(
                    8,
                    (i) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 60,
                      height: 60,
                      color: Colors.orange,
                      alignment: Alignment.center,
                      child: Text('C$i', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 5. 注意事项
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.yellow.shade50,
              child: const Text(
                '⚠️ 注意：SingleChildScrollView 会一次性构建所有子组件，\n'
                '不适合显示大量数据（性能较差）。\n'
                '大量数据应使用 ListView / GridView 等支持懒加载的组件。',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
