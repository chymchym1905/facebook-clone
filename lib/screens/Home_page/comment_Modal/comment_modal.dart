// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluttericon/mfg_labs_icons.dart';

import '../../../index.dart';
import '../../../utils/count_react.dart';

UserDummy instantUser = UserDummy("1905", "chymchym",
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

class _CommentModalState extends State<CommentModal>
    with WidgetsBindingObserver {
  late TextEditingController textController;
  bool isLike = false;
  List<bool> controlViewMoreComment = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    textController = TextEditingController();
    for(int i = 0; i < widget.data.comment.length; i++){
      controlViewMoreComment.add(true);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    if (value == 0 && MediaQuery.of(context).viewInsets.bottom != 0) {
      AppDataProvider.of(context).commentModal.unfocus();
      IndexComment.flagReply = false;
      IndexComment.flagReply2 = false;
    }
  }

  void setViewMoreComment(int index) {
    setState(() {
      controlViewMoreComment[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    List<int> listreact = List.filled(6, 0);
    countReact(widget.data.reactions, listreact);
    int totalReact = 0;
    int firsticon = 0;
    int secondicon = 0;
    for(int i = 0; i < listreact.length; i++){
      totalReact += listreact[i];
      if(listreact[i] > firsticon){
        secondicon = firsticon;
        firsticon = i;
      }
    }
    List<String> iconlist = [
      "like", ///0
      "love", ///1
      "haha", ///2
      "wow",  ///3
      "sad",  ///4
      "angry" ///5
    ];
    
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.end, 
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/viewreaction',arguments: widget.data.reactions);
                },
                child: Row(
                  children: [
                    Stack(
                      children: [
                        if(firsticon == 0)...[
                          Image.asset(
                            "assets/images/${iconlist[secondicon]}.png",
                            
                          )
                        ] else if (secondicon == 0) ...[
                           Image.asset("assets/images/${iconlist[firsticon]}.png")
                        ] else ...[
                          Image.asset("assets/images/${iconlist[secondicon]}.png"),
                          Image.asset("assets/images/${iconlist[firsticon]}.png")
                        ]
                      ],
                    ),
                    Text(
                      '$totalReact',
                       style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w300)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(
                        size: MediaQuery.of(context).size.width * 0.05,
                        MfgLabs.right_open,
                        color: themeManager.themeMode == dark
                          ? const Color.fromARGB(255, 234, 236, 238)
                          : const Color.fromARGB(255, 58, 59, 60),
                      ),
                    ),
                  ],
                )
              )
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isLike = !isLike;
                  });
                },
                icon: Icon(Icons.thumb_up_off_alt,
                    color: isLike ? const Facebook.blue().color : Colors.grey),
              )
            ),
        ]),
        Expanded(
          child: CommentSection(
            myfocusNode: AppDataProvider.of(context).commentModal,
            data: widget.data.comment,
            controlViewMoreComment: controlViewMoreComment,
            setViewMoreComment: setViewMoreComment,
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
              controlViewMoreComment: controlViewMoreComment,
              setViewMoreComment: setViewMoreComment,
            ),
          ),
        )
      ],
    );
  }
}
