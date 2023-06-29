// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
