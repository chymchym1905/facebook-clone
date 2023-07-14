import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
// import 'package:get/get.dart';
import '../../index.dart';

class GalleryViewPage extends StatefulWidget {
  GalleryViewPage(
      {super.key,
      required this.initialIndex,
      required this.data,
      required this.isPostpage})
      : pageController = PageController(initialPage: initialIndex);
  final int initialIndex;
  final bool isPostpage;
  final Post data;
  final PageController pageController;
  @override
  State<GalleryViewPage> createState() => _GalleryViewPageState();
}

class _GalleryViewPageState extends State<GalleryViewPage>
    with SingleTickerProviderStateMixin {
  late int currentIndex;
  bool _visible = true;
  late AutoScrollController autoScrollController;
  bool notClickBelow = true;
  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
    autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeManager.themeMode == dark
          ? const Color.fromARGB(255, 38, 38, 38)
          : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        // foregroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              splashRadius: MediaQuery.of(context).size.width * 0.07),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _visible = !_visible;
              });
            },
            child: SizedBox(
              height: context.height,
              child: PhotoViewGallery.builder(
                itemCount: widget.data.imageurl.length,
                scrollPhysics: const RangeMaintainingScrollPhysics(),
                pageController: widget.pageController,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                      tightMode: true,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 1.1,
                      imageProvider: CachedNetworkImageProvider(
                          widget.data.imageurl[index]),
                      initialScale: PhotoViewComputedScale.contained,
                      heroAttributes: PhotoViewHeroAttributes(tag: index));
                },
                onPageChanged: (index) async {
                  setState(() {
                    currentIndex = index;
                  });
                  if (notClickBelow) {
                    await autoScrollController.scrollToIndex(index,
                        preferPosition: AutoScrollPosition.middle);
                  }
                },
                loadingBuilder: (context, loadingProgress) => Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress!.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _visible ? 1 : 0,
            child: Container(
              height: 100,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: autoScrollController,
                  itemCount: widget.data.imageurl.length,
                  itemBuilder: (context, index) {
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: autoScrollController,
                      index: index,
                      child: GestureDetector(
                        onTap: () async {
                          notClickBelow = false;
                          await autoScrollController.scrollToIndex(index,
                              preferPosition: AutoScrollPosition.middle);
                          await widget.pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeInOut);
                          notClickBelow = true;
                        },
                        child: Card(
                            child: CachedNetworkImage(
                                imageUrl: widget.data.imageurl[index])),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
