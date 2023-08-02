// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class ReplyButton extends StatelessWidget {
  const ReplyButton(
      {super.key,
      required this.indexforreply1,
      required this.indexforreply2,
      required this.myfocusNode,
      required this.flagReply,
      required this.flagReply2});
  final int indexforreply1;
  final int indexforreply2;
  final bool flagReply;
  final bool flagReply2;
  final FocusNode myfocusNode;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        IndexReply.flagReply = false;
        IndexReply.flagReply2 = true;
        IndexReply.flagReply = flagReply;
        IndexReply.flagReply2 = flagReply2;
        IndexReply.intdex = indexforreply1;
        IndexReply.intdex2 = indexforreply2;
        myfocusNode.requestFocus();
      },
      // style: ButtonStyle(
      //   fixedSize:
      //       MaterialStateProperty.resolveWith((states) {
      //     final textStyle =
      //         Theme.of(context).textTheme.labelMedium!;
      //     final textWidth = TextPainter(
      //       text:
      //           TextSpan(text: 'Reply', style: textStyle),
      //       textDirection: TextDirection.ltr,
      //     )..layout();
      //     final textHeight = textWidth.size.height;

      //     return Size(textWidth.size.width, textHeight);
      //   }),
      // ),
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
