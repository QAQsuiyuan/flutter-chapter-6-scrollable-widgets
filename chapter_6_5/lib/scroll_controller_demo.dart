import 'package:flutter/material.dart';

// 应用入口

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ScrollControllerDemo());
  }
}

/// 6.5 ScrollController 演示
/// 使用 ScrollController 监听和控制滚动位置
class ScrollControllerDemo extends StatefulWidget {
  const ScrollControllerDemo({super.key});

  @override
  State<ScrollControllerDemo> createState() => _ScrollControllerDemoState();
}

class _ScrollControllerDemoState extends State<ScrollControllerDemo> {
  // 创建 ScrollController
  final ScrollController _controller = ScrollController();

  // 状态变量
  double _scrollOffset = 0.0;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    // 1. 监听滚动位置变化
    _controller.addListener(() {
      setState(() {
        _scrollOffset = _controller.offset;
        // 滚动超过 300px 时显示"回到顶部"按钮
        _showBackToTop = _controller.offset > 300;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('6.5 ScrollController 滚动控制'),
        // 在 AppBar 底部显示滚动进度条
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: _controller.hasClients
                ? (_controller.offset / (_controller.position.maxScrollExtent + 1))
                    .clamp(0.0, 1.0)
                : 0,
          ),
        ),
      ),
      body: Column(
        children: [
          // 状态指示面板
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  const Text('滚动偏移', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('${_scrollOffset.toStringAsFixed(1)} px', style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
                Column(children: [
                  const Text('最大滚动', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('${_controller.hasClients ? _controller.position.maxScrollExtent.toStringAsFixed(1) : '...'} px', style: const TextStyle(fontWeight: FontWeight.bold)),
                ]),
                ElevatedButton(
                  onPressed: () {
                    // 2. animateTo：带动画滚动到指定位置
                    if (_controller.hasClients) {
                      _controller.animateTo(
                        _controller.offset + 200,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text('下滑 200px'),
                ),
              ],
            ),
          ),

          // 可滚动内容
          Expanded(
            child: ListView.builder(
              controller: _controller, // 关联控制器
              itemCount: 50,
              itemBuilder: (context, index) {
                return Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: index == 25 ? Colors.yellow.shade200 : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Item ${index + 1}${index == 25 ? " ★ 中点" : ""}',
                    style: TextStyle(
                      fontWeight: index == 25 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // 回到顶部按钮
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              onPressed: () {
                // 3. jumpTo：瞬间跳转到指定位置
                _controller.jumpTo(0);
              },
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}
