// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../data/post.dart';
import '../../index.dart';
import '../../utils/commentlist.dart';

class WriteCommentBox extends StatefulWidget {
  const WriteCommentBox({
    Key? key,
    required this.data,
    required this.myController,
    required this.isKeyboard,
    required this.myfocusNode,
    this.comment,
    required this.scrollDown,
  }) : super(key: key);

  final Post data;
  final TextEditingController myController;
  final bool isKeyboard;
  final FocusNode myfocusNode;
  final LoadMoreComment? comment;
  final Function scrollDown;
  // final List<bool> controlViewMoreComment;
  // final Function(int) setViewMoreComment;

  @override
  State<WriteCommentBox> createState() => _WriteCommentBoxState();
}

class _WriteCommentBoxState extends State<WriteCommentBox> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: themeManager.themeMode == dark ? lightdark : whitee,
        border: const Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.02,
          right: 12,
          left: 12,
          top: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              controller: widget.myController,
              // autocorrect: true,
              focusNode: widget.myfocusNode,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
              ),
            ),
          ),
          Visibility(
            visible: widget.isKeyboard,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.camera_alt_outlined),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.gif_box_outlined),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(FontAwesomeIcons.faceSmile),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.gif_box_outlined),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //write comment
                    if (widget.myController.text.toString().isNotEmpty) {
                      // if (IndexReply.flagReply2) {
                      //   Comment1 newComment = Comment1.level3(
                      //       "",
                      //       CommentHelper.parentCommentId,
                      //       CommentHelper.grandParentCommentId,
                      //       currUser!,
                      //       widget.myController.text.toString(),
                      //       reactionCount: 0); // không sửa
                      //   widget.data.comment[IndexReply.intdex]
                      //       .reply[IndexReply.intdex2].reply
                      //       .add(newComment);
                      //   Database().writeComment(
                      //       widget.data.id, newComment, CommentLevel.three);
                      // } else {
                      //   if (IndexReply.flagReply) {
                      //     Comment1 newComment = Comment1.level2(
                      //         "",
                      //         CommentHelper.parentCommentId,
                      //         currUser!,
                      //         widget.myController.text.toString(),
                      //         reactionCount: 0); // không sửa
                      //     widget.data.comment[IndexReply.intdex].reply
                      //         .add(newComment);
                      //     Database().writeComment(
                      //         widget.data.id, newComment, CommentLevel.two);
                      //   } else {
                      //     Comment1 newComment = Comment1("", widget.instantUser,
                      //         widget.myController.text.toString(),
                      //         reactionCount: 0); // không sửa
                      //     widget.data.comment.add(newComment);
                      //     Database().writeComment(
                      //         widget.data.id, newComment, CommentLevel.one);
                      //   }
                      // }
                      if (CommentHelper.grandParentCommentId.isEmpty &&
                          CommentHelper.parentCommentId.isEmpty) {
                        Comment1 newComment = Comment1(
                            "", currUser!, widget.myController.text.toString(),
                            reactionCount: 0); // không sửa
                        postProvider.addCommentLevel1(
                            widget.data.id, newComment);
                        Database().writeComment(
                            widget.data.id, newComment, CommentLevel.one);
                        widget.comment!.hasMore = true;
                        widget.comment!.insert(0, newComment);
                      }
                      // widget.controlViewMoreComment.add(true);
                      // if (IndexReply.flagReply || IndexReply.flagReply2) {
                      //   widget.setViewMoreComment(IndexReply.intdex);
                      // }
                    }
                    CommentHelper.parentCommentId = "";
                    CommentHelper.grandParentCommentId = "";
                    // widget.comment!.refresh();
                    widget.myController.clear();
                    widget.myfocusNode.unfocus();
                  },
                  icon: const Icon(Icons.send),
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
