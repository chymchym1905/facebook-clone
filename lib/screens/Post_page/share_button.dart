import 'package:flutter_application_1/screens/Post_page/share_modal.dart';

import '../../index.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({super.key, required this.data});

  final Post data;
  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton>
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
            // FocusScope.of(context).requestFocus(FocusNode());
            showModalBottomSheet<void>(
                transitionAnimationController: _animationController,
                useRootNavigator: true,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
                context: context,
                builder: (context) => shareModal(data: widget.data));
          },
          icon: const Icon(
            FontAwesomeIcons.share,
            size: 22,
            color: Colors.grey,
          ),
          label: Text(
            "Share",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
