import '../../index.dart';

const _blue = Facebook.blue();

class Postpage extends StatefulWidget {
  const Postpage({Key? key, required this.data}) : super(key: key);
  final Post data;

  @override
  State<Postpage> createState() => _PostPageState();
}

class _PostPageState extends State<Postpage> {
  final myfocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();
  late TextEditingController myController;
  int countCommentAdd = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    myController = TextEditingController()
      ..addListener(() {
        setState(() {
          countCommentAdd++;
        });
      });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  scrollListener() {
    setState(() {
      // print(scrollController.offset);
    });
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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Text(
        widget.data.caption,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
    Widget buttonSection = Column(children: [
      Container(
        height: 0.2,
        color: Colors.grey,
        width: MediaQuery.of(context).size.width * 0.9,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const FbReaction(),
          CommentButton(node: AppDataProvider.of(context).commentPostPage),
          ShareButton(data: widget.data),
        ],
      ),
      Container(
        height: 0.2,
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
      ),
    ]);
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
                  controller: scrollController,
                  children: [
                    pagename,
                    textfeed,
                    buttonSection,
                    iconSection,
                    CommentSection(
                      data: widget.data.comment,
                      myController: myController,
                      countCommentAdd: countCommentAdd,
                    ),
                  ],
                ),
              ),
              CommentAppBar(
                isKeyboard: isKeyboard,
                myController: myController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
