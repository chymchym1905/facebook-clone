import 'package:fluttericon/entypo_icons.dart';
import '../../../index.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  bool canPost = false;

  Widget buildBottomBarIcon(IconData icon, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: () {},
          highlightColor: themeManager.themeMode == dark
              ? const Color.fromARGB(255, 80, 82, 81)
              : const Color.fromARGB(255, 228, 228, 228),
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.transparent,
          child: Ink(
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
              child: Icon(icon, color: color, size: 30)),
        ),
      ),
    );
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
            padding: EdgeInsets.only(right: 3),
            child: Icon(icon, size: 20),
          ),
          Text(text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: themeManager.themeMode == dark
                      ? const Color.fromARGB(255, 118, 182, 254)
                      : const Color.fromARGB(255, 105, 104, 109))),
          Icon(Icons.arrow_drop_down, size: 18),
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
                onPressed: canPost ? () {} : null,
                style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                        Size(context.width * 0.23, 30)),
                    backgroundColor: canPost
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
                      color: canPost
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  cursorColor: themeManager.themeMode == light
                      ? const Color.fromARGB(255, 26, 84, 164)
                      : const Color.fromARGB(255, 20, 85, 175),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 25,
                      height: 1.4,
                      decoration: TextDecoration.none),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(focusedBorder: InputBorder.none),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                shape: BorderDirectional(
                    top: BorderSide(
                        color: themeManager.themeMode == dark
                            ? const Color.fromARGB(255, 92, 93, 96)
                            : const Color.fromARGB(255, 205, 205, 205))),
                color: themeManager.themeMode == dark ? lightdark : whitee,
                child: Row(children: [
                  buildBottomBarIcon(Icons.photo_library,
                      const Color.fromARGB(255, 106, 202, 130)),
                  buildBottomBarIcon(
                      Entypo.tag, const Color.fromARGB(255, 23, 120, 243)),
                  buildBottomBarIcon(
                      Icons.gif_box, const Color.fromARGB(255, 247, 185, 40)),
                  buildBottomBarIcon(Icons.emoji_emotions,
                      const Color.fromARGB(255, 237, 86, 67)),
                  buildBottomBarIcon(FontAwesome5.camera,
                      const Color.fromARGB(255, 176, 179, 184)),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
