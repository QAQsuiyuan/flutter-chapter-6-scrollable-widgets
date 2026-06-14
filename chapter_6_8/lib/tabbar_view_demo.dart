import 'package:flutter/material.dart';

// 应用入口

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TabBarViewDemo());
  }
}

/// 6.8 TabBarView 演示
/// TabBar + TabBarView 实现标签页切换
class TabBarViewDemo extends StatefulWidget {
  const TabBarViewDemo({super.key});

  @override
  State<TabBarViewDemo> createState() => _TabBarViewDemoState();
}

class _TabBarViewDemoState extends State<TabBarViewDemo> with SingleTickerProviderStateMixin {
  // TabController 管理 Tab 切换
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5, // Tab 数量
      vsync: this,
      initialIndex: 0, // 初始选中的 Tab
    );
    _tabController.addListener(() {
      setState(() {}); // Tab 切换时刷新
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('6.8 TabBarView 标签页'),
        // TabBar 放在 AppBar 底部
        bottom: TabBar(
          controller: _tabController,
          // 可滚动的 TabBar（Tab 过多时）
          isScrollable: true,
          // Tab 标签
          tabs: const [
            Tab(icon: Icon(Icons.home), text: '首页'),
            Tab(icon: Icon(Icons.explore), text: '发现'),
            Tab(icon: Icon(Icons.favorite), text: '收藏'),
            Tab(icon: Icon(Icons.person), text: '我的'),
            Tab(icon: Icon(Icons.settings), text: '设置'),
          ],
          // 指示器颜色
          indicatorColor: Colors.white,
          // 指示器重量
          indicatorWeight: 3,
          // 标签颜色
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: 首页 - ListView
          _buildTabPage(
            '首页',
            Icons.home,
            Colors.blue,
            ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.article)),
                title: Text('热门文章 ${index + 1}'),
                subtitle: Text('这是第 ${index + 1} 篇文章的摘要内容...'),
              ),
            ),
          ),

          // Tab 2: 发现 - GridView
          _buildTabPage(
            '发现',
            Icons.explore,
            Colors.teal,
            GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 12,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.category, color: Colors.teal.shade400, size: 40),
                    Text('分类 ${index + 1}'),
                  ],
                ),
              ),
            ),
          ),

          // Tab 3: 收藏
          _buildTabPage(
            '收藏',
            Icons.favorite,
            Colors.red,
            ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.favorite, color: Colors.red.shade300),
                title: Text('收藏项 ${index + 1}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),

          // Tab 4: 我的
          _buildTabPage(
            '我的',
            Icons.person,
            Colors.deepPurple,
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)),
                const SizedBox(height: 16),
                const ListTile(leading: Icon(Icons.account_circle), title: Text('用户名')),
                const Divider(),
                const ListTile(leading: Icon(Icons.email), title: Text('user@example.com')),
                const Divider(),
                const ListTile(leading: Icon(Icons.phone), title: Text('138****8888')),
                const Divider(),
                ElevatedButton(onPressed: () {}, child: const Text('编辑资料')),
              ],
            ),
          ),

          // Tab 5: 设置
          _buildTabPage(
            '设置',
            Icons.settings,
            Colors.grey,
            ListView(
              children: [
                SwitchListTile(
                  title: const Text('通知'),
                  subtitle: const Text('接收推送通知'),
                  value: true,
                  onChanged: (val) {},
                  secondary: const Icon(Icons.notifications),
                ),
                SwitchListTile(
                  title: const Text('深色模式'),
                  subtitle: const Text('使用深色主题'),
                  value: false,
                  onChanged: (val) {},
                  secondary: const Icon(Icons.dark_mode),
                ),
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('关于'),
                  trailing: Text('v1.0.0'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPage(String title, IconData icon, MaterialColor color, Widget child) {
    return child;
  }
}
