// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class ReplyButton extends StatelessWidget {
  const ReplyButton({
    super.key, 
    required this.indexforreply1, 
    required this.indexforreply2, 
    required this.myfocusNode
  });
  final int indexforreply1;
  final int indexforreply2;
  final FocusNode myfocusNode;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        IndexComment.flagReply = false;
        IndexComment.flagReply2 = true;
        IndexComment.intdex = indexforreply1;
        IndexComment.intdex2 = indexforreply2;
        myfocusNode.requestFocus();
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
    );
  }
}