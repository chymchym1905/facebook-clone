import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter_application_1/index.dart';

class ImageBox extends StatefulWidget {
  const ImageBox({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Post data;

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Image image = Image.network(widget.data.imageurl[0]);
    Completer<ui.Image> completer = Completer<ui.Image>();
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    return FutureBuilder(
        future: completer.future,
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasError) {
            // setState(() {});
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            if (widget.data.imageurl.length == 1) {
              return oneItem(widget.data);
            } else if (widget.data.imageurl.length == 2) {
              if (snapshot.data!.width >= snapshot.data!.height) {
                return twoItem(widget.data);
              }
              return twoItemVertical(widget.data);
            } else if (widget.data.imageurl.length == 3) {
              return threeItem(widget.data);
            } else if (widget.data.imageurl.length == 4) {
              if (snapshot.data!.width >= snapshot.data!.height) {
                return fourItem(widget.data);
              }
              return fourItem2(widget.data);
            } else if (widget.data.imageurl.length == 5) {
              if (snapshot.data!.width >= snapshot.data!.height) {
                return fiveItemVertical(widget.data);
              }
              return fiveItemHorizontal(widget.data);
            } else {
              if (snapshot.data!.width >= snapshot.data!.height) {
                return batchImages(widget.data, context);
              }
              return batchImagesHorizontal(widget.data, context);
            }
          } else {
            return const LoadingIndicator();
          }
        });
  }
}
