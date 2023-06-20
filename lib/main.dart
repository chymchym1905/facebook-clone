import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:flutter_application_1/model/post_class.dart';
import 'model/user_class.dart';
import 'routesettings.dart';
// import 'data/data.dart';
import 'theme/themes.dart';
import 'widgets/drawer.dart';
import 'widgets/post_card_container.dart';
import 'package:flutter/services.dart' as asd;


void main() {
  runApp(const Home());
}

ThemeProvider themeManager = ThemeProvider();

class Home extends StatefulWidget {
  const Home({super.key});

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
    super.initState();
  }

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
                //  ListView(
                //     padding: const EdgeInsets.symmetric(vertical: 5.0),
                //     children: [
                //         for (int index = 0; index < posts.length; index += 1) 
                //           if ((posts[index].visibility is! Private))
                //             Posts(data: posts[index]),                   
                //     ],
                //   ),
                  FutureBuilder(

                    future: readPostJsonData(),
                    builder: (context, data){
                    if(data.hasError){
                      return const Center(
                        child: Text(
                          'Data Error',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      );
                    } else if(data.hasData){
                      var items = data.data as List<Post>;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index){
                          return Posts(data: items[index]);
                        },
                      );
                    }else{
                        return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                  ),

                  FutureBuilder(

                    future: readPostJsonData(),
                    builder: (context, data){
                    if(data.hasError){
                      return const Center(
                        child: Text(
                          'Data Error',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      );
                    } else if(data.hasData){
                      var items = data.data as List<Post>;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index){
                          return Posts(data: items[index]);
                        },
                      );
                    }else{
                        return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                  ),

                  FutureBuilder(

                    future: readPostJsonData(),
                    builder: (context, data){
                    if(data.hasError){
                      return const Center(
                        child: Text(
                          'Data Error',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      );
                    } else if(data.hasData){
                      var items = data.data as List<Post>;
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index){
                          return Posts(data: items[index]);
                        },
                      );
                    }else{
                        return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                  ),

                //  ListView(
                //    padding: const EdgeInsets.symmetric(vertical: 5.0),
                //    children: [
                //      for (int index = 0; index < posts.length; index += 1)
                //          Posts(data: posts [index])
                //    ],),
                //  ListView(
                //    padding: const EdgeInsets.symmetric(vertical: 5.0),
                //    children: [
                //      for (int index = 0; index < posts.length; index += 1)
                //          Posts(data: posts [index])
                //    ],)
               ],
    
              ),
            ),
          ),
        ),
    );
  }

  Future<List<Post>>readPostJsonData() async{
     return await Future.delayed(const Duration(seconds: 1), () {
      // final jsonString = asd.rootBundle.loadString('data/posts.json');
    //  final list = json.decode(jsondata) as List<dynamic>;
      final jsonString = File("I:\\Internship\\flutter_application_1\\lib\\data\\posts.json").readAsStringSync();
      final data = jsonDecode(jsonString) as List<dynamic>;
      List<Post> users = data.map((e) => Post.fromJson(e)).toList();
      return users;
     });
  }
  //   Future<List<Post>>readPostJsonData() async{
  //    final jsondata = await asd.rootBundle.loadString('data/posts.json');
  //    final list = json.decode(jsondata) as List<dynamic>;

  //    return list.map((e) => Post.fromJson(e)).toList();
  // }
}



void insertPost(){
  
}