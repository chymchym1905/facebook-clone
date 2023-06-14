
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routesettings.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      fontFamily: 'HyWenHei',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      hintColor: Colors.orange,
    ),
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home>{
  final List<int> _items = List<int>.generate(50, (int index) => index);
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    return  Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context,value){
            return [
              const SliverAppBar(
                pinned: true,
                expandedHeight: 100.0,
                title: Text('Feed'),
                bottom: TabBar(
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
               ReorderableListView(
                   children: [
                     for (int index = 0; index < _items.length; index += 1)
                       ListTile(
                         key: Key('$index'),
                         tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                         title: Text('Item ${_items[index]}'),
                       ),
                   ],
                   onReorder: (int oldIndex, int newIndex) {
                     setState(() {
                       if (oldIndex < newIndex) {
                         newIndex -= 1;
                       }
                       final int item = _items.removeAt(oldIndex);
                       _items.insert(newIndex, item);
                     });
                   },)
             ],

            ),
          ),
        ),
      );
  }
}



