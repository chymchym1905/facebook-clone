// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class ReplyButton extends StatelessWidget {
  const ReplyButton(
      {super.key,
      required this.indexforreply1,
      required this.indexforreply2,
      required this.myfocusNode,
      required this.flagReply,
      required this.flagReply2,
      this.parentID,
      this.grandParentID});
  final String? parentID;
  final String? grandParentID;
  final int indexforreply1;
  final int indexforreply2;
  final bool flagReply;
  final bool flagReply2;
  final FocusNode myfocusNode;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (parentID != null) {
          CommentHelper.parentCommentId = parentID!;
        }
        if (grandParentID != null) {
          CommentHelper.grandParentCommentId = grandParentID!;
        }
        myfocusNode.requestFocus();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 10),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text('Reply',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              // fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 109, 107, 107))),
    );
  }
}
