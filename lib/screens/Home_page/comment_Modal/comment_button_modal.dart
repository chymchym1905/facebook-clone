// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../index.dart';
import 'comment_modal.dart';

class CommentButtonModal extends StatefulWidget {
  const CommentButtonModal({
    Key? key,
    required this.data, 
  }) : super(key: key);
  final Post data;
  @override
  State<CommentButtonModal> createState() => _CommentButtonModalState();
}

class _CommentButtonModalState extends State<CommentButtonModal>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {
            showModalBottomSheet(
                transitionAnimationController: _animationController,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top),
                useRootNavigator: true,
                isScrollControlled: true,
                backgroundColor:
                    themeManager.themeMode == dark ? lightdark : white,
                context: context,
                builder: (context) {
                  return GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: CommentModal(data: widget.data));
                });
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
