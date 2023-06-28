import '../index.dart';

class CommentAppBar extends StatefulWidget {
  const CommentAppBar({
    super.key,
    required this.myfocusNode, 
    required this.isKeyboard,
    required this.myController
  });
  final TextEditingController myController;
  final bool isKeyboard;
  final FocusNode myfocusNode;
  @override
  State<CommentAppBar> createState() => _CommentAppBarState();
}

class _CommentAppBarState extends State<CommentAppBar> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width:0.2 )
        ),
      ),
      padding: const EdgeInsets.only(bottom: 12, right: 12, left: 12, top: 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(
            controller: widget.myController,
            autocorrect: true,
            focusNode: widget.myfocusNode,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: const TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      width: 0, 
                      style: BorderStyle.none,
                  ),
              ),
              filled: true,
              fillColor: Colors.grey,
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

class CommentButton extends StatefulWidget {
  const CommentButton({super.key, required this.myfocusNode});
  final FocusNode myfocusNode;
  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: (){
            widget.myfocusNode.requestFocus();
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