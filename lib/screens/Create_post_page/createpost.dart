import 'package:flutter_application_1/screens/Create_post_page/image_preview.dart';
import 'package:fluttericon/entypo_icons.dart';
import '../../../index.dart';
import 'package:snapping_sheet_2/snapping_sheet.dart';
import '../../utils/grabbing_widget.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost>
    with SingleTickerProviderStateMixin {
  TextEditingController caption = TextEditingController();
  MaterialStatesController materialStates = MaterialStatesController();
  List<Media> pickedMedia = [];
  ScrollController scrollController = ScrollController();
  // ValueNotifier<List<Media>> imageList = ValueNotifier<List<Media>>([]);

  // StreamController<List<Media>> imagesStream = StreamController<List<Media>>();

  @override
  void initState() {
    super.initState();
    // imageList.addListener(() {
    //   setState(() {
    //     debugPrint(imageList.toString());
    //   });
    // });
    caption.addListener(captionListener);
  }

  void captionListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    // imageList.dispose();
    caption.dispose();
    super.dispose();
  }

  pickimage() {
    return showModalBottomSheet(
        context: context,
        // enableDrag: false,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => SnappingSheet(
              lockOverflowDrag: true,
              snappingPositions: const [
                SnappingPosition.factor(
                  snappingCurve: Curves.bounceInOut,
                  snappingDuration: Duration(milliseconds: 100),
                  positionFactor: 0.5,
                ),
                SnappingPosition.factor(
                  grabbingContentOffset: GrabbingContentOffset.bottom,
                  snappingCurve: Curves.bounceInOut,
                  snappingDuration: Duration(milliseconds: 100),
                  positionFactor: 0.9,
                ),
              ],
              sheetBelow: SnappingSheetContent(
                  childScrollController: scrollController,
                  child: Container(
                    color: Colors.white,
                    child: MediaPicker(
                      scrollController: scrollController,
                      onPicked: (selectedList) {
                        setState(() {
                          pickedMedia = selectedList;
                        });
                        // pickedMedia = selectedList;
                        Navigator.of(context).pop();
                      },
                      onCancel: () => Navigator.of(context).pop(),
                      mediaList: pickedMedia,
                      decoration: PickerDecoration(
                        completeText: "Next",
                        completeButtonStyle: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                                Size(context.width * 0.23, 30)),
                            backgroundColor: const MaterialStatePropertyAll(
                                Palette.facebookBlue),
                            overlayColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 10, 100, 219)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)))),
                        blurStrength: 1,
                        scaleAmount: 1,
                        counterBuilder: (context, index) {
                          if (index == null) return const SizedBox();
                          return Align(
                            alignment: Alignment(0.9, -1),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Palette.facebookBlue,
                                  shape: BoxShape.circle),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '$index',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
              grabbing: GrabbingWidget(),
              grabbingHeight: 40,
            ));
  }

  Widget buildBottomBarIcon(IconData icon, Color color, callback) {
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              onTap: callback,
              borderRadius: BorderRadius.circular(15),
              highlightColor: themeManager.themeMode == dark
                  ? const Color.fromARGB(255, 80, 82, 81)
                  : const Color.fromARGB(255, 228, 228, 228),
              splashColor: themeManager.themeMode == dark
                  ? const Color.fromARGB(255, 80, 82, 81)
                  : const Color.fromARGB(255, 228, 228, 228),
              child: Ink(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                  child: Icon(icon, color: color, size: 30)),
            )));
  }

  Widget customButton(String text, IconData icon) {
    return IntrinsicWidth(
      stepWidth: 8,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: themeManager.themeMode == dark
                ? const Color.fromARGB(255, 118, 182, 254)
                : const Color.fromARGB(255, 105, 104, 109),
            backgroundColor: themeManager.themeMode == dark
                ? const Color.fromARGB(255, 39, 57, 81)
                : null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color: themeManager.themeMode == dark
                        ? Colors.transparent
                        : const Color.fromARGB(255, 219, 219, 219))),
            padding: const EdgeInsets.only(left: 5)),
        onPressed: () {},
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.only(right: 3),
            child: Icon(icon, size: 20),
          ),
          Text(text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: themeManager.themeMode == dark
                      ? const Color.fromARGB(255, 118, 182, 254)
                      : const Color.fromARGB(255, 105, 104, 109))),
          const Icon(Icons.arrow_drop_down, size: 18),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // bool isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.07,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: const Text('Create Post'),
        elevation: 0,
        shape: BorderDirectional(
            bottom: BorderSide(
                color: themeManager.themeMode == dark
                    ? const Color.fromARGB(255, 92, 93, 96)
                    : const Color.fromARGB(255, 205, 205, 205))),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilledButton(
                onPressed:
                    caption.text != "" || pickedMedia.isNotEmpty ? () {} : null,
                style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                        Size(context.width * 0.23, 30)),
                    backgroundColor: caption.text != "" ||
                            pickedMedia.isNotEmpty
                        ? const MaterialStatePropertyAll(Palette.facebookBlue)
                        : themeManager.themeMode == light
                            ? const MaterialStatePropertyAll(
                                Color.fromARGB(255, 229, 230, 235))
                            : const MaterialStatePropertyAll(
                                Color.fromARGB(255, 57, 58, 60)),
                    overlayColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 10, 100, 219)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)))),
                child: Text(
                  'POST',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      color: caption.text != "" || pickedMedia.isNotEmpty
                          ? Colors.white
                          : themeManager.themeMode == light
                              ? const Color.fromARGB(255, 190, 192, 197)
                              : const Color.fromARGB(255, 122, 125, 130)),
                ),
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: themeManager.themeMode == dark ? lightdark : Colors.white,
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  child: CircleAvatar(
                    backgroundImage: imageAvatar(currUser!.imageurl),
                    radius: 30,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Text(currUser!.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 20)),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        runSpacing: 4,
                        spacing: 4,
                        children: [
                          customButton("Public", Icons.public),
                          customButton("Public", Icons.public),
                          customButton("Public", Icons.public)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  onChanged: (value) {
                    captionListener();
                  },
                  controller: caption,
                  cursorColor: themeManager.themeMode == light
                      ? const Color.fromARGB(255, 26, 84, 164)
                      : const Color.fromARGB(255, 20, 85, 175),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 25,
                      height: 1.4,
                      decoration: TextDecoration.none),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      const InputDecoration(focusedBorder: InputBorder.none),
                ),
              ),
            ),
            Expanded(
                child:
                    ImagePreview(images: pickedMedia, callback: updateState)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        top: BorderSide(
                            color: themeManager.themeMode == dark
                                ? const Color.fromARGB(255, 92, 93, 96)
                                : const Color.fromARGB(255, 205, 205, 205)))),
                child: Material(
                  color: themeManager.themeMode == dark ? lightdark : whitee,
                  child: Row(children: [
                    buildBottomBarIcon(Icons.photo_library,
                        const Color.fromARGB(255, 106, 202, 130), pickimage),
                    buildBottomBarIcon(Entypo.tag,
                        const Color.fromARGB(255, 23, 120, 243), () {}),
                    buildBottomBarIcon(Icons.gif_box,
                        const Color.fromARGB(255, 247, 185, 40), () {}),
                    buildBottomBarIcon(Icons.emoji_emotions,
                        const Color.fromARGB(255, 237, 86, 67), () {}),
                    buildBottomBarIcon(FontAwesome5.camera,
                        const Color.fromARGB(255, 176, 179, 184), () {}),
                  ]),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
