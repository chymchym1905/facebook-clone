// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../data/focusNode.dart';
import '../../../index.dart';
import '../../../utils/display_react.dart';

class CommentModal extends StatefulWidget {
  const CommentModal({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Post data;
  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal>
    with WidgetsBindingObserver {
  late TextEditingController textController;
  bool isLike = false;
  List<bool> controlViewMoreComment = [];
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
      // AppDataProvider.of(context).commentModal.unfocus();
      Provider.of<FocusNodeProvider>(context, listen: false)
          .commentModal
          .unfocus();
      IndexReply.flagReply = false;
      IndexReply.flagReply2 = false;
    }
  }

  void setViewMoreComment(int index) {
    setState(() {
      controlViewMoreComment[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.data.reactions.isNotEmpty) ...[
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
                child: DisplayReact(
                    data: widget.data.reactions,
                    isRevert: false,
                    hideIcon: false)),
            Container(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isLike = !isLike;
                    });
                  },
                  icon: Icon(Icons.thumb_up_off_alt,
                      color:
                          isLike ? const Facebook.blue().color : Colors.grey),
                )),
          ])
        ],
        TextButton(
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
        Expanded(
          child: CommentSection(
            myfocusNode: Provider.of<FocusNodeProvider>(context).commentModal,
            data: widget.data.comment,
            controlViewMoreComment: controlViewMoreComment,
            setViewMoreComment: setViewMoreComment,
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: WriteCommentBox(
              data: widget.data,
              myfocusNode: Provider.of<FocusNodeProvider>(context).commentModal,
              isKeyboard: isKeyboard,
              myController: textController,
              instantUser: currUser!,
              controlViewMoreComment: controlViewMoreComment,
              setViewMoreComment: setViewMoreComment,
            ),
          ),
        )
      ],
    );
  }
}
