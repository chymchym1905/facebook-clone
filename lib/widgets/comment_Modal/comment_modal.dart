// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

User instantUser = User("1905", "chymchym",
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

class _CommentModalState extends State<CommentModal> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Column(
      children: [
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
