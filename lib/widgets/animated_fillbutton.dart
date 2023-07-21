import '../index.dart';

class AnimatedFillButton extends StatefulWidget {
  const AnimatedFillButton(
      {super.key,
      this.buttonColor,
      required this.buttonSize,
      this.content,
      this.icon});
  final Color? buttonColor;
  final Size buttonSize;
  final Text? content;
  final Icon? icon;

  @override
  State<AnimatedFillButton> createState() => _AnimatedFillButtonState();
}

class _AnimatedFillButtonState extends State<AnimatedFillButton>
    with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<Size> _animation;
  bool shrink = false;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 300),
    // );
    // var buttonSizeShrink =
    //     Size(widget.buttonSize.width * 0.95, widget.buttonSize.height * 0.95);
    // _animation = Tween<Size>(begin: widget.buttonSize, end: buttonSizeShrink)
    //     .animate(_animationController);
  }

  void grow() {
    setState(() {});
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = widget.buttonSize.width;
    double h = widget.buttonSize.height;
    return GestureDetector(
      onTapUp: (d) {
        setState(() {
          shrink = true;
          print(shrink);
          // print('${w} + ${h}');
        });
      },
      onTapDown: (d) {
        setState(() {
          shrink = false;
          print('${shrink}123123');
          // print('${w} + ${h}');
        });
      },
      child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 100),
          width: shrink ? w : w * 0.95,
          height: shrink ? h : h * 0.95,
          decoration: BoxDecoration(
              color: themeManager.themeMode == dark
                  ? const Color.fromARGB(255, 58, 59, 60)
                  : const Color.fromARGB(255, 228, 230, 235),
              borderRadius: BorderRadius.circular(6)),
          child: Center(child: widget.icon ?? widget.content)),
    );
  }
}
