// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';

import '../index.dart';
import '../screens/Gallery_view_pages/galleryview.dart';

Widget oneItem(Post? data, List<Media>? media) => StaggeredGrid.count(
        crossAxisCount: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: data != null
                  ? ImageTile.network(
                      src: data.imageurl[0],
                      height: 100,
                      width: 100,
                      index: 0,
                      data: data)
                  : ImageTile.memory(
                      mediaList: media!,
                      memoryImageBytes: media[0].mediaByte!,
                      index: 0,
                      width: 100,
                      height: 100))
        ]);

Widget twoItem(Post? data, List<Media>? media) => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        if (data != null)
          ...data.imageurl
              .mapIndexed((index, e) => StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: ImageTile.network(
                      src: e,
                      height: 200,
                      width: 200,
                      index: index,
                      data: data)))
              .toList(),
        if (media != null)
          ...media
              .mapIndexed((index, element) => StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: ImageTile.memory(
                      mediaList: media,
                      memoryImageBytes: element.mediaByte!,
                      index: index,
                      width: 200,
                      height: 200)))
              .toList(),
      ],
    );

Widget twoItemVertical(Post? data, List<Media>? media) => StaggeredGrid.count(
        crossAxisCount: 2,
        axisDirection: AxisDirection.down,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          if (data != null)
            ...data.imageurl.mapIndexed((index, e) => StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 2,
                child: ImageTile.network(
                    src: e,
                    height: 200,
                    width: 100,
                    index: index,
                    data: data))),
          if (media != null)
            ...media.mapIndexed((index, element) => StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 2,
                child: ImageTile.memory(
                    mediaList: media,
                    memoryImageBytes: element.mediaByte!,
                    index: index,
                    width: 100,
                    height: 200)))
        ]);

Widget threeItem(Post? data, List<Media>? media) => StaggeredGrid.count(
        crossAxisCount: 6,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          if (data != null)
            ...data.imageurl.mapIndexed((index, element) {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: ImageTile.network(
                      height: 200,
                      width: 200,
                      src: element,
                      index: index,
                      data: data));
            }),
          if (media != null)
            ...media.mapIndexed((index, element) => StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: ImageTile.memory(
                    mediaList: media,
                    memoryImageBytes: element.mediaByte!,
                    index: index,
                    width: 200,
                    height: 200)))
        ]);

Widget fourItem(Post? data, List<Media>? media) => StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          if (data != null)
            ...data.imageurl.mapIndexed((index, e) {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 2,
                  child: ImageTile.network(
                      height: 100,
                      width: 100,
                      src: e,
                      index: index,
                      data: data));
            }),
          if (media != null)
            ...media.mapIndexed((index, element) => StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: ImageTile.memory(
                    mediaList: media,
                    memoryImageBytes: element.mediaByte!,
                    index: index,
                    width: 100,
                    height: 100)))
        ]);

Widget fourItem2(Post? data, List<Media>? media) => StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          if (data != null)
            ...data.imageurl.mapIndexed((index, e) {
              if (index == 0) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 3,
                    child: ImageTile.network(
                        height: 200,
                        width: 100,
                        src: e,
                        index: index,
                        data: data));
              } else {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: ImageTile.network(
                        height: 100,
                        width: 100,
                        src: e,
                        index: index,
                        data: data));
              }
            }),
          if (media != null)
            ...media.mapIndexed((index, e) {
              if (index == 0) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 3,
                    child: ImageTile.memory(
                        height: 200,
                        width: 100,
                        mediaList: media,
                        index: index,
                        memoryImageBytes: e.mediaByte!));
              } else {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: ImageTile.memory(
                        height: 100,
                        width: 100,
                        mediaList: media,
                        index: index,
                        memoryImageBytes: e.mediaByte!));
              }
            })
        ]);

Widget fiveItemHorizontal(Post? data, List<Media>? media) =>
    StaggeredGrid.count(
      crossAxisCount: 6,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        if (data != null)
          ...data.imageurl.mapIndexed((index, element) {
            if (index == 1 || index == 2) {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 1.5,
                  child: ImageTile.network(
                    data: data,
                    src: element,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            } else {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: ImageTile.network(
                    data: data,
                    src: element,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            }
          }),
        if (media != null)
          ...media.mapIndexed((index, element) {
            if (index == 1 || index == 2) {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 3,
                  mainAxisCellCount: 1.5,
                  child: ImageTile.memory(
                    mediaList: media,
                    memoryImageBytes: element.mediaByte!,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            } else {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: ImageTile.memory(
                    mediaList: media,
                    memoryImageBytes: element.mediaByte!,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            }
          })
      ],
    );

Widget fiveItemVertical(Post? data, List<Media>? media) => StaggeredGrid.count(
      axisDirection: AxisDirection.down,
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        if (data != null)
          ...data.imageurl.mapIndexed((index, element) {
            if (index == 0 || index == 3) {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1.5,
                  child: ImageTile.network(
                    data: data,
                    src: element,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            } else {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: ImageTile.network(
                    data: data,
                    src: element,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            }
          }),
        if (media != null)
          ...media.mapIndexed((index, element) {
            if (index == 0 || index == 3) {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1.5,
                  child: ImageTile.memory(
                    mediaList: media,
                    memoryImageBytes: element.mediaByte!,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            } else {
              return StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: ImageTile.memory(
                    mediaList: media,
                    memoryImageBytes: element.mediaByte!,
                    index: index,
                    width: 100,
                    height: 100,
                  ));
            }
          })
      ],
    );

Widget batchImages(Post? data, List<Media>? media, BuildContext context) =>
    StaggeredGrid.count(
        // axisDirection: AxisDirection.down,
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          if (data != null)
            ...data.imageurl.mapIndexed((index, element) {
              if (index == 0 || index == 3) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1.5,
                    child: ImageTile.network(
                        data: data,
                        src: element,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 1 || index == 2) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: ImageTile.network(
                        data: data,
                        src: element,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 4) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/gallery',
                            arguments: GalleryViewPage.network(index, data));
                      },
                      child: Stack(fit: StackFit.expand, children: [
                        ImageTile.network(
                            data: data,
                            index: index,
                            width: 100,
                            height: 100,
                            src: element),
                        Container(
                          alignment: Alignment.center,
                          color: const Color.fromRGBO(0, 0, 0, 0.214),
                          child: Text('+ ${data.imageurl.length - 5}',
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(194, 255, 255, 255))),
                        )
                      ]),
                    ));
              }
              return const SizedBox(height: 0, width: 0);
            }),
          if (media != null)
            ...media.mapIndexed((index, element) {
              if (index == 0 || index == 3) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1.5,
                    child: ImageTile.memory(
                        mediaList: media,
                        memoryImageBytes: element.mediaByte!,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 1 || index == 2) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: ImageTile.memory(
                        mediaList: media,
                        memoryImageBytes: element.mediaByte!,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 4) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/gallery',
                            arguments: GalleryViewPage.memory(index, media));
                      },
                      child: Stack(fit: StackFit.expand, children: [
                        ImageTile.memory(
                            mediaList: media,
                            memoryImageBytes: element.mediaByte!,
                            index: index,
                            width: 100,
                            height: 100),
                        Container(
                          alignment: Alignment.center,
                          color: const Color.fromRGBO(0, 0, 0, 0.214),
                          child: Text('+ ${media.length - 5}',
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(194, 255, 255, 255))),
                        )
                      ]),
                    ));
              }
              return const SizedBox(height: 0, width: 0);
            })
        ]);

Widget batchImagesHorizontal(
        Post? data, List<Media>? media, BuildContext context) =>
    StaggeredGrid.count(
        // axisDirection: AxisDirection.down,
        crossAxisCount: 6,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: [
          if (data != null)
            ...data.imageurl.mapIndexed((index, element) {
              if (index == 0 || index == 1) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 2,
                    child: ImageTile.network(
                        data: data,
                        src: element,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 2 || index == 3) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: ImageTile.network(
                        data: data,
                        src: element,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 4) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/gallery',
                            arguments: GalleryViewPage.network(index, data));
                      },
                      child: Stack(fit: StackFit.expand, children: [
                        ImageTile.network(
                            data: data,
                            index: index,
                            width: 100,
                            height: 100,
                            src: element),
                        Container(
                          alignment: Alignment.center,
                          color: const Color.fromRGBO(0, 0, 0, 0.214),
                          child: Text('+ ${data.imageurl.length - 5}',
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(194, 255, 255, 255))),
                        )
                      ]),
                    ));
              }
              return const SizedBox(height: 0, width: 0);
            }),
          if (media != null)
            ...media.mapIndexed((index, element) {
              if (index == 0 || index == 1) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 2,
                    child: ImageTile.memory(
                        mediaList: media,
                        memoryImageBytes: element.mediaByte!,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 2 || index == 3) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: ImageTile.memory(
                        mediaList: media,
                        memoryImageBytes: element.mediaByte!,
                        index: index,
                        width: 100,
                        height: 100));
              } else if (index == 4) {
                return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/gallery',
                            arguments: GalleryViewPage.memory(index, media));
                      },
                      child: Stack(fit: StackFit.expand, children: [
                        ImageTile.memory(
                            mediaList: media,
                            memoryImageBytes: element.mediaByte!,
                            index: index,
                            width: 100,
                            height: 100),
                        Container(
                          alignment: Alignment.center,
                          color: const Color.fromRGBO(0, 0, 0, 0.214),
                          child: Text('+ ${media.length - 5}',
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(194, 255, 255, 255))),
                        )
                      ]),
                    ));
              }
              return const SizedBox(height: 0, width: 0);
            })
        ]);

enum ImageSourceType {
  network,
  memory,
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.data,
    required this.memoryImageBytes,
    required this.index,
    required this.src,
    required this.width,
    required this.height,
    required this.imageSourceType,
    required this.mediaList,
  }) : super(key: key);
  final Post data;
  final ImageSourceType imageSourceType;
  final Uint8List memoryImageBytes;
  final List<Media> mediaList;
  final int index;
  final String src;
  final int width;
  final int height;

  ImageTile.network({
    super.key,
    required this.data,
    required this.index,
    required this.src,
    required this.width,
    required this.height,
  })  : memoryImageBytes = Uint8List(0),
        imageSourceType = ImageSourceType.network,
        mediaList = [];

  ImageTile.memory({
    super.key,
    required this.mediaList,
    required this.memoryImageBytes,
    required this.index,
    required this.width,
    required this.height,
  })  : src = '',
        data = Post("", UserDummy("", "", "", "", DateTime.timestamp(), []), "",
            [], 0, 0, [], []),
        imageSourceType = ImageSourceType.memory;

  @override
  Widget build(BuildContext context) {
    switch (imageSourceType) {
      case ImageSourceType.network:
        return GestureDetector(
            onTap: () {
              // print(ModalRoute.of(context)!.currentResult);
              Navigator.of(context).pushNamed('/gallery',
                  arguments: GalleryViewPage.network(index, data));
            },
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: src,
              fadeOutDuration: const Duration(milliseconds: 500),
              fadeInDuration: const Duration(milliseconds: 500),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ));
      case ImageSourceType.memory:
        return GestureDetector(
          onTap: () {
            // print(ModalRoute.of(context)!.currentResult);
            Navigator.of(context).pushNamed('/gallery',
                arguments: GalleryViewPage.memory(index, mediaList));
          },
          child: Image.memory(memoryImageBytes, fit: BoxFit.cover),
          // child: CachedNetworkImage(
          //   fit: BoxFit.cover,
          //   imageUrl: src,
          //   fadeOutDuration: const Duration(milliseconds: 500),
          //   fadeInDuration: const Duration(milliseconds: 500),
          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
          //       Center(
          //           child: CircularProgressIndicator(
          //               value: downloadProgress.progress)),
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // )
        );
    }
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
