import '../index.dart';

void main() {
  runApp(AppDataProvider(
      AppData(
          commentPostPage: FocusNode(),
          commentModal: FocusNode(),
          notificationCount: 0),
      child: const Home()));
}

//Variables
int index = 0;
ThemeProvider themeManager = ThemeProvider();
PostList postManager = PostList([]);
AppBarManager appBarManager = AppBarManager();

//APP
class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  // SliverAppBar currentAppBar = const SliverAppBar();
  late LoadMorePost source1;
  late LoadMorePost source2;
  late LoadMorePost source3;
  // late AnimationController _animationController;
  // late Animation<double> animation;
  final GlobalKey<ExtendedNestedScrollViewState> _key =
      GlobalKey<ExtendedNestedScrollViewState>();

  // late AnimationController _animationController;
  // late final Animation<Offset> _offsetAnimation;

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    // _animationController.dispose();
    source1.dispose();
    source2.dispose();
    source3.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // animation = Tween<double>(begin: 0, end: -1).animate(_animationController);
    themeManager.addListener(themeListener);
    source1 = LoadMorePost();
    source2 = LoadMorePost();
    source3 = LoadMorePost();
  }

  void _handleTabChange() {
    if (mounted) {
      print(_tabController.index);
      setState(() {
        appBarManager.toggleAppBar(_tabController.index == 0);
      });
    }
  }

  postlistListener() {
    if (mounted) {
      setState(() {});
    }
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
    final TabBar primaryTabBar = TabBar(
      controller: _tabController,
      tabs: const [
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.people_alt_outlined),
        ),
        Tab(
          icon: Icon(Icons.video_collection_rounded),
        ),
      ],
    );
    // AppData appdata = AppDataProvider.of(context);

    return MaterialApp(
      theme: themeManager.themeMode,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: ExtendedNestedScrollView(
            key: _key,
            pinnedHeaderSliverHeightBuilder: () {
              return pinnedHeaderHeight / 2;
            },
            onlyOneScrollInBody: true,
            headerSliverBuilder: (context, bool innerBoxisScrolled) {
              return [
                SliverToBoxAdapter(
                    child: AnimatedSwitcher(
                        reverseDuration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, animation) =>
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0, -1),
                                end: const Offset(0, 0),
                              ).animate(animation),
                              child: child,
                            ),
                        duration: const Duration(milliseconds: 200),
                        child: appBarManager.currentAppBar)),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: CommonSliverPersistentHeaderDelegate(
                      Container(
                        // margin: EdgeInsets.only(top: statusBarHeight),
                        color:
                            themeManager.themeMode == dark ? lightdark : white,
                        child: primaryTabBar,
                      ),
                      primaryTabBar.preferredSize.height),
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                PostListView(source: source1, pagekey: PageStorageKey('tab1')),
                PostListView(source: source2, pagekey: PageStorageKey('tab2')),
                PostListView(source: source3, pagekey: PageStorageKey('tab3'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<List<Post>>readPostJsonData() async{
  //    return await Future.delayed(const Duration(seconds: 1), () {
  //     // final jsonString = asd.rootBundle.loadString('data/posts.json');
  //   //  final list = json.decode(jsondata) as List<dynamic>;

  //     final jsonString = File('data/posts.json').readAsStringSync();
  //     final data = jsonDecode(jsonString) as List<dynamic>;
  //     List<Post> users = data.map((e) => Post.fromJson(e)).toList();
  //     return users;
  //    });
  // }
}

class CommonSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CommonSliverPersistentHeaderDelegate(this.child, this.height);
  final Widget child;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(CommonSliverPersistentHeaderDelegate oldDelegate) {
    //print('shouldRebuild---------------');
    return oldDelegate != this;
  }
}
