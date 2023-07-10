// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class IndexComment {
  static int intdex = -1;
  static int intdex2 = -1;
  static bool flagReply = false;
  static bool flagReply2 = false;
}

class Postpage extends StatefulWidget {
  const Postpage({
    Key? key,
    required this.data,
    required this.reloadState,
  }) : super(key: key);
  final Post data;
  final Function(Post) reloadState;

  @override
  State<Postpage> createState() => _PostPageState();
}

class _PostPageState extends State<Postpage> with WidgetsBindingObserver {
  // final myfocusNode = FocusNode();
  late TextEditingController textController;
  UserDummy instantUser =
      UserDummy("2002", "Danny", "http://loremflickr.com/640/480");
  List<bool> controlViewMoreComment = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    textController = TextEditingController();
    for (int i = 0; i < widget.data.comment.length; i++) {
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
      AppDataProvider.of(context).commentPostPage.unfocus();
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

    Widget iconSection = Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            widget.data.likes.toString(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
    // Widget comment = CommentSection(data: commentLi);
    return MaterialApp(
      theme: themeManager.themeMode,
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: themeManager.themeMode == dark
              ? const Color.fromARGB(255, 38, 38, 38)
              : Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                splashRadius: MediaQuery.of(context).size.width * 0.07,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  AppDataProvider.of(context).updateCallback(widget.data);
                  Navigator.pop(
                      context,
                      Postpage(
                          data: widget.data, reloadState: widget.reloadState));
                }),
            title: Text(widget.data.user.name,
                style: Theme.of(context).textTheme.titleLarge),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  splashRadius: MediaQuery.of(context).size.width * 0.07),
            ],
            // bottom: ,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    FBFullReaction(
                      reloadState: widget.reloadState,
                      data: widget.data,
                      isPostcard: false,
                      // reloadState: widget.reloadState,
                    ),
                    iconSection,
                    CommentSection(
                      myfocusNode: AppDataProvider.of(context).commentPostPage,
                      data: widget.data.comment,
                      controlViewMoreComment: controlViewMoreComment,
                      setViewMoreComment: setViewMoreComment,
                    ),
                  ],
                ),
              ),
              WriteCommentBox(
                data: widget.data.comment,
                myfocusNode: AppDataProvider.of(context).commentPostPage,
                isKeyboard: isKeyboard,
                myController: textController,
                instantUser: instantUser,
                controlViewMoreComment: controlViewMoreComment,
                setViewMoreComment: setViewMoreComment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
