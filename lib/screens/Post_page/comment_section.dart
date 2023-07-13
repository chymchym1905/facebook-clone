
import '../../index.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({
    super.key,
    required this.data,
    required this.myfocusNode,
    required this.controlViewMoreComment,
    required this.setViewMoreComment, 
    required this.reloadState
  });
  final List<Comment1> data;
  final FocusNode myfocusNode;
  final List<bool> controlViewMoreComment;
  final Function(int) setViewMoreComment;
  final Function(Post) reloadState; 

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
        List<Comment1> listReply = [];
        countReply(widget.data[index], listReply);
        int listLength = listReply.length-1;
        if (widget.data[index].reply.isEmpty) {
          hideTree = Colors.white;
        } else {
          hideTree = themeManager.themeMode == dark
              ? const Color.fromARGB(255, 58, 59, 60)
              : const Color.fromARGB(255, 234, 236, 238);
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: CommentTreeWidget<Comment1, ViewMoreComment>(
            widget.data[index],
            [
              if (widget.controlViewMoreComment[index] &&
                  widget.data[index].reply.isNotEmpty) ...[
                ViewMoreComment(
                  controlViewMoreComment: widget.controlViewMoreComment[index],
                  list: widget.data[index].reply[0],
                  myfocusNode: widget.myfocusNode,
                  indexforreply1: index,
                  indexforreply2: 0,
                  setViewMoreComment: widget.setViewMoreComment,
                ),
                if(listReply.length != 1) ...[
                  ViewMoreComment(
                    controlViewMoreComment: widget.controlViewMoreComment[index],
                    list:Comment1(UserDummy("","",""),0,"View $listLength more comment...",[]),
                    myfocusNode: widget.myfocusNode,
                    indexforreply1: index,
                    indexforreply2: 0,
                    setViewMoreComment: widget.setViewMoreComment,
                  )
                ]
              ] else ...[
                for (int i = 0; i < widget.data[index].reply.length; i += 1)
                  ViewMoreComment(
                    controlViewMoreComment: widget.controlViewMoreComment[index],
                    list: widget.data[index].reply[i],
                    myfocusNode: widget.myfocusNode,
                    indexforreply1: index,
                    indexforreply2: i,
                    setViewMoreComment: widget.setViewMoreComment,
                  )
              ]
            ],
            treeThemeData: TreeThemeData(
              lineColor: hideTree,
              lineWidth: 2,
            ),
            avatarRoot: (context, data) => PreferredSize(
              preferredSize: const Size.fromRadius(18),
              child: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(data.user.imageurl),
              ),
            ),
            avatarChild: (context, data) =>  PreferredSize(
              preferredSize: widget.controlViewMoreComment[index]?const Size.fromRadius(30):const Size.fromRadius(42),
              child: const Row(),
            ),
            contentChild: (context, data) {
              //Replies
              return data;
            },
            contentRoot: (context, data) {
              Post fakedata = Post("", UserDummy("", "", ""), "", [], 0, 0, 0, [], 0);
              // Parent comment
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FBFullReaction(data: fakedata,reloadState: widget.reloadState ,comment: widget.data[index], controlContent: 2)
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  //   decoration: BoxDecoration(
                  //       color: themeManager.themeMode == dark
                  //           ? const Color.fromARGB(255, 58, 59, 60)
                  //           : const Color.fromARGB(155, 180, 177, 177),
                  //       borderRadius: BorderRadius.circular(12)),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(data.user.name,
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .labelLarge
                  //               ?.copyWith(fontWeight: FontWeight.w300)),
                  //       const SizedBox(
                  //         height: 4,
                  //       ),
                  //       Text(
                  //         data.content,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodySmall
                  //             ?.copyWith(fontStyle: FontStyle.normal),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // DefaultTextStyle(
                  //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  //       color: const Color.fromARGB(255, 109, 107, 107),
                  //       fontWeight: FontWeight.w300),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 4),
                  //     child: Row(
                  //       children: [
                  //         const SizedBox(
                  //           width: 8,
                  //         ),
                  //         // Text(data.timeAgo),
                  //         // const SizedBox(
                  //         //   width: 15,
                  //         // ),
                  //         TextButton(
                  //           onPressed: () {},
                  //           style: ButtonStyle(
                  //             fixedSize:
                  //                 MaterialStateProperty.resolveWith((states) {
                  //               final textStyle =
                  //                   Theme.of(context).textTheme.labelMedium!;
                  //               final textWidth = TextPainter(
                  //                 text:
                  //                     TextSpan(text: 'Like', style: textStyle),
                  //                 textDirection: TextDirection.ltr,
                  //               )..layout();
                  //               final textHeight = textWidth.size.height;
                
                  //               return Size(textWidth.size.width, textHeight);
                  //             }),
                  //           ),
                  //           child: Text('Like',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .labelMedium!
                  //                   .copyWith(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: const Color.fromARGB(
                  //                           255, 99, 100, 105))),
                  //         ),
                  //         TextButton(
                  //           onPressed: () {
                  //             IndexComment.flagReply = true;
                  //             IndexComment.flagReply2 = false;
                  //             IndexComment.intdex = index;
                  //             widget.myfocusNode.requestFocus();
                  //           },
                  //           style: ButtonStyle(
                  //             fixedSize:
                  //                 MaterialStateProperty.resolveWith((states) {
                  //               final textStyle =
                  //                   Theme.of(context).textTheme.labelMedium!;
                  //               final textWidth = TextPainter(
                  //                 text:
                  //                     TextSpan(text: 'Reply', style: textStyle),
                  //                 textDirection: TextDirection.ltr,
                  //               )..layout();
                  //               final textHeight = textWidth.size.height;
                
                  //               return Size(textWidth.size.width, textHeight);
                  //             }),
                  //           ),
                  //           // style: TextButton.styleFrom(
                  //           //      fixedSize:
                  //           //       MaterialStateProperty.resolveWith((states) {
                  //           //     final textStyle =
                  //           //         Theme.of(context).textTheme.labelMedium!;
                  //           //     final textWidth = TextPainter(
                  //           //       text:
                  //           //           TextSpan(text: 'Reply', style: textStyle),
                  //           //       textDirection: TextDirection.ltr,
                  //           //     )..layout();
                  //           //     final textHeight = textWidth.size.height;
                
                  //           //     return Size(textWidth.size.width, textHeight);
                  //           //   }),
                  //           // ),
                  //           child: Text('Reply',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .labelMedium!
                  //                   .copyWith(
                  //                       fontWeight: FontWeight.bold,
                  //                       color: const Color.fromARGB(
                  //                           255, 99, 100, 105))),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class ViewMoreComment extends StatefulWidget {
  const ViewMoreComment(
      {super.key,
      required this.controlViewMoreComment,
      required this.list,
      required this.myfocusNode,
      required this.indexforreply1,
      required this.indexforreply2,
      required this.setViewMoreComment});
  final bool controlViewMoreComment;
  final Comment1 list;
  final FocusNode myfocusNode;
  final int indexforreply1;
  final int indexforreply2;
  final Function(int) setViewMoreComment;
  @override
  State<ViewMoreComment> createState() => _ViewMoreCommentState();
}

class _ViewMoreCommentState extends State<ViewMoreComment> {
  @override
  Widget build(BuildContext context) {
    if (widget.controlViewMoreComment) {
      return GestureDetector(
        onTap: () {
          widget.setViewMoreComment(widget.indexforreply1);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              if(widget.list.user.imageurl.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(widget.list.user.imageurl),
                  ),
                ),
              ],
              Expanded(
                child: Text(
                  widget.list.content,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontStyle: FontStyle.normal)
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return CommmentTreeSection(
          list: widget.list,
          myfocusNode: widget.myfocusNode,
          indexforreply1: widget.indexforreply1,
          indexforreply2: widget.indexforreply2
      );
    }
  }
}

class CommmentTreeSection extends StatefulWidget {
  const CommmentTreeSection({
    super.key,
    required this.list,
    required this.myfocusNode,
    required this.indexforreply1,
    required this.indexforreply2,
  });
  final Comment1 list;
  final FocusNode myfocusNode;
  final int indexforreply1;
  final int indexforreply2;

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
              hideTree = themeManager.themeMode == dark
                  ? const Color.fromARGB(255, 58, 59, 60)
                  : const Color.fromARGB(255, 234, 236, 238);
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
                    radius: 22,
                    backgroundImage: NetworkImage(data.user.imageurl),
                  ),
                ),
                avatarChild: (context, data) => PreferredSize(
                  preferredSize: const Size.fromRadius(30),
                  child: CircleAvatar(
                    radius: 22,
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
                                : const Color.fromARGB(155, 180, 177, 177),
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
                              TextButton(
                                onPressed: () {},
                                // style: ButtonStyle(
                                //   fixedSize: MaterialStateProperty.resolveWith(
                                //       (states) {
                                //     final textStyle = Theme.of(context)
                                //         .textTheme
                                //         .labelMedium!;
                                //     final textWidth = TextPainter(
                                //       text: TextSpan(
                                //           text: 'Like', style: textStyle),
                                //       textDirection: TextDirection.ltr,
                                //     )..layout();
                                //     final textHeight = textWidth.size.height;

                                //     return Size(
                                //         textWidth.size.width, textHeight);
                                //   }),
                                // ),
                                child: Text('Like',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 99, 100, 105))),
                              ),
                              ReplyButton(indexforreply1: widget.indexforreply1, indexforreply2: widget.indexforreply2, myfocusNode: widget.myfocusNode)
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
                                : const Color.fromARGB(155, 180, 177, 177),
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
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.resolveWith(
                                      (states) {
                                    final textStyle = Theme.of(context)
                                        .textTheme
                                        .labelMedium!;
                                    final textWidth = TextPainter(
                                      text: TextSpan(
                                          text: 'Like', style: textStyle),
                                      textDirection: TextDirection.ltr,
                                    )..layout();
                                    final textHeight = textWidth.size.height;

                                    return Size(
                                        textWidth.size.width, textHeight);
                                  }),
                                ),
                                child: Text('Like',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 99, 100, 105))),
                              ),
                              TextButton(
                                onPressed: () {
                                  IndexComment.flagReply = false;
                                  IndexComment.flagReply2 = true;
                                  IndexComment.intdex = widget.indexforreply1;
                                  IndexComment.intdex2 = widget.indexforreply2;
                                  widget.myfocusNode.requestFocus();
                                },
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.resolveWith(
                                      (states) {
                                    final textStyle = Theme.of(context)
                                        .textTheme
                                        .labelMedium!;
                                    final textWidth = TextPainter(
                                      text: TextSpan(
                                          text: 'Reply', style: textStyle),
                                      textDirection: TextDirection.ltr,
                                    )..layout();
                                    final textHeight = textWidth.size.height;

                                    return Size(
                                        textWidth.size.width, textHeight);
                                  }),
                                ),
                                child: Text('Reply',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 99, 100, 105))),
                              ),
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
