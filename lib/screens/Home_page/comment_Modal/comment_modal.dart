// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../index.dart';

UserDummy instantUser = UserDummy("1905", "chymchym",
    "https://images-ext-1.discordapp.net/external/83wYKef0YpM6goED9-quM6SXFOKhWDKy80KMmlQcSxI/https/pbs.twimg.com/media/FzSxbZfaUAAVGeu.jpg?width=376&height=670");

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    textController = TextEditingController();
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
      AppDataProvider.of(context).commentModal.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isLike = !isLike;
                  });
                },
                icon: Icon(Icons.thumb_up_off_alt,
                    color: isLike ? const Facebook.blue().color : Colors.grey),
              )),
        ]),
        Expanded(
          child: CommentSection(
            myfocusNode: AppDataProvider.of(context).commentModal,
            data: widget.data.comment,
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: WriteCommentBox(
              data: widget.data.comment,
              myfocusNode: AppDataProvider.of(context).commentModal,
              isKeyboard: isKeyboard,
              myController: textController,
              instantUser: instantUser,
            ),
          ),
        )
      ],
    );
  }
}