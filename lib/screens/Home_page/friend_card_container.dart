import '../../index.dart';
import '../friends_page.dart';

class FriendCard extends StatefulWidget {
  const FriendCard({super.key, required this.user, required this.posts});
  final UserDummy user;
  final Post posts;

  @override
  State<FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() {
          Navigator.of(context).pushNamed("/userprofile",
              arguments: Friends(
                user: widget.user,
                posts: widget.posts,
              ));
        }),
        child: Ink(
          child: Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05, left: 8),
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.12,
                    backgroundImage: imageAvatar(widget.user.imageurl),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text(
                              widget.user.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text("time",
                                style: Theme.of(context).textTheme.bodySmall),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "num mutual friends",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.08)),
                            child: const Text("Confirm"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: themeManager.themeMode ==
                                          dark
                                      ? const Color.fromARGB(255, 58, 59, 60)
                                      : const Color.fromARGB(
                                          255, 241, 242, 246),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.09)),
                              child: Text("Delete",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
