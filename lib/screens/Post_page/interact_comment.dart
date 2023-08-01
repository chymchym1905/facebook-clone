import '../../index.dart';

class DisplayComment extends StatefulWidget {
  const DisplayComment(
      {super.key,
      required this.data,
      this.index1,
      required this.reloadComment});
  final List<Comment1> data;
  final int? index1;
  final Function(List<Comment1>) reloadComment;

  @override
  State<DisplayComment> createState() => _DisplayCommentState();
}

class _DisplayCommentState extends State<DisplayComment>
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
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet<void>(
            transitionAnimationController: _animationController,
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            context: context,
            builder: (context) => const InteractComment());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            color: themeManager.themeMode == dark
                ? const Color.fromARGB(255, 58, 59, 60)
                : const Color.fromARGB(255, 241, 242, 246),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.data[widget.index1!].user.name,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.data[widget.index1!].content,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontStyle: FontStyle.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class InteractComment extends StatefulWidget {
  const InteractComment({super.key});

  @override
  State<InteractComment> createState() => _InteractCommentState();
}

class _InteractCommentState extends State<InteractComment> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Container(
        color: themeManager.themeMode == dark
            ? const Color.fromARGB(255, 38, 38, 38)
            : whitee,
        child: Column(
          children: [
            // Row(),
            TextButton.icon(
              onPressed: () {},
              label: Text("Reply"),
              icon: Icon(FontAwesomeIcons.message),
            )
          ],
        ),
      ),
    );
  }
}
