import 'package:flutter_application_1/model/reaction_class.dart';
import 'package:indexed/indexed.dart';

import '../index.dart';

class ReactionPage extends StatefulWidget {
  const ReactionPage({
    super.key,
    required this.reactions,
    required this.sortedList,
    required this.totalReact,
  });
  final List<Reaction> reactions;
  final Map<String, int> sortedList;
  final int totalReact;

  @override
  State<ReactionPage> createState() => _ReactionPageState();
}

class _ReactionPageState extends State<ReactionPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Color currentIndicatorColor = Colors.blue;
  List<String> keysortedList = ["All"];

  @override
  void initState() {
    super.initState();
    int nonZeroValueCount =
        widget.sortedList.values.where((value) => value != 0).length;
    keysortedList.addAll(widget.sortedList.keys);
    _tabController = TabController(length: nonZeroValueCount + 1, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentIndicatorColor =
            _getTabIndicatorColor(keysortedList[_tabController.index]);
      });
    });
    currentIndicatorColor =
        _getTabIndicatorColor(keysortedList[_tabController.index]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeManager.themeMode == dark
          ? const Color.fromARGB(255, 38, 38, 38)
          : Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.07,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(false);
            }),
        title: Text("People who reacted",
            style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              splashRadius: MediaQuery.of(context).size.width * 0.07),
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: currentIndicatorColor,
          tabs: [
            Tab(
              text: 'All ${widget.totalReact}',
            ),
            ...widget.sortedList.entries
                .where((entry) => entry.value != 0)
                .map((entry) {
              final icon = entry.key;
              final number = entry.value;
              return Tab(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/$icon.png",
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("$number"),
                    )
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        ReactionPageView(reactions: widget.reactions, icon: "All"),
        ...widget.sortedList.entries
            .where((entry) => entry.value != 0)
            .map((entry) =>
                ReactionPageView(reactions: widget.reactions, icon: entry.key))
            .toList(),
      ]),
    );
  }

  Color _getTabIndicatorColor(String tabName) {
    switch (tabName) {
      case 'All':
        return blue;
      case 'like':
        return blue;
      case 'love':
        return Colors.red;
      case 'haha':
        return Colors.yellow;
      case 'wow':
        return Colors.amber;
      case 'sad':
        return Colors.amberAccent;
      case 'angry':
        return Colors.deepOrange;
      default:
        return Colors.transparent;
    }
  }
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  const DecoratedTabBar(
      {super.key, required this.tabBar, required this.decoration});
  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}

class ReactionPageView extends StatefulWidget {
  const ReactionPageView(
      {super.key, required this.reactions, required this.icon});
  final List<Reaction> reactions;
  final String icon;

  @override
  State<ReactionPageView> createState() => _ReactionPageViewState();
}

class _ReactionPageViewState extends State<ReactionPageView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (int i = 0; i < widget.reactions.length; i++) ...[
          if (widget.icon == "All") ...[
            reactContent(context, i)
          ] else if (widget.icon == "like" &&
              widget.reactions[i].reaction == 0) ...[
            reactContent(context, i)
          ] else if (widget.icon == "love" &&
              widget.reactions[i].reaction == 1) ...[
            reactContent(context, i)
          ] else if (widget.icon == "haha" &&
              widget.reactions[i].reaction == 2) ...[
            reactContent(context, i)
          ] else if (widget.icon == "wow" &&
              widget.reactions[i].reaction == 3) ...[
            reactContent(context, i)
          ] else if (widget.icon == "sad" &&
              widget.reactions[i].reaction == 4) ...[
            reactContent(context, i)
          ] else if (widget.icon == "angry" &&
              widget.reactions[i].reaction == 5) ...[
            reactContent(context, i)
          ]
        ]
      ],
    );
  }

  Widget reactContent(BuildContext context, int index) {
    List<String> listicon = [
      "like",

      ///0
      "love",

      ///1
      "haha",

      ///2
      "wow",

      ///3
      "sad",

      ///4
      "angry",

      ///5
    ];
    if (widget.reactions[0].reaction == -1) {
      widget.reactions.removeAt(0);
    }
    return Row(
      children: [
        Indexer(
          children: [
            Indexed(
              index: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 15, left: 10),
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage:
                      imageAvatar(widget.reactions[index].user.imageurl),
                ),
              ),
            ),
            Indexed(
              index: 2,
              child: Positioned(
                top: 30,
                left: 30,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.07,
                  height: MediaQuery.of(context).size.width * 0.07,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: themeManager.themeMode == dark
                          ? const Color.fromARGB(255, 58, 59, 60)
                          : Colors.white,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    child: Image.asset(
                      "assets/images/${listicon[widget.reactions[index].reaction]}.png",
                      height: MediaQuery.of(context).size.width * 0.07,
                      width: MediaQuery.of(context).size.width * 0.07,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Text(widget.reactions[index].user.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w300))
      ],
    );
  }
}
