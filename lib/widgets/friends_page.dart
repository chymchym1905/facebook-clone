import 'package:flutter_application_1/widgets/user_page.dart';

import '../index.dart';
import '../utils/count_mutual_friend.dart';

class Friend extends StatefulWidget {
  const Friend({super.key, required this.userFriends});
  final List<String> userFriends;
  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  List<UserDummy?> friends = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: MediaQuery.of(context).size.width * 0.07,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Your Friends'),
        bottom: PreferredSize(
            preferredSize: Size(context.width, 1), child: const Divider()),
      ),
      body: Material(
        color: themeManager.themeMode == dark
            ? const Color.fromARGB(255, 38, 38, 38)
            : whitee,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: themeManager.themeMode == light
                              ? const Color.fromARGB(255, 241, 242, 246)
                              : const Color.fromARGB(255, 57, 58, 60),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          hintStyle: const TextStyle(color: Colors.grey),
                          hintText: "Search Friends"),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<UserDummy?>>(
              future: Database().getUsersbyId(widget.userFriends),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                } else {
                  friends = snapshot.data ?? [];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 22),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    "${widget.userFriends.length} friends",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge)),
                          ],
                        ),
                      ),
                      for (int i = 0; i < widget.userFriends.length; i++) ...[
                        DisplayFriend(user: friends[i]!)
                      ]
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class DisplayFriend extends StatefulWidget {
  const DisplayFriend({super.key, required this.user});
  final UserDummy user;

  @override
  State<DisplayFriend> createState() => _DisplayFriendState();
}

class _DisplayFriendState extends State<DisplayFriend> {
  @override
  Widget build(BuildContext context) {
    int mutualFriend =
        countMutualFriend(currUser!.friends, widget.user.friends);
    return InkWell(
      onTap: () => setState(() {
        Navigator.of(context).pushNamed("/userprofile",
            arguments: UserPage(
              user: widget.user,
            ));
      }),
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.07,
                  backgroundImage: imageAvatar(widget.user.imageurl),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "$mutualFriend mutual friends",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              )
            ],
          ),
        ),
      ),
    );
  }
}
