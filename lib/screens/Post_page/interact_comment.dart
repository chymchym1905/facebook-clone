import '../../index.dart';

class DisplayComment extends StatefulWidget {
  const DisplayComment(
      {super.key,
      required this.data,
      this.index1,
      required this.reloadComment,
      this.index2,
      required this.commentDisplay,
      this.index3});
  final List<Comment1> data;
  final int? index1;
  final int? index2;
  final int? index3;
  final Comment1 commentDisplay;
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
        // if (widget.index3 != null) {
        //   IndexComment.intdex1 = widget.index1!;
        //   IndexComment.intdex2 = widget.index2!;
        //   IndexComment.intdex3 = widget.index3!;
        //   widget.data[widget.index1!].reply[widget.index2!].reply
        //       .removeAt(widget.index3!);
        // } else if (widget.index2 != null) {
        //   IndexComment.intdex1 = widget.index1!;
        //   IndexComment.intdex2 = widget.index2!;
        //   widget.data[widget.index1!].reply.removeAt(widget.index2!);
        // } else {
        //   IndexComment.intdex1 = widget.index1!;
        //   widget.data.removeAt(widget.index1!);
        // }
        // widget.reloadComment(widget.data);
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
            Text(widget.commentDisplay.user.name,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.commentDisplay.content,
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
    List<String> listicon = [
      "like",
      "love",
      "haha",
      "wow",
      "sad",
      "angry",
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        color: themeManager.themeMode == dark
            ? const Color.fromARGB(255, 38, 38, 38)
            : whitee,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < listicon.length; i++) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Image.asset(
                      "assets/images/${listicon[i]}.gif",
                      width: 35,
                      height: 35,
                    ),
                  )
                ]
              ],
            ),
            Center(
              child: Text("React to this comment",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey)),
            ),
            TextButton.icon(
              onPressed: () {},
              label:
                  Text("Reply", style: Theme.of(context).textTheme.titleMedium),
              icon: Icon(FontAwesomeIcons.message,
                  color: themeManager.themeMode == dark
                      ? whitee
                      : const Color.fromARGB(255, 58, 59, 60)),
            )
          ],
        ),
      ),
    );
  }
}
