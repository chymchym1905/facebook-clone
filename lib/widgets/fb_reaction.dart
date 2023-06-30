import '../index.dart';

class FbReaction extends StatefulWidget {
  const FbReaction({super.key});

  @override
  State<FbReaction> createState() => _FbReactionState();
}

class _FbReactionState extends State<FbReaction> with TickerProviderStateMixin {
  bool _isLike = false;
  Widget renderBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 0.3),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              // LTRB
              offset: Offset.lerp(
                  const Offset(0.0, 0.0), const Offset(0.0, 0.5), 10.0)!),
        ],
      ),
      width: 300.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onLongPress: () {},
          onPressed: () {
            setState(() {
              _isLike = !_isLike;
            });
          },
          icon: Icon(
            Icons.thumb_up_off_alt,
            color: _isLike ? const Facebook.blue().color : Colors.grey,
          ),
          label: Text(
            'Like',
            style: Theme.of(context).textTheme.labelSmall?.merge(TextStyle(
                color: _isLike ? const Facebook.blue().color : Colors.grey)),
          ),
        ),
      ],
    );
  }
}
