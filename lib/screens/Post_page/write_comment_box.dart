// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class CommentAppBar extends StatefulWidget {
  const CommentAppBar({
    Key? key,
    required this.data,
    required this.myController,
    required this.isKeyboard,
    // required this.myfocusNode,
    required this.instantUser,
  }) : super(key: key);

  final List<Comment1> data;
  final TextEditingController myController;
  final bool isKeyboard;
  // final FocusNode myfocusNode;
  final User instantUser;

  @override
  State<CommentAppBar> createState() => _CommentAppBarState();
}

class _CommentAppBarState extends State<CommentAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeManager.themeMode == dark ? lightdark : white,
        border: const Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.02,
          right: 12,
          left: 12,
          top: MediaQuery.of(context).size.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: TextField(
              controller: widget.myController,
              autocorrect: true,
              focusNode: AppDataProvider.of(context).commentPostPage,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
              ),
            ),
          ),
          Visibility(
            visible: widget.isKeyboard,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.camera_alt_outlined),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.gif_box_outlined),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(FontAwesomeIcons.faceSmile),
                        iconSize: 30,
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.gif_box_outlined),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.send),
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
