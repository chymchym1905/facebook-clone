// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({
    Key? key,
    required this.images,
    required this.callback,
  }) : super(key: key);
  final List<Media> images;
  final Function() callback;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AlignedGridView.count(
          physics: PageScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return tile(widget.images[index], context.width / 3,
                context.width / 3, index);
          }),
    );
  }

  Widget tile(Media media, double height, double width, int index) {
    return Stack(children: [
      if (media.mediaType == MediaType.image)
        Image.memory(media.mediaByte!,
            fit: BoxFit.cover, height: height, width: width),
      if (media.mediaType == MediaType.video)
        Image.memory(media.thumbnail!,
            fit: BoxFit.cover, height: height, width: width),
      Positioned(
        top: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.images.remove(media);
                if (widget.images.isEmpty) {
                  widget.callback();
                }
              });
            },
            child: Container(
                child: Icon(Icons.close),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
          ),
        ),
      )
    ]);
  }
}
