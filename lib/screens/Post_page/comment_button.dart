// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../data/focusNode.dart';
import '../../index.dart';

class CommentButton extends StatefulWidget {
  const CommentButton({
    Key? key,
    // required this.node,
  }) : super(key: key);
  // final FocusNode node;
  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {
            IndexReply.flagReply = false;
            IndexReply.flagReply2 = false;
            Provider.of<FocusNodeProvider>(context, listen: false)
                .commentPostPage
                .requestFocus();
          },
          icon: const Icon(
            FontAwesomeIcons.message,
            size: 22,
            color: Colors.grey,
          ),
          label: Text(
            "Comment",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
