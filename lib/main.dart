// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:flutter_application_1/model/post_class.dart';
// import 'model/user_class.dart';
import 'routesettings.dart';
// import 'data/data.dart';
import 'theme/themes.dart';
import 'widgets/drawer.dart';
import 'widgets/post_card_container.dart';
// import 'utils/fileio.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const Home());
}

ThemeProvider themeManager = ThemeProvider();

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{
  
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    page = -1;
    paginationViewType = PaginationViewType.listView;
    super.initState();
  }
  int page = 10;
  PaginationViewType paginationViewType = PaginationViewType.listView;
  GlobalKey<PaginationViewState> key = GlobalKey();

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }


  
  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    // final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return  MaterialApp(
      theme: themeManager.themeMode,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Scaffold(
        drawer: NavBar(),
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context,value){
              return [
                SliverAppBar(
                  // leadingWidth: MediaQuery.of(context).size.width*0.1,
                  leading: IconButton(
                    // iconSize: MediaQuery.of(context).size.width*0.08,
                    splashRadius: MediaQuery.of(context).size.width*0.07,
                    onPressed: () {Scaffold.of(context).openDrawer(); },
                    icon: const Icon(Octicons.three_bars),
                    
                  ),
                  pinned: true,
                  titleSpacing: MediaQuery.of(context).size.width*-0.01,
                  floating: true,
                  snap: true,
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
                  bottom: const TabBar(
                    tabs: [
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
               children: [
                // ListView.builder(
                //   controller: _scrollController,
                //   padding: EdgeInsets.zero,
                //   itemCount: items.length,
                //   itemBuilder: (context, index){
                //     if (index< items.length){
                //       return Posts(data: items[index]);
                //     }else{
                //       return const Center(child: CircularProgressIndicator());
                //     }                                
                //   },
                // )
                PaginationView(
                  paginationViewType: paginationViewType,
                  itemBuilder: (BuildContext context, Post post, int index){
                    return Posts(data: post);
                  }, 
                  pageFetch: pageFetch, 
                  physics: BouncingScrollPhysics(),
                  onError: (dynamic error) => Center(
                    child: Text('Some error occured'),
                  ),
                  onEmpty: Center(
                    child: Text('Sorry! This is empty'),
                  ),
                  bottomLoader: Center(
                    child: CircularProgressIndicator(),
                  ),
                  initialLoader: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

                PaginationView(
                  paginationViewType: paginationViewType,
                  itemBuilder: (BuildContext context, Post post, int index){
                    return Posts(data: post);
                  }, 
                  pageFetch: pageFetch, 
                  physics: BouncingScrollPhysics(),
                  onError: (dynamic error) => Center(
                    child: Text('Some error occured'),
                  ),
                  onEmpty: Center(
                    child: Text('Sorry! This is empty'),
                  ),
                  bottomLoader: Center(
                    child: CircularProgressIndicator(),
                  ),
                  initialLoader: Center(
                    child: CircularProgressIndicator(),
                  ),   
                ),

                PaginationView(
                  paginationViewType: paginationViewType,
                  itemBuilder: (BuildContext context, Post post, int index){
                    return Posts(data: post);
                  }, 
                  pageFetch: pageFetch, 
                  physics: BouncingScrollPhysics(),
                  onError: (dynamic error) => Center(
                    child: Text('Some error occured'),
                  ),
                  onEmpty: Center(
                    child: Text('Sorry! This is empty'),
                  ),
                  bottomLoader: Center(
                    child: CircularProgressIndicator(),
                  ),
                  initialLoader: Center(
                    child: CircularProgressIndicator(),
                  ),
                )

               ],
    
              ),
            ),
          ),
        ),
    );
  }
  
    int offset = 0;
   Future<List<Post>> pageFetch(int offset) async {
    final startIndex = offset;
    var endIndex = startIndex + 8;
    var items = await rootBundle.loadString('assets/jsons/posts.json');
    final list = json.decode(items) as List<dynamic> ;
    if (endIndex > list.length){
      endIndex = list.length;
    }
    final nextUsersList = list.sublist(startIndex, endIndex);

    // final Faker faker = Faker();
    // final List<User> nextUsersList = List.generate(
    //   20,
    //   (int index) => User(
    //     faker.person.name() + ' - $page$index',
    //     faker.internet.email(),
    //   ),
    // );
    await Future<List<Post>?>.delayed(const Duration(seconds: 1));
    return page == 5 ? [] : nextUsersList.map((e) => Post.fromJson(e)).toList();
  }

}

