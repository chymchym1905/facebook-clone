import 'package:scroll_to_index/scroll_to_index.dart';

import '../../index.dart';

class GalleryViewPage extends StatefulWidget {
  const GalleryViewPage(
      {super.key, required this.initialIndex, required this.data});
  final int initialIndex;
  final Post data;
  @override
  State<GalleryViewPage> createState() => _GalleryViewPageState();
}

class _GalleryViewPageState extends State<GalleryViewPage>
    with SingleTickerProviderStateMixin {
  late int currentIndex;
  late final AnimationController _animationController;
  late AutoScrollController autoScrollController;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              splashRadius: MediaQuery.of(context).size.width * 0.07,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                finish(context);
              }),
        ),
      ),
    );
  }
}
