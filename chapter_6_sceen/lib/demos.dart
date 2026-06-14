import 'package:flutter/material.dart';
import 'pages.dart';

/// Demo 条目定义
class DemoEntry {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget page;
  const DemoEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.page,
  });
}

/// 第6章全部演示
final List<DemoEntry> chapter6Demos = [
  DemoEntry(
    title: '6.1 SingleChildScrollView',
    subtitle: '基础可滚动组件：垂直/水平滚动、physics、clipBehavior',
    icon: Icons.swipe_vertical,
    page: const SingleChildScrollViewDemoPage(),
  ),
  DemoEntry(
    title: '6.2 ListView',
    subtitle: '列表组件：默认构造、builder懒加载、separated分割线',
    icon: Icons.view_list,
    page: const ListViewDemoPage(),
  ),
  DemoEntry(
    title: '6.3 GridView',
    subtitle: '网格组件：count固定列数、extent自适应、builder懒加载',
    icon: Icons.grid_view,
    page: const GridViewDemoPage(),
  ),
  DemoEntry(
    title: '6.4 CustomScrollView + Slivers',
    subtitle: 'Sliver体系：折叠AppBar、吸顶标题、混合列表+网格',
    icon: Icons.dashboard_customize,
    page: const CustomScrollViewDemoPage(),
  ),
  DemoEntry(
    title: '6.5 ScrollController',
    subtitle: '滚动控制：监听偏移、animateTo滚动、回到顶部按钮',
    icon: Icons.tune,
    page: const ScrollControllerDemoPage(),
  ),
  DemoEntry(
    title: '6.6 AnimatedList',
    subtitle: '动画列表：插入/删除自动播放过渡动画',
    icon: Icons.animation,
    page: const AnimatedListDemoPage(),
  ),
  DemoEntry(
    title: '6.7 PageView',
    subtitle: '页面滑动：轮播效果、圆点指示器、PageController',
    icon: Icons.flip,
    page: const PageViewDemoPage(),
  ),
  DemoEntry(
    title: '6.8 TabBarView',
    subtitle: '标签页：TabBar+TabBarView切换5个标签页',
    icon: Icons.tab,
    page: const TabBarViewDemoPage(),
  ),
];
