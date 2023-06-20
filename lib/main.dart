import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:flutter_application_1/model/post_class.dart';
import 'routesettings.dart';
import 'data/data.dart';
import 'theme/themes.dart';
import 'widgets/drawer.dart';
import 'widgets/post_card_container.dart';


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
                    activeColor: const Color.fromARGB(255, 255, 255, 255)),
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
                    color:  themeManager.themeMode == dark? const Color.fromARGB(255, 255, 255, 255): const Color.fromRGBO(59, 127, 210, 1),
                    letterSpacing: -1.2,
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
                 ListView(
                   padding: const EdgeInsets.symmetric(vertical: 5.0),
                   children: [
                        for (int index = 0; index < posts.length; index += 1) 
                            Posts(data: posts[index]),                   
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

void insertPost(){
  
}