import 'package:flutter_application_1/model/reaction_class.dart';

import '../index.dart';

class ReactionPage extends StatefulWidget {
  const ReactionPage({super.key, required this.reactions});
  final List<Reaction> reactions;

  @override
  State<ReactionPage> createState() => _ReactionPageState();
}



class _ReactionPageState extends State<ReactionPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: themeManager.themeMode == dark
          ? const Color.fromARGB(255, 38, 38, 38)
          : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: MediaQuery.of(context).size.width * 0.07,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(false);
        }),
        title: Text("People who reacted",
              style: Theme.of(context).textTheme.titleLarge),
        // bottom: TabBar(
        //   tabs: [

        //   ],
        // ),
      ),
      // body: TabBarView(
      //   children: [

      //   ],
      // ),
    );
  }
}

class ReactionPageView extends StatelessWidget {
  const ReactionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}