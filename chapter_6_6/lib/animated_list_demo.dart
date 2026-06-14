import 'package:flutter/material.dart';

// 应用入口

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AnimatedListDemo());
  }
}

/// 6.6 AnimatedList 演示
/// AnimatedList 在列表项插入/删除时自动播放动画
class AnimatedListDemo extends StatefulWidget {
  const AnimatedListDemo({super.key});

  @override
  State<AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  // 数据源
  final List<int> _items = [0, 1, 2, 3, 4];
  // AnimatedList 的 GlobalKey
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  /// 在末尾添加一项
  void _addItem() {
    final index = _items.length;
    _items.add(index);
    // 插入动画
    _listKey.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 400),
    );
  }

  /// 移除最后一项
  void _removeItem() {
    if (_items.isEmpty) return;
    final index = _items.length - 1;
    final removedItem = _items.removeAt(index);
    // 删除动画
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        // 删除时的过渡动画：淡出 + 缩小
        return _buildRemovingItem(removedItem, animation);
      },
      duration: const Duration(milliseconds: 400),
    );
  }

  /// 在指定位置插入
  void _insertAt(int position) {
    final nextValue = _items.isEmpty ? 0 : _items.reduce((a, b) => a > b ? a : b) + 1;
    _items.insert(position, nextValue);
    _listKey.currentState?.insertItem(
      position,
      duration: const Duration(milliseconds: 400),
    );
  }

  /// 构建正常列表项
  Widget _buildItem(int item, {Animation<double>? animation}) {
    return SizeTransition(
      sizeFactor: animation ??
          const AlwaysStoppedAnimation(1.0), // 默认正常大小
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[item % Colors.primaries.length],
            child: Text('$item', style: const TextStyle(color: Colors.white)),
          ),
          title: Text('Animated Item $item'),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              final index = _items.indexOf(item);
              if (index != -1) {
                final removed = _items.removeAt(index);
                _listKey.currentState?.removeItem(
                  index,
                  (context, animation) => _buildRemovingItem(removed, animation),
                  duration: const Duration(milliseconds: 400),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  /// 构建删除时的过渡 Widget
  Widget _buildRemovingItem(int item, Animation<double> animation) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animation,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
        ),
        axisAlignment: -1.0,
        child: _buildItem(item, animation: const AlwaysStoppedAnimation(1.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('6.6 AnimatedList 动画列表'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
            tooltip: '末尾添加',
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _removeItem,
            tooltip: '末尾删除',
          ),
        ],
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_items[index], animation: animation);
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'addTop',
            onPressed: () => _insertAt(0),
            child: const Icon(Icons.playlist_add),
            tooltip: '在顶部插入',
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: 'addMid',
            onPressed: () => _insertAt(_items.length ~/ 2),
            child: const Icon(Icons.playlist_add_check),
            tooltip: '在中间插入',
          ),
        ],
      ),
    );
  }
}
