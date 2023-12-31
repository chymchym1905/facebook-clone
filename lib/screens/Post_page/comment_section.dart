import 'package:flutter_application_1/utils/display_react.dart';
import 'package:flutter_application_1/utils/find_user_reaction.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../data/post.dart';
import '../../index.dart';
import '../../utils/commentlist.dart';
import '../../utils/count_comment.dart';
import '../../utils/interact_comment.dart';

// Post fakedata = Post("", UserDummy("", "", "", "", DateTime.timestamp(), []),
//     "", [], 0, 0, [], []);

// class CommentSection extends StatefulWidget {
//   const CommentSection({
//     super.key,
//     required this.data,
//     required this.myfocusNode,
//     required this.controlViewMoreComment,
//     required this.setViewMoreComment,
//   });
//   final Post data;
//   final FocusNode myfocusNode;
//   final List<bool> controlViewMoreComment;
//   final Function(int) setViewMoreComment;

//   @override
//   State<CommentSection> createState() => _CommentSectionState();
// }

// class _CommentSectionState extends State<CommentSection> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   void reloadReaction(List<Reaction> reaction) {
//     setState(() {});
//   }

//   void reloadComment(List<Comment1> comment) {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     Color hideTree;
//     return ListView.builder(
//       physics: const ClampingScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: widget.data.comment.length,
//       itemBuilder: (context, index) {
//         List<Comment1> listReply = [];
//         countReply(widget.data.comment[index], listReply);
//         int listLength = listReply.length - 1;
//         if (widget.data.comment[index].reply.isEmpty) {
//           hideTree = themeManager.themeMode == dark ? lightdark : whitee;
//         } else {
//           hideTree = themeManager.themeMode == dark
//               ? const Color.fromARGB(255, 58, 59, 60)
//               : const Color.fromARGB(255, 234, 236, 238);
//         }
//         Comment1 fakeComment = Comment1(
//             "",
//             UserDummy("", "", "", "", DateTime.timestamp(), []),
//             0,
//             "View $listLength more comment...", [], []);
//         return Container(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//           child: CommentTreeWidget<Comment1, ViewMoreComment>(
//             widget.data.comment[index],
//             [
//               if (widget.controlViewMoreComment[index] &&
//                   widget.data.comment[index].reply.isNotEmpty) ...[
//                 ViewMoreComment(
//                     controlViewMoreComment:
//                         widget.controlViewMoreComment[index],
//                     list: widget.data.comment[index].reply[0],
//                     myfocusNode: widget.myfocusNode,
//                     indexforreply1: index,
//                     indexforreply2: 0,
//                     setViewMoreComment: widget.setViewMoreComment,
//                     data: widget.data,
//                     reloadComment: reloadComment),
//                 if (listReply.length != 1) ...[
//                   ViewMoreComment(
//                       controlViewMoreComment:
//                           widget.controlViewMoreComment[index],
//                       list: fakeComment,
//                       myfocusNode: widget.myfocusNode,
//                       indexforreply1: index,
//                       indexforreply2: 0,
//                       setViewMoreComment: widget.setViewMoreComment,
//                       data: widget.data,
//                       reloadComment: reloadComment)
//                 ]
//               ] else ...[
//                 for (int i = 0;
//                     i < widget.data.comment[index].reply.length;
//                     i += 1)
//                   ViewMoreComment(
//                       controlViewMoreComment:
//                           widget.controlViewMoreComment[index],
//                       list: widget.data.comment[index].reply[i],
//                       myfocusNode: widget.myfocusNode,
//                       indexforreply1: index,
//                       indexforreply2: i,
//                       setViewMoreComment: widget.setViewMoreComment,
//                       data: widget.data,
//                       reloadComment: reloadComment)
//               ]
//             ],
//             treeThemeData: TreeThemeData(
//               lineColor: hideTree,
//               lineWidth: 2,
//             ),
//             avatarRoot: (context, data) => PreferredSize(
//               preferredSize: const Size.fromRadius(18),
//               child: CircleAvatar(
//                 radius: 22,
//                 backgroundImage: imageAvatar(data.user.imageurl),
//               ),
//             ),
//             avatarChild: (context, data) => PreferredSize(
//               preferredSize: widget.controlViewMoreComment[index]
//                   ? const Size.fromRadius(30)
//                   : const Size.fromRadius(42),
//               child: const Row(),
//             ),
//             contentChild: (context, data) {
//               //Replies
//               return data;
//             },
//             contentRoot: (context, data) {
//               // Parent comment
//               if (currUser != null) {
//                 findUserReact(currUser!.name, data.reactions);
//               }
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // GestureDetector(
//                   //   onLongPress: () {
//                   //     setState(() {
//                   //       widget.data.removeAt(index);
//                   //     });
//                   //   },
//                   //   child: Container(
//                   //     padding: const EdgeInsets.symmetric(
//                   //         vertical: 8, horizontal: 8),
//                   //     decoration: BoxDecoration(
//                   //         color: themeManager.themeMode == dark
//                   //             ? const Color.fromARGB(255, 58, 59, 60)
//                   //             : const Color.fromARGB(255, 241, 242, 246),
//                   //         borderRadius: BorderRadius.circular(12)),
//                   //     child: Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: [
//                   //         Text(data.user.name,
//                   //             style: Theme.of(context)
//                   //                 .textTheme
//                   //                 .labelLarge
//                   //                 ?.copyWith(fontWeight: FontWeight.w300)),
//                   //         const SizedBox(
//                   //           height: 4,
//                   //         ),
//                   //         Text(
//                   //           data.content,
//                   //           style: Theme.of(context)
//                   //               .textTheme
//                   //               .bodySmall
//                   //               ?.copyWith(fontStyle: FontStyle.normal),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   DisplayComment(
//                     data: widget.data,
//                     index1: index,
//                     reloadComment: reloadComment,
//                     commentDisplay: data,
//                   ),
//                   DefaultTextStyle(
//                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         color: const Color.fromARGB(255, 109, 107, 107),
//                         fontWeight: FontWeight.w300),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 4),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Row(
//                               children: [
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 FBFullReaction(
//                                   reactions: data.reactions,
//                                   reloadReaction: reloadReaction,
//                                 ),
//                                 ReplyButton(
//                                     indexforreply1: index,
//                                     indexforreply2: -1,
//                                     myfocusNode: widget.myfocusNode,
//                                     flagReply: true,
//                                     flagReply2: false)
//                               ],
//                             ),
//                           ),
//                           DisplayReact(
//                               data: data.reactions,
//                               isRevert: true,
//                               hideIcon: true)
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class ViewMoreComment extends StatefulWidget {
//   const ViewMoreComment(
//       {super.key,
//       required this.controlViewMoreComment,
//       required this.list,
//       required this.myfocusNode,
//       required this.indexforreply1,
//       required this.indexforreply2,
//       required this.setViewMoreComment,
//       required this.data,
//       required this.reloadComment});
//   final bool controlViewMoreComment;
//   final Comment1 list;
//   final FocusNode myfocusNode;
//   final int indexforreply1;
//   final int indexforreply2;
//   final Post data;
//   final Function(int) setViewMoreComment;
//   final Function(List<Comment1>) reloadComment;

//   @override
//   State<ViewMoreComment> createState() => _ViewMoreCommentState();
// }

// class _ViewMoreCommentState extends State<ViewMoreComment> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.controlViewMoreComment) {
//       return InkWell(
//         onTap: () {
//           widget.setViewMoreComment(widget.indexforreply1);
//         },
//         splashColor: Colors.transparent,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 8, bottom: 10),
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               children: [
//                 // if (widget.list.user.imageurl.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: CircleAvatar(
//                     radius: 15,
//                     backgroundImage: imageAvatar(widget.list.user.imageurl),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 4),
//                     child: Text(widget.list.content,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodySmall
//                             ?.copyWith(fontStyle: FontStyle.normal)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     } else {
//       return CommmentTreeSection(
//         list: widget.list,
//         myfocusNode: widget.myfocusNode,
//         indexforreply1: widget.indexforreply1,
//         indexforreply2: widget.indexforreply2,
//         data: widget.data,
//         reloadComment: widget.reloadComment,
//       );
//     }
//   }
// }

// class CommmentTreeSection extends StatefulWidget {
//   const CommmentTreeSection({
//     super.key,
//     required this.list,
//     required this.myfocusNode,
//     required this.indexforreply1,
//     required this.indexforreply2,
//     required this.data,
//     required this.reloadComment,
//   });
//   final Comment1 list;
//   final FocusNode myfocusNode;
//   final int indexforreply1;
//   final int indexforreply2;
//   final Post data;
//   final Function(List<Comment1>) reloadComment;

//   @override
//   State<CommmentTreeSection> createState() => _CommmentTreeSectionState();
// }

// class _CommmentTreeSectionState extends State<CommmentTreeSection> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   void reloadReaction(List<Reaction> data) {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Comment1> listReply = [];
//     countReply(widget.list, listReply);
//     int defalutReply = 1;
//     Color hideTree;
//     return Column(
//       children: [
//         ListView.builder(
//           physics: const ClampingScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: defalutReply,
//           itemBuilder: (context, index) {
//             if (widget.list.reply.isEmpty) {
//               hideTree = themeManager.themeMode == dark ? lightdark : whitee;
//             } else {
//               hideTree = themeManager.themeMode == dark
//                   ? const Color.fromARGB(255, 58, 59, 60)
//                   : const Color.fromARGB(255, 234, 236, 238);
//             }
//             return Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: CommentTreeWidget<Comment1, Comment1>(
//                 widget.list,
//                 [
//                   for (int i = 1; i < defalutReply + listReply.length; i++)
//                     listReply[i - 1],
//                 ],
//                 treeThemeData: TreeThemeData(
//                   lineColor: hideTree,
//                   lineWidth: 2,
//                 ),
//                 avatarRoot: (context, data) => PreferredSize(
//                   preferredSize: const Size.fromRadius(18),
//                   child: CircleAvatar(
//                     radius: 22,
//                     backgroundImage: imageAvatar(data.user.imageurl),
//                   ),
//                 ),
//                 avatarChild: (context, data) => PreferredSize(
//                   preferredSize: const Size.fromRadius(30),
//                   child: CircleAvatar(
//                     radius: 22,
//                     backgroundImage: imageAvatar(data.user.imageurl),
//                   ),
//                 ),
//                 contentChild: (context, data) {
//                   //Replies
//                   if (currUser != null) {
//                     findUserReact(currUser!.name, data.reactions);
//                   }
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Container(
//                       //   padding: const EdgeInsets.symmetric(
//                       //       vertical: 8, horizontal: 8),
//                       //   decoration: BoxDecoration(
//                       //       color: themeManager.themeMode == dark
//                       //           ? const Color.fromARGB(255, 58, 59, 60)
//                       //           : const Color.fromARGB(255, 241, 242, 246),
//                       //       borderRadius: BorderRadius.circular(12)),
//                       //   child: Column(
//                       //     crossAxisAlignment: CrossAxisAlignment.start,
//                       //     children: [
//                       //       Text(data.user.name,
//                       //           style: Theme.of(context)
//                       //               .textTheme
//                       //               .labelLarge
//                       //               ?.copyWith(fontWeight: FontWeight.w300)),
//                       //       const SizedBox(
//                       //         height: 4,
//                       //       ),
//                       //       Text(
//                       //         data.content,
//                       //         style: Theme.of(context)
//                       //             .textTheme
//                       //             .bodySmall
//                       //             ?.copyWith(fontStyle: FontStyle.normal),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       DisplayComment(
//                         data: widget.data,
//                         index1: widget.indexforreply1,
//                         index2: widget.indexforreply2,
//                         index3: index,
//                         reloadComment: widget.reloadComment,
//                         commentDisplay: data,
//                       ),
//                       DefaultTextStyle(
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: const Color.fromARGB(255, 109, 107, 107),
//                             fontWeight: FontWeight.w300),
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 4),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     const SizedBox(
//                                       width: 8,
//                                     ),
//                                     // Text(data.timeAgo),
//                                     // const SizedBox(
//                                     //   width: 15,
//                                     // ),
//                                     FBFullReaction(
//                                       reactions: data.reactions,
//                                       reloadReaction: reloadReaction,
//                                     ),
//                                     ReplyButton(
//                                         indexforreply1: widget.indexforreply1,
//                                         indexforreply2: widget.indexforreply2,
//                                         myfocusNode: widget.myfocusNode,
//                                         flagReply: false,
//                                         flagReply2: true)
//                                   ],
//                                 ),
//                               ),
//                               DisplayReact(
//                                   data: data.reactions,
//                                   isRevert: true,
//                                   hideIcon: true)
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//                 },
//                 contentRoot: (context, data) {
//                   if (currUser != null) {
//                     findUserReact(currUser!.name, data.reactions);
//                   }
//                   // Parent comment
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Container(
//                       //   padding: const EdgeInsets.symmetric(
//                       //       vertical: 8, horizontal: 8),
//                       //   decoration: BoxDecoration(
//                       //       color: themeManager.themeMode == dark
//                       //           ? const Color.fromARGB(255, 58, 59, 60)
//                       //           : const Color.fromARGB(255, 241, 242, 246),
//                       //       borderRadius: BorderRadius.circular(12)),
//                       //   child: Column(
//                       //     crossAxisAlignment: CrossAxisAlignment.start,
//                       //     children: [
//                       //       Text(data.user.name,
//                       //           style: Theme.of(context)
//                       //               .textTheme
//                       //               .labelLarge
//                       //               ?.copyWith(fontWeight: FontWeight.w300)),
//                       //       const SizedBox(
//                       //         height: 4,
//                       //       ),
//                       //       Text(
//                       //         data.content,
//                       //         style: Theme.of(context)
//                       //             .textTheme
//                       //             .bodySmall
//                       //             ?.copyWith(fontStyle: FontStyle.normal),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       DisplayComment(
//                         data: widget.data,
//                         index1: widget.indexforreply1,
//                         index2: widget.indexforreply2,
//                         reloadComment: widget.reloadComment,
//                         commentDisplay: data,
//                       ),
//                       DefaultTextStyle(
//                         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                             color: const Color.fromARGB(255, 109, 107, 107),
//                             fontWeight: FontWeight.w300),
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 4),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     const SizedBox(
//                                       width: 8,
//                                     ),
//                                     // Text(data.timeAgo),
//                                     // const SizedBox(
//                                     //   width: 15,
//                                     // ),
//                                     FBFullReaction(
//                                       reactions: data.reactions,
//                                       reloadReaction: reloadReaction,
//                                     ),
//                                     ReplyButton(
//                                         indexforreply1: widget.indexforreply1,
//                                         indexforreply2: widget.indexforreply2,
//                                         myfocusNode: widget.myfocusNode,
//                                         flagReply: false,
//                                         flagReply2: true)
//                                   ],
//                                 ),
//                               ),
//                               DisplayReact(
//                                   data: data.reactions,
//                                   isRevert: true,
//                                   hideIcon: true)
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// late Color hideTree;
//Comment box (1 comment)
class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.data});
  final Comment1 data;
  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  void initState() {
    super.initState();
  }

  void reloadReaction(List<Reaction> reaction) {
    setState(() {});
  }

  void reloadComment(List<Comment1> comment) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CommentTreeWidget<Comment1, Comment1>(
      widget.data,
      const [],
      treeThemeData: const TreeThemeData(
        lineColor: Colors.white,
        lineWidth: 2,
      ),
      avatarRoot: (context, data) => PreferredSize(
        preferredSize: const Size.fromRadius(18),
        child: CircleAvatar(
          radius: 22,
          backgroundImage: imageAvatar(data.user.imageurl),
        ),
      ),
      contentRoot: (context, data) {
        // if (currUser != null) {
        //   findUserReact(currUser!.name, data.reactions);
        // }
        // Parent comment
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  color: themeManager.themeMode == dark
                      ? const Color.fromARGB(255, 58, 59, 60)
                      : const Color.fromARGB(255, 241, 242, 246),
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
            // DisplayComment(
            //   data: widget.data,
            //   index1: widget.indexforreply1,
            //   index2: widget.indexforreply2,
            //   reloadComment: widget.reloadComment,
            //   commentDisplay: data,
            // ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: const Color.fromARGB(255, 109, 107, 107),
                  fontWeight: FontWeight.w300),
              child: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          // Text(data.timeAgo),
                          // const SizedBox(
                          //   width: 15,
                          // ),
                          // FBFullReaction(
                          //   reactions: data.reactions,
                          //   reloadReaction: reloadReaction,
                          // ),
                        ],
                      ),
                    ),
                    // DisplayReact(
                    //     data: data.reactions,
                    //     isRevert: true,
                    //     hideIcon: true)
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
