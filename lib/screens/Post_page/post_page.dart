import '../../index.dart';

const _blue = Facebook.blue();

class IndexComment {
  static int intdex = 0;
  static bool flagReply = false;
  static bool flagReply2 = false;
}

class Postpage extends StatefulWidget {
  const Postpage({Key? key, required this.data}) : super(key: key);
  final Post data;

  @override
  State<Postpage> createState() => _PostPageState();
}

class _PostPageState extends State<Postpage> with WidgetsBindingObserver {
  // final myfocusNode = FocusNode();
  late TextEditingController textController;
  User instantUser = User("2002", "Danny", "http://loremflickr.com/640/480");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    textController = TextEditingController();
    //   ..addListener(() {
    //     setState(() {
    //   });
    // });
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

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    Widget pagename = Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage(widget.data.user.imageurl),
              ),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  widget.data.user.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Row(
                children: [
                  // Text(
                  //   '${widget.data.timeAgo} ·',
                  //   style: Theme.of(context).textTheme.labelSmall
                  // ),
                  Icon(
                    Icons.public,
                    size: 10,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          )),
          IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.07,
            icon: const Icon(Icons.more_horiz),
            iconSize: 20,
            color: Colors.grey,
            onPressed: () {},
          )
        ],
      ),
    );
    Widget textfeed = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        widget.data.caption,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
    Widget buttonSection = Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const FbReaction(),
          CommentButton(),
          ShareButton(data: widget.data),
        ],
      ),
    );
    Widget iconSection = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _blue.color,
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
                onPressed: () => Navigator.pop(context, false)),
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
                    pagename,
                    textfeed,
                    buttonSection,
                    iconSection,
                    CommentSection(
                      myfocusNode: AppDataProvider.of(context).commentPostPage,
                      data: widget.data.comment,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
