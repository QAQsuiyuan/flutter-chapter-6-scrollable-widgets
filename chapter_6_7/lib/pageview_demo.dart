import 'package:flutter/material.dart';

// 应用入口

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PageViewDemo());
  }
}

/// 6.7 PageView 与页面缓存演示
/// PageView 实现页面滑动切换效果
class PageViewDemo extends StatefulWidget {
  const PageViewDemo({super.key});

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 页面数据
  final List<Map<String, dynamic>> _pages = [
    {'title': 'Flutter 页面 1', 'color': Colors.blue, 'icon': Icons.flutter_dash, 'desc': 'Flutter 是 Google 的开源 UI 框架'},
    {'title': 'Dart 页面 2', 'color': Colors.teal, 'icon': Icons.code, 'desc': 'Dart 是 Flutter 的编程语言'},
    {'title': 'Widget 页面 3', 'color': Colors.orange, 'icon': Icons.widgets, 'desc': '一切皆 Widget'},
    {'title': 'Hot Reload 页面 4', 'color': Colors.purple, 'icon': Icons.refresh, 'desc': '热重载，秒级看到效果'},
    {'title': '跨平台 页面 5', 'color': Colors.red, 'icon': Icons.phone_android, 'desc': '一套代码，多端运行'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.7 PageView 页面滑动')),
      body: Column(
        children: [
          // PageView 主区域
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (page['color'] as MaterialColor).shade300,
                        (page['color'] as MaterialColor).shade700,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(page['icon'] as IconData, size: 80, color: Colors.white70),
                      const SizedBox(height: 16),
                      Text(
                        page['title'] as String,
                        style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        page['desc'] as String,
                        style: const TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '${index + 1} / ${_pages.length}',
                        style: const TextStyle(fontSize: 14, color: Colors.white54),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 页面指示器（圆点）
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 上一页按钮
                IconButton(
                  onPressed: _currentPage > 0
                      ? () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                // 圆点指示器
                ...List.generate(_pages.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey.shade300,
                      ),
                    ),
                  );
                }),
                // 下一页按钮
                IconButton(
                  onPressed: _currentPage < _pages.length - 1
                      ? () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),

          // KeepAlive 说明
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.yellow.shade50,
            child: const Text(
              '💡 PageView 默认只缓存当前页和相邻页。\n'
              '如需缓存其他页面，使用 AutomaticKeepAliveClientMixin\n'
              '或设置 PageView 的 allowImplicitScrolling: true',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
