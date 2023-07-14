import 'package:cached_network_image/cached_network_image.dart';
import '../index.dart';
import 'package:collection/collection.dart';
// import 'package:get/get.dart';
import '../screens/Gallery_view_pages/galleryview.dart';

Widget oneItem(Post data) => StaggeredGrid.count(
        crossAxisCount: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: ImageTile(
                  src: data.imageurl[0],
                  height: 100,
                  width: 100,
                  index: 0,
                  data: data))
        ]);

Widget twoItem(Post data) => StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          ...data.imageurl.mapIndexed((index, e) => StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: ImageTile(
                  src: e, height: 200, width: 200, index: index, data: data))),
        ]);

Widget twoItemRevert(Post data) => StaggeredGrid.count(
        crossAxisCount: 2,
        axisDirection: AxisDirection.down,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          ...data.imageurl.mapIndexed((index, e) => StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 2,
              child: ImageTile(
                  src: e, height: 200, width: 100, index: index, data: data))),
        ]);

Widget threeItem(Post data) => StaggeredGrid.count(
        crossAxisCount: 6,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          ...data.imageurl.mapIndexed((index, element) {
            return StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: ImageTile(
                    height: 200,
                    width: 200,
                    src: element,
                    index: index,
                    data: data));
          })
        ]);

Widget fourItem(Post data) => StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          ...data.imageurl.mapIndexed((index, e) {
            return StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: ImageTile(
                    height: 100, width: 100, src: e, index: index, data: data));
          })
        ]);

Widget fourItem2(Post data) => StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          ...data.imageurl.mapIndexed((index, e) {
            if (index == 0) {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 3,
                  child: ImageTile(
                      height: 200,
                      width: 100,
                      src: e,
                      index: index,
                      data: data));
            } else {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: ImageTile(
                      height: 100,
                      width: 100,
                      src: e,
                      index: index,
                      data: data));
            }
          })
        ]);

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.data,
    required this.index,
    required this.width,
    required this.height,
    required this.src,
  }) : super(key: key);
  final Post data;
  final int index;
  final String src;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          // print(ModalRoute.of(context)!.currentResult);
          Navigator.of(context).pushNamed('/gallery',
              arguments: GalleryViewPage(
                  data: data, initialIndex: index, isPostpage: false));
          // Get.to(GalleryViewPage(
          //     data: data, initialIndex: index, isPostpage: false));
          // GalleryViewPage(data: data, initialIndex: index, isPostpage: false)
          //     .launch(context)
          //     .then((value) {
          //   if (value != null) print(value);
          // });
        },
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: src,
          fadeOutDuration: const Duration(milliseconds: 500),
          fadeInDuration: const Duration(milliseconds: 500),
          // progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          //     child: CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    });
  }
}

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  final List<Color> _colors = [
    const Color.fromARGB(255, 175, 175, 175),
    const Color.fromARGB(255, 134, 131, 131)
  ];
  int _currentColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _colorAnimation = _controller.drive(
        ColorTween(begin: _colors[_currentColorIndex], end: _getNextColor()));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getNextColor() {
    _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
    return _colors[_currentColorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          color: _colorAnimation.value,
        );
      },
    );
  }
}
