# 第6章：可滚动组件 (Scrollable Widgets)

Flutter 可滚动组件的完整示例集合，涵盖 `SingleChildScrollView` → `ListView` → `GridView` → `CustomScrollView`（Sliver 体系） → `ScrollController` → `AnimatedList` → `PageView` → `TabBarView`。

---

## 目录导航汇总页

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-224934.png" width="320" alt="Chapter 6 Home">
</p>

---

## 6.1 SingleChildScrollView — 基础滚动

将**单个子组件**变为可滚动。适用于内容略超屏幕、子组件数量不多的场景。

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-224934.png" width="320" alt="6.1 SingleChildScrollView">
</p>

**核心代码** → [chapter_6_1/lib/single_child_scrollview_demo.dart](chapter_6_1/lib/single_child_scrollview_demo.dart)

```dart
SingleChildScrollView(
  scrollDirection: Axis.vertical,    // 默认垂直；水平用 Axis.horizontal
  reverse: false,                    // 是否反转（内容从底部开始）
  padding: EdgeInsets.all(16),
  physics: BouncingScrollPhysics(),  // iOS 风格弹性效果
  child: Column(children: [...]),    // 一次性构建所有子组件
)
```

> ⚠️ **注意**：SingleChildScrollView 一次性构建所有子组件，不适合大量数据。大量数据应使用 ListView / GridView。

---

## 6.2 ListView — 列表懒加载

最常用的可滚动组件，支持**按需构建**（懒加载），适合长列表场景。

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-224953.png" width="320" alt="6.2 ListView">
</p>

**核心代码** → [chapter_6_2/lib/listview_demo.dart](chapter_6_2/lib/listview_demo.dart)

```dart
// ① 默认构造：少量固定子组件
ListView(
  scrollDirection: Axis.horizontal,
  children: [Container(...), Container(...)],
)

// ② builder 懒加载：大量/动态数据 → 只构建可见项
ListView.builder(
  itemCount: 20,
  itemExtent: 40,           // 固定高度 → 提升滚动性能
  itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
)

// ③ separated 带分割线
ListView.separated(
  itemCount: 10,
  itemBuilder: (ctx, i) => ListTile(title: Text('用户 $i')),
  separatorBuilder: (_, __) => Divider(height: 1),
)
```

> 💡 `itemExtent` 指定固定高度可大幅提升滚动性能（Flutter 无需测量每个子项即可计算滚动范围）。

---

## 6.3 GridView — 二维网格

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-225001.png" width="320" alt="6.3 GridView">
</p>

**核心代码** → [chapter_6_3/lib/gridview_demo.dart](chapter_6_3/lib/gridview_demo.dart)

```dart
// ① count：指定列数
GridView.count(
  crossAxisCount: 3,              // 固定 3 列
  mainAxisSpacing: 4,             // 行间距
  crossAxisSpacing: 4,            // 列间距
  childAspectRatio: 1.0,          // 宽高比
  children: [Container(...), ...],
)

// ② extent：指定每项最大宽度，自动计算列数
GridView.extent(
  maxCrossAxisExtent: 100,        // 每项最大 100px
  children: [...],
)

// ③ builder 懒加载：大量数据
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
  ),
  itemCount: 40,
  itemBuilder: (ctx, i) => Container(...),
)
```

> 💡 `SliverGridDelegateWithFixedCrossAxisCount` = 固定列数；`SliverGridDelegateWithMaxCrossAxisExtent` = 自适应列数。

---

## 6.4 CustomScrollView + Slivers — 复杂滚动效果

Sliver 体系的核心：**统一滑动边界内混合多种 Sliver 组件**。

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-225009.png" width="320" alt="6.4 CustomScrollView">
</p>

**核心代码** → [chapter_6_4/lib/custom_scrollview_demo.dart](chapter_6_4/lib/custom_scrollview_demo.dart)

```dart
CustomScrollView(
  slivers: [
    // 可折叠 AppBar
    SliverAppBar(
      expandedHeight: 180, pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('CustomScrollView'),
        background: Gradient Container(...),
      ),
    ),
    // 普通 Widget 转 Sliver
    SliverToBoxAdapter(child: Padding(...)),
    // 固定高度懒加载列表
    SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (ctx, i) => ListTile(...), childCount: 15,
      ),
    ),
    // Sliver 网格
    SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(...),
      delegate: SliverChildBuilderDelegate(...),
    ),
    // 吸顶标题
    SliverPersistentHeader(
      pinned: true,
      delegate: _StickyHeaderDelegate(child: Container(...)),
    ),
    // 普通过渡列表
    SliverList(
      delegate: SliverChildBuilderDelegate(...),
    ),
  ],
)
```

### Sliver 组件一览

| Sliver 组件 | 用途 |
|---|---|
| `SliverAppBar` | 可折叠 / 吸顶的应用栏 |
| `SliverList` | 懒加载列表 |
| `SliverFixedExtentList` | 固定高度的懒加载列表（性能最优） |
| `SliverGrid` | 懒加载网格 |
| `SliverToBoxAdapter` | 将普通 Widget 嵌入 Sliver |
| `SliverPersistentHeader` | 可吸顶或随滚动消失的头部 |
| `SliverFillRemaining` | 填充剩余视口空间 |

---

## 6.5 ScrollController — 滚动控制与监听

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-225019.png" width="320" alt="6.5 ScrollController">
</p>

**核心代码** → [chapter_6_5/lib/scroll_controller_demo.dart](chapter_6_5/lib/scroll_controller_demo.dart)

```dart
final _controller = ScrollController();

// 初始化时添加监听
_controller.addListener(() {
  setState(() => _offset = _controller.offset);  // 获取当前滚动位置
});

// 程序化控制滚动
_controller.animateTo(offset, duration: ..., curve: ...);  // 带动画
_controller.jumpTo(0);                                      // 直接跳转

// 获取滚动范围
_controller.position.maxScrollExtent   // 最大可滚动距离
_controller.position.pixels            // 当前滚动像素

// ⚠️ 必须在 dispose 中释放
_controller.dispose();
```

> 💡 AppBar 下方挂载 `LinearProgressIndicator` 实现阅读进度条是 ScrollController 的经典应用。

---

## 6.6 AnimatedList — 带动画的列表增删

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-225028.png" width="320" alt="6.6 AnimatedList">
</p>

**核心代码** → [chapter_6_6/lib/animated_list_demo.dart](chapter_6_6/lib/animated_list_demo.dart)

```dart
final GlobalKey<AnimatedListState> _key = GlobalKey();

AnimatedList(
  key: _key,
  initialItemCount: _items.length,
  itemBuilder: (ctx, i, animation) => SizeTransition(
    sizeFactor: animation,           // 插入时的动画
    child: _buildItem(_items[i]),
  ),
)

// 插入（带动画）
_items.add(newItem);
_key.currentState!.insertItem(index);

// 删除（带动画）
_items.removeAt(index);
_key.currentState!.removeItem(index, (ctx, animation) {
  return FadeTransition(opacity: ..., child: SizeTransition(...));
});
```

> 💡 核心模式：数据先行操作数组 → 再调用 `AnimatedListState` 方法驱动动画。

---

## 6.7 PageView — 页面滑动

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-225037.png" width="320" alt="6.7 PageView">
</p>

**核心代码** → [chapter_6_7/lib/pageview_demo.dart](chapter_6_7/lib/pageview_demo.dart)

```dart
final _controller = PageController();
int _current = 0;

PageView.builder(
  controller: _controller,
  itemCount: pages.length,
  onPageChanged: (i) => setState(() => _current = i),
  itemBuilder: (ctx, i) => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(...),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(...),
  ),
)

// 程序化翻页
_controller.animateToPage(i, duration: ..., curve: ...);
_controller.nextPage(...);
_controller.previousPage(...);
```

> 💡 配合圆点指示器（`Row` + `GestureDetector`）实现轮播图效果。

---

## 6.8 TabBarView — 选项卡视图

<p align="center">
  <img src="../chapter_6_sceen/QQ20260614-225054.png" width="320" alt="6.8 TabBarView">
</p>

**核心代码** → [chapter_6_8/lib/tabbar_view_demo.dart](chapter_6_8/lib/tabbar_view_demo.dart)

```dart
// State 需混入 SingleTickerProviderStateMixin
final _tabController = TabController(length: 5, vsync: this);

Scaffold(
  appBar: AppBar(
    bottom: TabBar(
      controller: _tabController,
      isScrollable: true,          // 可滚动（标签多为 true）
      tabs: [
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
      ListView.builder(...),  // 首页内容：长列表
      GridView.builder(...),  // 发现内容：网格
      ListView.builder(...),  // 收藏内容
      Center(child: ...),     // 个人中心
      ListView(...),           // 设置
    ],
  ),
)
```

> 💡 `TabController` + `TabBar` + `TabBarView` 三件套；每个 tab 页面独立构建，切换时无需重建全部内容。

---

## 核心知识进阶路线

```
SingleChildScrollView (基础)
    │
    ├─→ ListView (builder/separated)   → 懒加载、高性能长列表
    ├─→ GridView (count/extent/builder) → 二维网格
    │
    ├─→ CustomScrollView + Slivers     → 统一滑动边界的混合布局
    │     ├─ SliverAppBar (折叠头)
    │     ├─ SliverList / SliverFixedExtentList
    │     ├─ SliverGrid
    │     ├─ SliverPersistentHeader (吸顶)
    │     └─ SliverToBoxAdapter (普通Widget转Sliver)
    │
    ├─→ ScrollController               → 监听/控制滚动位置
    ├─→ AnimatedList                    → 列表项动画插入/删除
    ├─→ PageView                        → 整页滑动（轮播/引导页）
    └─→ TabBarView                      → 选项卡视图
```

## 核心心智模型

| 概念 | 说明 |
|---|---|
| **按需构建** | `builder` 模式只构建可见区域 item → 性能关键 |
| **itemExtent** | 固定高度/宽度 → 无需测量 → 极致滚动性能 |
| **Sliver 协议** | 可滚动区域内的"切片"，统一接口混合不同布局 |
| **ScrollController** | 读取 offset、animateTo、jumpTo |
| **GlobalKey + State** | AnimatedList、PageView 都需要 Key 获取底层 State |

## 项目结构

```
chapter_6/
├── chapter_6_1/lib/   ← SingleChildScrollView 示例
├── chapter_6_2/lib/   ← ListView 示例
├── chapter_6_3/lib/   ← GridView 示例
├── chapter_6_4/lib/   ← CustomScrollView + Slivers
├── chapter_6_5/lib/   ← ScrollController
├── chapter_6_6/lib/   ← AnimatedList
├── chapter_6_7/lib/   ← PageView
├── chapter_6_8/lib/   ← TabBarView
└── chapter_6_sceen/lib/ ← 汇总演示（含全部子章节导航）
```

## 运行方式

```bash
# 运行某个子章节
cd chapter_6/chapter_6_2 && flutter run

# 运行汇总演示
cd chapter_6/chapter_6_sceen && flutter run
```
