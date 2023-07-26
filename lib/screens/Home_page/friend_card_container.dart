import '../../index.dart';

class FriendCard extends StatefulWidget {
  const FriendCard({super.key, required this.data});
  final UserDummy data;

  @override
  State<FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.12,
            backgroundImage: imageAvatar(widget.data.imageurl),
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
                      widget.data.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Text("time"),
                    ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20)),
                    child: const Text("Confirm"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30)),
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
