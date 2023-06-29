import '../../index.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({
    super.key,
    required this.data,
    required this.myfocusNode,
    required this.instantUser,
  });
  final List<Comment1> data;
  final FocusNode myfocusNode;
  final User instantUser;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    Color hideTree;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        if (widget.data[index].reply.isEmpty) {
          hideTree = Colors.white;
        } else {
          hideTree = Colors.grey;
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: CommentTreeWidget<Comment1, CommmentTreeSection>(
            widget.data[index],
            [
              for (int i = 0; i < widget.data[index].reply.length; i += 1)
                CommmentTreeSection(list: widget.data[index].reply[i]),
            ],
            treeThemeData: TreeThemeData(
              lineColor: hideTree,
              lineWidth: 2,
            ),
            avatarRoot: (context, data) => PreferredSize(
              preferredSize: const Size.fromRadius(18),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(data.user.imageurl),
              ),
            ),
            avatarChild: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(25),
              child: Row(),
            ),
            contentChild: (context, data) {
              //Replies
              return data;
            },
            contentRoot: (context, data) {
              // Parent comment
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: themeManager.themeMode == dark
                            ? const Color.fromARGB(255, 58, 59, 60)
                            : Color.fromARGB(155, 180, 177, 177),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.user.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w300)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          data.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontStyle: FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color.fromARGB(255, 109, 107, 107),
                        fontWeight: FontWeight.w300),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          // Text(data.timeAgo),
                          // const SizedBox(
                          //   width: 15,
                          // ),
                          const Text('Like'),
                          TextButton(
                              onPressed: () {
                                // setState(() {

                                // });
                                IndexComment.flagReply = true;
                                IndexComment.intdex = index;
                                widget.myfocusNode.requestFocus();
                              },
                              child: const Text('Reply')),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class CommmentTreeSection extends StatefulWidget {
  const CommmentTreeSection({super.key, required this.list});
  final Comment1 list;
  @override
  State<CommmentTreeSection> createState() => _CommmentTreeSectionState();
}

class _CommmentTreeSectionState extends State<CommmentTreeSection> {
  @override
  Widget build(BuildContext context) {
    List<Comment1> listReply = [];
    countReply(widget.list, listReply);
    int defalutReply = 1;
    Color hideTree;
    return Column(
      children: [
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: defalutReply,
          itemBuilder: (context, index) {
            if (widget.list.reply.isEmpty) {
              hideTree = themeManager.themeMode == dark ? lightdark : white;
            } else {
              hideTree = Colors.grey;
            }
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CommentTreeWidget<Comment1, Comment1>(
                widget.list,
                [
                  for (int i = 1; i < defalutReply + listReply.length; i++)
                    listReply[i - 1],
                ],
                treeThemeData: TreeThemeData(
                  lineColor: hideTree,
                  lineWidth: 2,
                ),
                avatarRoot: (context, data) => PreferredSize(
                  preferredSize: const Size.fromRadius(18),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(data.user.imageurl),
                  ),
                ),
                avatarChild: (context, data) => PreferredSize(
                  preferredSize: const Size.fromRadius(18),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(data.user.imageurl),
                  ),
                ),
                contentChild: (context, data) {
                  //Replies
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: themeManager.themeMode == dark
                                ? const Color.fromARGB(255, 58, 59, 60)
                                : Color.fromARGB(155, 180, 177, 177),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w300)),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              data.content,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontStyle: FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color.fromARGB(255, 109, 107, 107),
                            fontWeight: FontWeight.w300),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              // Text(data.timeAgo),
                              // const SizedBox(
                              //   width: 15,
                              // ),
                              Text('Like'),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                contentRoot: (context, data) {
                  // Parent comment
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                            color: themeManager.themeMode == dark
                                ? const Color.fromARGB(255, 58, 59, 60)
                                : Color.fromARGB(155, 180, 177, 177),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.user.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w300)),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              data.content,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontStyle: FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color.fromARGB(255, 109, 107, 107),
                            fontWeight: FontWeight.w300),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              // Text(data.timeAgo),
                              // const SizedBox(
                              //   width: 15,
                              // ),
                              Text('Like'),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

void countReply(Comment1 data, List<Comment1> listdata) {
  int count = 0;
  var countLoop = data.reply.length;
  while (countLoop > 0) {
    listdata.add(data.reply[count]);
    if (data.reply[count].reply.isNotEmpty) {
      countReply(data.reply[count], listdata);
    }
    count++;
    countLoop--;
  }
}
