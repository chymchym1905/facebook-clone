import '../../index.dart';
import '../../utils/count_mutual_friend.dart';
import '../../widgets/user_page.dart';

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
    int mutualFriend =
        countMutualFriend(currUser!.friends, widget.user.friends);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() {
          Navigator.of(context).pushNamed("/userprofile",
              arguments: UserPage(
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
                    radius: 40,
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
                            "$mutualFriend mutual friends",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(),
                              child: const Text("Confirm"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeManager.themeMode == dark
                                    ? const Color.fromARGB(255, 58, 59, 60)
                                    : const Color.fromARGB(255, 241, 242, 246),
                              ),
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
