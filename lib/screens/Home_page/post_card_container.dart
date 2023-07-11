// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key, required this.data}) : super(key: key);
  final Post data;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // Post _data = Post("", UserDummy("", "", ""), "", [], 0, 0, 0, [], 0);
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

  // void navigate(BuildContext context) {
  //   setState(() {
  //     Navigator.of(context).pushNamed('/posts');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // AppDataProvider.of(context).currentViewData = widget.data;
    AppDataProvider.of(context).updateCallback = (Post p) => updateState(p);
    // AppDataProvider.of(context).navigateCallback = (c) => navigate(c);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: themeManager.themeMode == dark ? lightdark : white,
        child: InkWell(
          onTap: () => setState(() {
            Navigator.of(context).pushNamed('/posts',
                arguments:
                    Postpage(data: widget.data, reloadState: updateState));
          }),
          child: Ink(
            child: FBFullReaction(
                reloadState: updateState, data: widget.data, isPostcard: true),
          ),
        ),
      ),
    );
  }
}

class NameBar extends StatelessWidget {
  const NameBar({
    Key? key,
    required this.imageUrl,
    required this.username,
  }) : super(key: key);

  final String imageUrl;
  final String username;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username, style: Theme.of(context).textTheme.titleMedium),
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
          color: themeManager.themeMode == dark ? lightdark : white,
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

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    Key? key,
    required this.images,
  }) : super(key: key);
  final List<String> images;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
