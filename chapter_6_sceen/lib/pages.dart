import 'package:flutter/material.dart';

// ============================================================
// 6.1 SingleChildScrollView
// ============================================================
class SingleChildScrollViewDemoPage extends StatelessWidget {
  const SingleChildScrollViewDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.1 SingleChildScrollView')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 垂直滚动
            const Text('垂直滚动', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...List.generate(5, (i) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              height: 60,
              color: Colors.primaries[i % Colors.primaries.length],
              alignment: Alignment.center,
              child: Text('Item $i', style: const TextStyle(color: Colors.white, fontSize: 16)),
            )),
            const SizedBox(height: 16),
            // 水平滚动
            const Text('水平滚动', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(12, (i) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 70,
                    height: 70,
                    color: Colors.teal.shade300,
                    alignment: Alignment.center,
                    child: Text('H$i', style: const TextStyle(color: Colors.white)),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // BouncingScrollPhysics
            const Text('BouncingScrollPhysics (iOS 弹性)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(15, (i) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 44, height: 44,
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(22)),
                    alignment: Alignment.center,
                    child: Text('$i', style: const TextStyle(color: Colors.white)),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.yellow.shade50,
              child: const Text('⚠️ SingleChildScrollView 一次性构建所有子组件，大量数据应使用 ListView/GridView。', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 6.2 ListView
// ============================================================
class ListViewDemoPage extends StatelessWidget {
  const ListViewDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.2 ListView')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('1. 默认构造（水平）', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(5, (i) => Container(
                margin: const EdgeInsets.only(right: 8), width: 100,
                color: Colors.primaries[i % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text('Box $i', style: const TextStyle(color: Colors.white)),
              )),
            ),
          ),
          const SizedBox(height: 20),
          const Text('2. builder 懒加载', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: 30, itemExtent: 40,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text('Item ${i + 1}'),
                tileColor: i.isEven ? Colors.grey.shade100 : null,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('3. separated 带分割线', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (ctx, i) => ListTile(
                leading: const Icon(Icons.person),
                title: Text('用户 ${i + 1}'),
                subtitle: Text('user_${i + 1}@example.com'),
              ),
              separatorBuilder: (_, __) => const Divider(height: 1),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12), color: Colors.yellow.shade50,
            child: const Text('💡 builder 按需构建可见项→适合长列表；separated 自动插入分割线', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 6.3 GridView
// ============================================================
class GridViewDemoPage extends StatelessWidget {
  const GridViewDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.3 GridView')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('1. count (3列)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: GridView.count(
                crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4,
                children: List.generate(6, (i) => Container(
                  color: Colors.primaries[i % Colors.primaries.length],
                  alignment: Alignment.center,
                  child: Text('$i', style: const TextStyle(color: Colors.white, fontSize: 18)),
                )),
              ),
            ),
            const SizedBox(height: 20),
            const Text('2. extent (每项最大100px)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: GridView.extent(
                maxCrossAxisExtent: 100, mainAxisSpacing: 4, crossAxisSpacing: 4,
                children: List.generate(8, (_) => Container(color: Colors.teal.shade300, alignment: Alignment.center, child: const Icon(Icons.star, color: Colors.white))),
              ),
            ),
            const SizedBox(height: 20),
            const Text('3. builder 懒加载 (40项)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 4, crossAxisSpacing: 4, childAspectRatio: 1.2,
                ),
                itemCount: 40,
                itemBuilder: (ctx, i) => Container(
                  decoration: BoxDecoration(color: i.isEven ? Colors.green.shade200 : Colors.green.shade500, borderRadius: BorderRadius.circular(4)),
                  alignment: Alignment.center,
                  child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 6.4 CustomScrollView + Slivers
// ============================================================
class CustomScrollViewDemoPage extends StatelessWidget {
  const CustomScrollViewDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 可折叠 AppBar
          SliverAppBar(
            expandedHeight: 160, pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('6.4 CustomScrollView'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.deepPurple, Colors.blue], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: const Center(child: Icon(Icons.view_carousel, size: 50, color: Colors.white54)),
              ),
            ),
          ),
          // 说明文本
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SliverFixedExtentList:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('下面是固定 50px 高度的 Sliver 列表', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8), color: Colors.yellow.shade50,
                    child: const Text('⬆️ 向上滚动查看 SliverAppBar 折叠效果', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
          // SliverFixedExtentList
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => ListTile(
                leading: CircleAvatar(backgroundColor: Colors.primaries[i % Colors.primaries.length], child: Text('${i + 1}', style: const TextStyle(color: Colors.white))),
                title: Text('Sliver Item ${i + 1}'),
                tileColor: i.isEven ? Colors.grey.shade50 : null,
              ),
              childCount: 15,
            ),
          ),
          // SliverGrid 标题
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('SliverGrid (3列):', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          // SliverGrid
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 4, crossAxisSpacing: 4, childAspectRatio: 1.5),
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => Container(
                color: Colors.primaries[(i + 5) % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text('G$i', style: const TextStyle(color: Colors.white)),
              ),
              childCount: 9,
            ),
          ),
          // 吸顶标题
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: Container(color: Colors.blue.shade100, alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text('📌 吸顶标题 — 滚动到顶部后固定', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          // 更多列表
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => ListTile(leading: const Icon(Icons.article), title: Text('文章 ${i + 1}'), subtitle: Text('描述内容 ${i + 1}' * 3)),
              childCount: 10,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _StickyHeaderDelegate({required this.child});
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;
  @override double get maxExtent => 48;
  @override double get minExtent => 48;
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// ============================================================
// 6.5 ScrollController
// ============================================================
class ScrollControllerDemoPage extends StatefulWidget {
  const ScrollControllerDemoPage({super.key});
  @override State<ScrollControllerDemoPage> createState() => _ScrollControllerDemoPageState();
}

class _ScrollControllerDemoPageState extends State<ScrollControllerDemoPage> {
  final ScrollController _controller = ScrollController();
  double _offset = 0;
  bool _showBtn = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() { _offset = _controller.offset; _showBtn = _offset > 300; }));
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('6.5 ScrollController'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: _controller.hasClients ? (_controller.offset / (_controller.position.maxScrollExtent + 1)).clamp(0.0, 1.0) : 0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(padding: const EdgeInsets.all(12), color: Colors.grey.shade100,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Column(children: [const Text('偏移', style: TextStyle(fontSize: 12)), Text('${_offset.toStringAsFixed(1)} px', style: const TextStyle(fontWeight: FontWeight.bold))]),
              Column(children: [const Text('最大滚动', style: TextStyle(fontSize: 12)), Text('${_controller.hasClients ? _controller.position.maxScrollExtent.toStringAsFixed(0) : "..."} px', style: const TextStyle(fontWeight: FontWeight.bold))]),
              ElevatedButton(onPressed: () { if (_controller.hasClients) _controller.animateTo(_controller.offset + 200, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut); }, child: const Text('下滑200px')),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller, itemCount: 50,
              itemBuilder: (ctx, i) => Container(
                height: 60, margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(color: i == 25 ? Colors.yellow.shade200 : Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text('Item ${i + 1}${i == 25 ? " ★" : ""}'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showBtn ? FloatingActionButton(onPressed: () => _controller.jumpTo(0), child: const Icon(Icons.arrow_upward)) : null,
    );
  }
}

// ============================================================
// 6.6 AnimatedList
// ============================================================
class AnimatedListDemoPage extends StatefulWidget {
  const AnimatedListDemoPage({super.key});
  @override State<AnimatedListDemoPage> createState() => _AnimatedListDemoPageState();
}

class _AnimatedListDemoPageState extends State<AnimatedListDemoPage> {
  final List<int> _items = [0, 1, 2, 3, 4];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _add() { final i = _items.length; _items.add(i); _key.currentState?.insertItem(i, duration: const Duration(milliseconds: 400)); }
  void _remove() { if (_items.isEmpty) return; final i = _items.length - 1; final removed = _items.removeAt(i); _key.currentState?.removeItem(i, (ctx, a) => _removingItem(removed, a), duration: const Duration(milliseconds: 400)); }

  Widget _removingItem(int item, Animation<double> a) => FadeTransition(
    opacity: CurvedAnimation(parent: a, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    child: SizeTransition(sizeFactor: CurvedAnimation(parent: a, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)), axisAlignment: -1.0, child: _item(item)),
  );

  Widget _item(int item) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: ListTile(
      leading: CircleAvatar(backgroundColor: Colors.primaries[item % Colors.primaries.length], child: Text('$item', style: const TextStyle(color: Colors.white))),
      title: Text('Animated Item $item'),
      trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () { final idx = _items.indexOf(item); if (idx != -1) { final r = _items.removeAt(idx); _key.currentState?.removeItem(idx, (ctx, a) => _removingItem(r, a), duration: const Duration(milliseconds: 400)); } }),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.6 AnimatedList'), actions: [
        IconButton(icon: const Icon(Icons.add), onPressed: _add),
        IconButton(icon: const Icon(Icons.remove), onPressed: _remove),
      ]),
      body: AnimatedList(key: _key, initialItemCount: _items.length, itemBuilder: (ctx, i, a) => SizeTransition(sizeFactor: a, child: _item(_items[i]))),
    );
  }
}

// ============================================================
// 6.7 PageView
// ============================================================
class PageViewDemoPage extends StatefulWidget {
  const PageViewDemoPage({super.key});
  @override State<PageViewDemoPage> createState() => _PageViewDemoPageState();
}

class _PageViewDemoPageState extends State<PageViewDemoPage> {
  final _controller = PageController();
  int _current = 0;
  final _pages = [
    {'title': 'Flutter', 'color': Colors.blue, 'icon': Icons.flutter_dash, 'desc': 'Google 开源 UI 框架'},
    {'title': 'Dart', 'color': Colors.teal, 'icon': Icons.code, 'desc': 'Flutter 的编程语言'},
    {'title': 'Widget', 'color': Colors.orange, 'icon': Icons.widgets, 'desc': '一切皆 Widget'},
    {'title': 'Hot Reload', 'color': Colors.purple, 'icon': Icons.refresh, 'desc': '秒级看到效果'},
    {'title': '跨平台', 'color': Colors.red, 'icon': Icons.phone_android, 'desc': '一套代码多端运行'},
  ];

  @override void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('6.7 PageView')),
      body: Column(children: [
        Expanded(
          child: PageView.builder(
            controller: _controller, itemCount: _pages.length, onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (ctx, i) {
              final p = _pages[i];
              return Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [(p['color']! as MaterialColor).shade300, (p['color']! as MaterialColor).shade700]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(p['icon']! as IconData, size: 64, color: Colors.white70),
                  const SizedBox(height: 16),
                  Text(p['title']! as String, style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(p['desc']! as String, style: const TextStyle(fontSize: 16, color: Colors.white70)),
                  const SizedBox(height: 16),
                  Text('${i + 1} / ${_pages.length}', style: const TextStyle(color: Colors.white54)),
                ]),
              );
            },
          ),
        ),
        // 圆点指示器
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(onPressed: _current > 0 ? () => _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut) : null, icon: const Icon(Icons.chevron_left)),
            ...List.generate(_pages.length, (i) => GestureDetector(
              onTap: () => _controller.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _current == i ? 12 : 8, height: _current == i ? 12 : 8,
                decoration: BoxDecoration(shape: BoxShape.circle, color: _current == i ? Theme.of(context).primaryColor : Colors.grey.shade300),
              ),
            )),
            IconButton(onPressed: _current < _pages.length - 1 ? () => _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut) : null, icon: const Icon(Icons.chevron_right)),
          ]),
        ),
      ]),
    );
  }
}

// ============================================================
// 6.8 TabBarView
// ============================================================
class TabBarViewDemoPage extends StatefulWidget {
  const TabBarViewDemoPage({super.key});
  @override State<TabBarViewDemoPage> createState() => _TabBarViewDemoPageState();
}

class _TabBarViewDemoPageState extends State<TabBarViewDemoPage> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 5, vsync: this);

  @override void dispose() { _tabController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('6.8 TabBarView'),
        bottom: TabBar(
          controller: _tabController, isScrollable: true, indicatorColor: Colors.white,
          labelColor: Colors.white, unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: '首页'),
            Tab(icon: Icon(Icons.explore), text: '发现'),
            Tab(icon: Icon(Icons.favorite), text: '收藏'),
            Tab(icon: Icon(Icons.person), text: '我的'),
            Tab(icon: Icon(Icons.settings), text: '设置'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(itemCount: 15, itemBuilder: (ctx, i) => ListTile(leading: const CircleAvatar(child: Icon(Icons.article)), title: Text('热门文章 ${i + 1}'), subtitle: Text('第 ${i + 1} 篇文章摘要...'))),
          GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8), itemCount: 12, itemBuilder: (ctx, i) => Container(decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(8)), alignment: Alignment.center, child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.category, color: Colors.teal.shade400, size: 40), Text('分类${i + 1}')]))),
          ListView.builder(itemCount: 8, itemBuilder: (ctx, i) => ListTile(leading: Icon(Icons.favorite, color: Colors.red.shade300), title: Text('收藏项 ${i + 1}'))),
          const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)), SizedBox(height: 16), Text('用户名', style: TextStyle(fontSize: 18))])),
          ListView(children: [SwitchListTile(title: const Text('通知'), value: true, onChanged: (_) {}, secondary: const Icon(Icons.notifications)), SwitchListTile(title: const Text('深色模式'), value: false, onChanged: (_) {}, secondary: const Icon(Icons.dark_mode)), const ListTile(leading: Icon(Icons.info), title: Text('关于'), trailing: Text('v1.0.0'))]),
        ],
      ),
    );
  }
}
