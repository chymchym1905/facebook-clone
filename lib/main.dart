import '../index.dart';


void main() {
  runApp(AppDataProvider( AppData(postlist: [] , notificationCount: 0), child: const Home()));
}
//Variables
int index = 0;
ThemeProvider themeManager = ThemeProvider();
PostList postManager = PostList([]);
List totalPost = []; //current number of posts loaded
List fullPost = []; //all posts here

//APP
class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> with TickerProviderStateMixin{
  late TabController _tabController;
  // LoadMorePost source1 = LoadMorePost();
  // LoadMorePost source2 = LoadMorePost();
  // LoadMorePost source3 = LoadMorePost();
  late LoadMorePost source1 ;
  late LoadMorePost source2 ;
  late LoadMorePost source3 ;
  // ScrollController controller1 = ScrollController();
  // ScrollController controller2 = ScrollController();
  // ScrollController controller3 = ScrollController();
  final GlobalKey<ExtendedNestedScrollViewState> _key = GlobalKey<ExtendedNestedScrollViewState>();
  // ScrollController controller = ScrollController();
  // List fullpost = [];
  List posts = []; //placeholder of 5 posts per load
  
  @override
  void dispose() {
    // _tabController.removeListener(_handleTabChange);
    themeManager.removeListener(themeListener);
    source1.dispose();
    source2.dispose();
    source3.dispose();
    // controller.removeListener(scrollListener);
    // controller1.removeListener(scrollListener1);
    // controller2.removeListener(scrollListener2);
    // controller3.removeListener(scrollListener3);
    postManager.removeListener(postlistListener);
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    postManager.addListener(postlistListener);
    initFetchData();
    // controller.addListener(scrollListener);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    // controller1.addListener(scrollListener1);
    // controller2.addListener(scrollListener2);
    // controller3.addListener(scrollListener3);
    themeManager.addListener(themeListener);
    
    source1 = LoadMorePost();
    source2 = LoadMorePost();    
    source3 = LoadMorePost();


    // fetch(postManager.post)
  }

  Future<void> initFetchData() async{
    await postManager.readPostJsonData();
    fullPost = postManager.post;
    // fetch(postManager.post);
  }

  void _handleTabChange(){
    if(mounted){
      setState(() {
        
      });
    }
  }

  // scrollListener(){

  // }

  postlistListener(){
    if(mounted){
      setState(() {
        // print('asd');
      });
    }
  }

  themeListener(){
    if(mounted){
      setState(() {
        // print(1);
      });
    }
  }

  // scrollListener1(){
  //   if(mounted){
  //     // print(controller.offset);
  //     // print(controller.position.maxScrollExtent);
  //     print(controller1.offset);
  //     if(controller1.position.maxScrollExtent == controller1.offset){
        
  //       fetch(postManager.post);
  //     }
  //   }
  // }

  // scrollListener2(){
  //   if(mounted){
  //     print(controller2.offset);
  //     if(controller2.position.maxScrollExtent == controller2.offset){
        
  //     fetch(postManager.post);
  //     }
  //   }
  // }
  
  // scrollListener3(){
  //   if(mounted){
  //     print(controller3.offset);
  //     if(controller3.position.maxScrollExtent == controller3.offset){
        
  //     fetch(postManager.post);
  //     }
  //   }
  // }

  Future<void> fetch(List fullpost) async{
    await Future<List?>.delayed(const Duration(milliseconds: 500));
    if (index + 5<fullpost.length){
      setState(() {
        posts = fullpost.sublist(index, index + 5);
        index +=5;
        totalPost += posts;
        print(index);
      });
    }else if(index+5 >= fullpost.length && index != fullpost.length){
      setState(() {
        posts = fullpost.sublist(index, fullpost.length);
        index = fullpost.length;
        totalPost += posts;
        print(index);
      });
    }else{
      if (kDebugMode) {
        print(Exception('???'));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
    // AppData appdata = AppDataProvider.of(context);
    // fetch(postManager.post);
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    // final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return  MaterialApp(
      theme: themeManager.themeMode,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Scaffold(
        // drawer: NavBar(),
        body: ExtendedNestedScrollView(
          key: _key,
            pinnedHeaderSliverHeightBuilder: () {
              return pinnedHeaderHeight/2;
            },
            onlyOneScrollInBody: true,
            headerSliverBuilder: (context,bool innerBoxisScrolled){
              return [
                    SliverAppBar(
                    // leadingWidth: MediaQuery.of(context).size.width*0.1,
                    // forceElevated: innerBoxisScrolled,
                    // leading: IconButton(
                    //   // iconSize: MediaQuery.of(context).size.width*0.08,
                    //   splashRadius: MediaQuery.of(context).size.width*0.07,
                    //   onPressed: () {Scaffold.of(context).openDrawer(); },
                    //   icon: const Icon(Octicons.three_bars),
                    
                    // ),
                    pinned: true,
                    floating: true,
                    snap: true,
                    // expandedHeight: 150,
                    // titleSpacing: MediaQuery.of(context).size.width*-0.01,
                    // floating: true,
                    // snap: true,
                    actions: [
                      Switch(value: themeManager.themeMode == dark, 
                      onChanged:(value) => themeManager.toggleTheme(value),
                      activeColor: white),
                      IconButton(
                          splashRadius: MediaQuery.of(context).size.width*0.07,
                          onPressed: () {},
                          icon: const Icon(Icons.add)),
                      IconButton(
                          splashRadius: MediaQuery.of(context).size.width*0.07,
                          onPressed: () {},
                          icon: const Icon(Icons.search)),
                    ],
                    // expandedHeight: MediaQuery.of(context).size.height * 0.15,
                    title: Text(
                      'fakebook',
                      style:TextStyle(
                      color:  themeManager.themeMode == dark? white:blue,
                    )),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(icon: Icon(Icons.home),),
                        Tab(icon: Icon(Icons.people_alt_outlined),),
                        Tab(icon: Icon(Icons.video_collection_rounded),),
                      ],                      
                    ),
                  ),
              ];
            },
            body: TabBarView(
                  controller: _tabController,
                   children:  [
                      PostListView(controller: ScrollController(), source: source1, pagekey: PageStorageKey('tab1')),
                      PostListView(controller: ScrollController(), source: source2 ,pagekey: PageStorageKey('tab2')),
                      PostListView(controller: ScrollController(), source: source3 ,pagekey: PageStorageKey('tab3'))
                   ],
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

