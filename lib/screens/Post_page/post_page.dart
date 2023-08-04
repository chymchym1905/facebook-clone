// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../data/focusNode.dart';
import '../../data/post.dart';
import '../../index.dart';
import '../../model/reaction_class.dart';
import '../../utils/commentlist.dart';
import '../../utils/display_react.dart';
import '../../utils/find_user_reaction.dart';

class IndexReply {
  static int intdex = -1;
  static int intdex2 = -1;
  static bool flagReply = false;
  static bool flagReply2 = false;
}

class IndexComment {
  static int intdex1 = -1;
  static int intdex2 = -1;
  static int intdex3 = -1;
}

class CommentHelper {
  static String parentCommentId = '';
  static String grandParentCommentId = '';
} // lưu parentCommentId và grandParentCommentId khi bấm reply

class Postpage extends StatefulWidget {
  const Postpage({
    Key? key,
    required this.data,
    required this.reloadState,
  }) : super(key: key);
  final Post data;
  final Function(List<Reaction>) reloadState;

  @override
  State<Postpage> createState() => _PostPageState();
}

class _PostPageState extends State<Postpage>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late TextEditingController textController;

  List<bool> controlViewMoreComment = [];

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    textController = TextEditingController();
    for (int i = 0; i < widget.data.comment.length; i++) {
      controlViewMoreComment.add(true);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    if (value == 0 && MediaQuery.of(context).viewInsets.bottom != 0) {
      Provider.of<FocusNodeProvider>(context, listen: false)
          .commentPostPage
          .unfocus();
    }
  }

  void updateState(List<Reaction> reactions) {
    setState(() {
      // AppDataProvider.of(context).currentViewData = p;
    });
  }

  void setViewMoreComment(int index) {
    setState(() {
      controlViewMoreComment[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final loadMoreComment = LoadMoreComment(postProvider, widget.data.id);
    super.build(context);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    if (currUser != null) {
      findUserReact(currUser!.name, widget.data.reactions);
    }

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FBFullReaction(
            reactions: widget.data.reactions,
            reloadState: widget.reloadState,
            updateState: updateState),
        const CommentButton(),
        ShareButton(data: widget.data),
      ],
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        IndexReply.flagReply = false;
        IndexReply.flagReply2 = false;
      },
      child: Scaffold(
        backgroundColor: themeManager.themeMode == dark
            ? const Color.fromARGB(255, 38, 38, 38)
            : Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              splashRadius: MediaQuery.of(context).size.width * 0.07,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                widget.reloadState;
                Navigator.of(context).pop(false);
              }),
          title: Text(widget.data.user.name,
              style: Theme.of(context).textTheme.titleLarge),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                splashRadius: MediaQuery.of(context).size.width * 0.07),
          ],
          // bottom: ,
        ),
        // body: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     ListView(
        //       children: [
        //         NameBar(
        //           data: widget.data,
        //           reloadState: widget.reloadState,
        //           isPostpage: false,
        //         ),
        //         Caption(
        //           reloadState: widget.reloadState,
        //           data: widget.data,
        //           isPostpage: false,
        //         ),
        //         if (widget.data.imageurl.isNotEmpty)
        //           ImageBox(data: widget.data),
        //         Divider(
        //           indent: MediaQuery.of(context).size.width * 0.05,
        //           endIndent: MediaQuery.of(context).size.width * 0.05,
        //           thickness: 1,
        //         ),
        //         // Container(
        //         //     decoration: const BoxDecoration(
        //         //         border: Border(
        //         //             bottom:
        //         //                 BorderSide(color: Colors.grey, width: 0.2))),
        //         //     height: 1,
        //         //     width: MediaQuery.of(context).size.width * 0.9),
        //         buttonSection,
        //         Divider(
        //             indent: MediaQuery.of(context).size.width * 0.05,
        //             endIndent: MediaQuery.of(context).size.width * 0.05,
        //             thickness: 1),
        //         if (widget.data.reactions.isNotEmpty) ...[
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: DisplayReact(
        //                 data: widget.data.reactions,
        //                 isRevert: false,
        //                 hideIcon: true),
        //           )
        //         ],
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             TextButton(
        //               onPressed: () {},
        //               child: Row(
        //                 children: [
        //                   Text("More relevant",
        //                       style: Theme.of(context).textTheme.bodyMedium),
        //                   Icon(
        //                     Icons.keyboard_arrow_down,
        //                     color: themeManager.themeMode == dark
        //                         ? whitee
        //                         : const Color.fromARGB(255, 58, 59, 60),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         // CommentSection(
        //         //   myfocusNode:
        //         //       Provider.of<FocusNodeProvider>(context).commentPostPage,
        //         //   data: widget.data,
        //         //   controlViewMoreComment: controlViewMoreComment,
        //         //   setViewMoreComment: setViewMoreComment,
        //         // ),
        //         CommentSection(data: widget.data)
        //       ],
        //     ),

        //     // WriteCommentBox(
        //     //   data: widget.data,
        //     //   myfocusNode:
        //     //       Provider.of<FocusNodeProvider>(context).commentPostPage,
        //     //   isKeyboard: isKeyboard,
        //     //   myController: textController,
        //     //   instantUser: currUser!,
        //     //   controlViewMoreComment: controlViewMoreComment,
        //     //   setViewMoreComment: setViewMoreComment,
        //     // ),
        //   ],
        // ),
        body: LoadingMoreList<Comment1>(ListConfig<Comment1>(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          sourceList: loadMoreComment,
          itemBuilder: (context, item, index) {
            // var items = list.map((e) => Post.fromJson(e)).toList();
            if (index == 0) {
              return Column(
                children: [
                  NameBar(
                    data: widget.data,
                    reloadState: widget.reloadState,
                    isPostpage: false,
                  ),
                  Caption(
                    reloadState: widget.reloadState,
                    data: widget.data,
                    isPostpage: false,
                  ),
                  if (widget.data.imageurl.isNotEmpty)
                    ImageBox(data: widget.data),
                  Divider(
                    indent: MediaQuery.of(context).size.width * 0.05,
                    endIndent: MediaQuery.of(context).size.width * 0.05,
                    thickness: 1,
                  ),
                  // Container(
                  //     decoration: const BoxDecoration(
                  //         border: Border(
                  //             bottom:
                  //                 BorderSide(color: Colors.grey, width: 0.2))),
                  //     height: 1,
                  //     width: MediaQuery.of(context).size.width * 0.9),
                  buttonSection,
                  Divider(
                      indent: MediaQuery.of(context).size.width * 0.05,
                      endIndent: MediaQuery.of(context).size.width * 0.05,
                      thickness: 1),
                  if (widget.data.reactions.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DisplayReact(
                          data: widget.data.reactions,
                          isRevert: false,
                          hideIcon: true),
                    )
                  ],
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text("More relevant",
                                style: Theme.of(context).textTheme.bodyMedium),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: themeManager.themeMode == dark
                                  ? whitee
                                  : const Color.fromARGB(255, 58, 59, 60),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return CommentTreeWidget<Comment1, Comment1>(
                item,
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
                  if (currUser != null) {
                    findUserReact(currUser!.name, data.reactions);
                  }
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              const Expanded(
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
                              DisplayReact(
                                  data: data.reactions,
                                  isRevert: true,
                                  hideIcon: true)
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            }
          },
          indicatorBuilder: (context, status) {
            switch (status) {
              case IndicatorStatus.loadingMoreBusying:
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case IndicatorStatus.error:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ErrorWidget('Not found'),
                  ),
                );
              case IndicatorStatus.noMoreLoad:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Come back tommrow!',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                );
              case IndicatorStatus.empty:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: Text('No posts available',
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                    ],
                  ),
                );
              case IndicatorStatus.fullScreenBusying:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Fullscreen Busying...',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                );
              case IndicatorStatus.none:
              case IndicatorStatus.fullScreenError:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Cannot load data',
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                );
            }
          },
        )),
      ),
    );
  }
}
