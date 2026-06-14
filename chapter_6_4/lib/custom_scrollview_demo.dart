import 'package:flutter/material.dart';

// 应用入口

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CustomScrollViewDemo());
  }
}

/// 6.4 CustomScrollView 和 Slivers 演示
/// CustomScrollView 允许混合使用多种 Sliver 组件实现复杂滚动效果
class CustomScrollViewDemo extends StatelessWidget {
  const CustomScrollViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold 的 body 使用 CustomScrollView，免去嵌套滚动问题
      body: CustomScrollView(
        // slivers 数组可以包含多种 Sliver 组件
        slivers: [
          // 1. SliverAppBar：可折叠的应用栏
          SliverAppBar(
            // 展开时的高度
            expandedHeight: 180,
            // 是否固定（false=可折叠，true=始终展开）
            pinned: true,
            // 浮动效果：向下滚动时立刻出现
            floating: false,
            // 弹性空间：展开时显示的背景内容
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('6.4 CustomScrollView'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.view_carousel, size: 60, color: Colors.white54),
                ),
              ),
            ),
          ),

          // 2. SliverToBoxAdapter：将普通 Widget 转换为 Sliver
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'SliverList (懒加载列表)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 3. SliverFixedExtentList：固定高度的懒加载列表
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[index % Colors.primaries.length],
                    child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text('Sliver Item ${index + 1}'),
                  tileColor: index.isEven ? Colors.grey.shade50 : null,
                );
              },
              childCount: 15,
            ),
          ),

          // 4. SliverToBoxAdapter：分隔标题
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'SliverGrid (网格)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 5. SliverGrid：懒加载网格
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: Colors.primaries[(index + 5) % Colors.primaries.length],
                  alignment: Alignment.center,
                  child: Text(
                    'Grid $index',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
              childCount: 9,
            ),
          ),

          // 6. SliverToBoxAdapter：下一个标题
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'SliverPersistentHeader (吸顶标题)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 7. SliverPersistentHeader：滚动时吸顶的标题
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: Container(
                color: Colors.blue.shade100,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  '📌 这是一个吸顶的标题，滚动到顶部后会固定',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

          // 8. 更多列表内容
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: const Icon(Icons.article),
                  title: Text('文章 ${index + 1}'),
                  subtitle: Text('描述内容 ${index + 1}' * 3),
                );
              },
              childCount: 10,
            ),
          ),

          // 底部留白
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

/// 自定义 SliverPersistentHeaderDelegate
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  const _StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 48; // 完全展开时的高度

  @override
  double get minExtent => 48; // 吸顶后的最小高度（与 maxExtent 相同则固定不变）

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
