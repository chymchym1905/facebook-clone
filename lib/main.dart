import 'package:flutter/material.dart';

import 'package:flutter_application_1/model/posts.dart';
import 'routesettings.dart';
import 'data/data.dart';
import 'theme/themes.dart';


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
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context,value){
              return [
                SliverAppBar(
                  leading: IconButton(
                    selectedIcon: const Icon(Icons.menu_open_outlined),
                    onPressed: () {  },
                    icon: const Icon(Icons.menu)
                  ),
                  pinned: true,
                  floating: true,
                  snap: true,
                  actions: [
                    Switch(value: themeManager.themeMode == dark, onChanged:(value) => themeManager.toggleTheme(value)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search)),
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
        ),
    );
  }
}