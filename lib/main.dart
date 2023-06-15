
import 'package:flutter/material.dart';

import 'package:flutter_application_1/model/posts.dart';
import 'routesettings.dart';
import 'data/data.dart';
import 'model/posts.dart';

void main() {
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
      fontFamily: 'HyWenHei',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color.fromARGB(235, 244, 247, 245),
      // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(161, 158, 158, 158)),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Color.fromRGBO(59, 127, 210, 1),
      ),   
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    // final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return  Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context,value){
            return [
              SliverAppBar(
                leading: IconButton(
                  selectedIcon: Icon(Icons.menu_open_outlined),
                  onPressed: () {  },
                  icon: Icon(Icons.menu)
                ),
                pinned: true,
                floating: true,
                snap: true,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search)),
                ],
                expandedHeight: MediaQuery.of(context).size.height * 0.15,
                title: const Text('Feed'),
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                      text: 'Home',
                    ),
                    Tab(
                      icon: Icon(Icons.people_alt_outlined),
                      text: 'Friends',
                    ),
                    Tab(
                      icon: Icon(Icons.video_collection_rounded),
                      text: 'Watch',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
             children: [
               ListView(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 children: [
                     for (int index = 0; index < posts.length; index += 1)
                       Posts(data: posts [index])
                   ],
                   ),
               ListView(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 children: [
                   for (int index = 0; index < posts.length; index += 1)
                       Posts(data: posts [index])
                 ],),
               ListView(
                 padding: const EdgeInsets.symmetric(vertical: 5.0),
                 children: [
                   for (int index = 0; index < posts.length; index += 1)
                       Posts(data: posts [index])
                 ],)
             ],

            ),
          ),
        ),
      );
  }
  
}



