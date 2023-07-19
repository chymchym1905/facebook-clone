// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:get/get.dart';
import '../../index.dart';
import 'comment_Modal/comment_button_modal.dart';
// import 'package:image_size_getter/image_size_getter.dart';
// import 'package:image_size_getter_http_input/image_size_getter_http_input.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key, required this.data}) : super(key: key);
  final Post data;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  void initState() {
    super.initState();
    // _data = widget.data;
  }

  void updateState(Post p) {
    setState(() {
      // AppDataProvider.of(context).currentViewData = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppDataProvider.of(context).currentViewData = widget.data;
    // AppDataProvider.of(context).updateCallback = (Post p) => updateState(p);

    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: themeManager.themeMode == dark ? lightdark : whitee,
          child: Column(
            children: [
              NameBar(
                  data: widget.data,
                  reloadState: updateState,
                  isPostpage: true),
              Caption(
                reloadState: updateState,
                data: widget.data,
                isPostpage: true,
              ),
              if (widget.data.imageurl.isNotEmpty) ImageBox(data: widget.data),
              Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2))),
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.9),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FBFullReaction(data: widget.data, reloadState: updateState),
                  CommentButtonModal(data: widget.data),
                  ShareButton(data: widget.data),
                ],
              ),
            ],
          ),
        ));
  }
}

class NameBar extends StatefulWidget {
  const NameBar({
    Key? key,
    required this.data,
    required this.reloadState,
    required this.isPostpage,
  }) : super(key: key);
  final Post data;
  final bool isPostpage;
  final Function(Post) reloadState;

  @override
  State<NameBar> createState() => _NameBarState();
}

class _NameBarState extends State<NameBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: themeManager.themeMode == dark
          ? const Color.fromARGB(255, 80, 82, 81)
          : const Color.fromARGB(255, 228, 228, 228),
      onTap: () => setState(() {
        if (widget.isPostpage) {
          Navigator.of(context).pushNamed('/posts',
              arguments:
                  Postpage(data: widget.data, reloadState: widget.reloadState));
        }
      }),
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage: imageAvatar(widget.data.user.imageurl)),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.user.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Text('Time ·',
                            style: Theme.of(context).textTheme.labelSmall),
                        const Icon(
                          Icons.public,
                          size: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: MediaQuery.of(context).size.width * 0.07,
                  icon: const Icon(Icons.more_horiz),
                  iconSize: 20,
                  color: Colors.grey,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Caption extends StatefulWidget {
  const Caption({
    Key? key,
    required this.isPostpage,
    required this.data,
    required this.reloadState,
  }) : super(key: key);
  final bool isPostpage;
  final Post data;
  final Function(Post) reloadState;

  @override
  State<Caption> createState() => _Caption();
}

class _Caption extends State<Caption> {
  // Post _data = Post("", UserDummy("", "", ""), "", [], 0, 0, 0, [], 0);

  // @override
  // void initState() {
  //   super.initState();
  //   // _data = widget.data;
  // }

  @override
  Widget build(BuildContext context) {
    // AppDataProvider.of(context).currentViewData = widget.data;
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => setState(() {
          if (widget.isPostpage) {
            Navigator.of(context).pushNamed('/posts',
                arguments: Postpage(
                    data: widget.data, reloadState: widget.reloadState));
          }
        }),
        child: Ink(
          color: themeManager.themeMode == dark ? lightdark : whitee,
          child: Text(
            widget.data.caption,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}




// class Interactions extends StatefulWidget {
//   const Interactions({
//     Key? key,
//     required this.data,
//   }) : super(key: key);
//   final Post data;

//   @override
//   State<Interactions> createState() => _InteractionsState();
// }

// class _InteractionsState extends State<Interactions> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             FbReaction(),
//             CommentButtonModal(data: widget.data),
//             ShareButton(data: widget.data)
//           ]),
//     );
//   }
// }
