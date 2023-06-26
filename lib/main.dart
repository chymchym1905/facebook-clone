// ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'dart:convert';
// import 'dart:io';
// import 'package:fluttericon/octicons_icons.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter_application_1/model/post_class.dart';
// import 'widgets/drawer.dart';
// import 'widgets/post_card_container.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/appdata.dart';
import 'package:flutter_application_1/widgets/postlistview.dart';
// import 'package:flutter/services.dart';
// import 'utils/fileio.dart';
import 'utils/postlist.dart';
// import 'model/user_class.dart';
import 'routesettings.dart';
// import 'data/data.dart';
import 'theme/themes.dart';



void main() {
  runApp(AppDataProvider( AppData(postlist: [] , notificationCount: 0), child: const Home()));
}
//Variables
int index = 0;
ThemeProvider themeManager = ThemeProvider();
PostList postManager = PostList([]);
List totalPost = [];

//APP
class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home>{
  // late TabController _tabController;
  ScrollController controller1 = ScrollController();
  ScrollController controller2 = ScrollController();
  ScrollController controller3 = ScrollController();
  // List fullpost = [];
  List posts = []; //placeholder of 5 posts per load
  
  @override
  void dispose() {
    // _tabController.removeListener(_handleTabChange);
    themeManager.removeListener(themeListener);
    controller1.removeListener(scrollListener1);
    controller2.removeListener(scrollListener2);
    controller3.removeListener(scrollListener3);
    postManager.removeListener(postlistListener);
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
    // _tabController.addListener(_handleTabChange);
    postManager.addListener(postlistListener);
    initFetchData();
    controller1.addListener(scrollListener1);
    controller2.addListener(scrollListener2);
    controller3.addListener(scrollListener3);
    themeManager.addListener(themeListener);
    // fetch(postManager.post);
  }

  Future<void> initFetchData() async{
    await postManager.readPostJsonData();
    fetch(postManager.post);
  }

  // void _handleTabChange() {
  //   setState(() {});
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

  scrollListener1(){
    if(mounted){
      // print(controller.offset);
      // print(controller.position.maxScrollExtent);
      if(controller1.position.maxScrollExtent == controller1.offset){
        // print(controller.offset);
        fetch(postManager.post);
      }
    }
  }

  scrollListener2(){
    if(mounted){
      if(controller2.position.maxScrollExtent == controller2.offset){
        // print(controller.offset);
      fetch(postManager.post);
      }
    }
  }
  
  scrollListener3(){
    if(mounted){
      if(controller3.position.maxScrollExtent == controller3.offset){
        // print(controller.offset);
      fetch(postManager.post);
      }
    }
  }

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
        // print(index);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
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
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context,value){
              return [
                SliverAppBar(
                  // leadingWidth: MediaQuery.of(context).size.width*0.1,
                  forceElevated: value,
                  // leading: IconButton(
                  //   // iconSize: MediaQuery.of(context).size.width*0.08,
                  //   splashRadius: MediaQuery.of(context).size.width*0.07,
                  //   onPressed: () {Scaffold.of(context).openDrawer(); },
                  //   icon: const Icon(Octicons.three_bars),
                    
                  // ),
                  pinned: true,
                  floating: true,
                  snap: true,
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
                    
                  ),
                ),
              ];
            },
            body: TabBarView(
              // controller: _tabController,
               children: [
                //  ListView(
                //     padding: const EdgeInsets.symmetric(vertical: 5.0),
                //     children: [
                //         for (int index = 0; index < posts.length; index += 1) 
                //           if ((posts[index].visibility is! Private))
                //             Posts(data: posts[index]),                   
                //     ],
                //   ),
                  // FutureBuilder(
                  //   future: postlist.readPostJsonData(),
                  //   builder: (context, data){
                  //   if(data.hasError){
                  //     return const Center(
                  //       child: Text(
                  //         'Data Error',
                  //         style: TextStyle(
                  //           fontSize: 30,
                  //         ),
                  //       ),
                  //     );
                  //   } else if(data.hasData){
                  //     var items = data.data as List<Post>;
                  //     return ListView.builder(
                  //       padding: EdgeInsets.zero,
                  //       itemCount: items.length,
                  //       itemBuilder: (context, index){
                  //         return Posts(data: items[index]);
                  //       },
                  //     );
                  //   }else{
                  //       return const Center(child: CircularProgressIndicator(),);
                  //   }
                  // },
                  // ),

                  PostListView(controller:controller1, list: totalPost, pagekey: PageStorageKey('tab1')),
                  PostListView(controller:controller2, list: totalPost, pagekey: PageStorageKey('tab2')),
                  PostListView(controller:controller3, list: totalPost, pagekey: PageStorageKey('tab3'))
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

