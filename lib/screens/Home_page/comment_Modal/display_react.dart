import 'package:flutter_application_1/model/reaction_class.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:indexed/indexed.dart';

import '../../../../../index.dart';
import '../../../../../utils/count_react.dart';

class DisplayReact extends StatefulWidget {
  const DisplayReact({super.key, required this.data});
  final List<Reaction> data;
  @override
  State<DisplayReact> createState() => _DisplayReactState();
}

class _DisplayReactState extends State<DisplayReact> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> listreact = {
      "like" : 0, ///0
      "love" : 0, ///1
      "haha" : 0, ///2
      "wow"  : 0, ///3
      "sad"  : 0, ///4
      "angry": 0, ///5
    };
    countReact(widget.data, listreact);
    List<MapEntry<String, int>> entries = listreact.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    Map<String, int> sortedList = Map.fromEntries(entries);
    int totalReact = sortedList.values.fold(0, (sum, value) => sum + value);
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/viewreaction',
          arguments: ReactionPage(
            reactions: widget.data, 
            sortedList: sortedList,
            totalReact: totalReact,
          ));
      },
      child: Row(
        children: [
          Indexer(
            children: [
              if(sortedList.values.elementAt(1) == 0 && sortedList.values.first != 0) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 7, bottom: 3),
                  child: Image.asset(
                    "assets/images/${sortedList.keys.first}.png",
                    width: MediaQuery.of(context).size.width * 0.05,
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
              ] else if(sortedList.values.elementAt(1) != 0 && sortedList.values.first != 0)...[
                Indexed(
                  index: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20,bottom: 3),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.width * 0.05,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                        border: Border.all(
                          color: themeManager.themeMode == dark
                            ? const Color.fromARGB(255, 58, 59, 60)
                            : const Color.fromARGB(255, 234, 236, 238),
                          width: 1.0,
                        ),
                      ),
                      child:  ClipRRect(
                    child: Image.asset(
                        "assets/images/${sortedList.keys.first}.png",
                        height:  MediaQuery.of(context).size.width * 0.05,
                        width:  MediaQuery.of(context).size.width * 0.05,
                        fit:BoxFit.cover,
                      ),
                    ),
                    ),
                  ),
                ),
                Indexed(
                  index: 1,
                  child: Positioned(
                    left: MediaQuery.of(context).size.width * 0.04,
                    child: Padding(
                      padding: const EdgeInsets.only( bottom: 3),
                      child: Image.asset(
                        "assets/images/${sortedList.keys.elementAt(1)}.png",
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
          Text(
            '$totalReact',
              style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w300)
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Icon(
              size: MediaQuery.of(context).size.width * 0.05,
              MfgLabs.right_open,
              color: themeManager.themeMode == dark
                ? const Color.fromARGB(255, 234, 236, 238)
                : const Color.fromARGB(255, 58, 59, 60),
            ),
          ),
        ],
      )
    );
  }
}