import '../../../index.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Rect imageRect = Rect.fromLTWH(0, 0, context.width, 200);
    // Rect ava = Rect.fromCircle(center: Offset(0, 0), radius: 70);
    // RelativeRect i = RelativeRect.fromRect(imageRect, ava);
    double x = 30;

    return Scaffold(
      backgroundColor: themeManager.themeMode == dark
          ? const Color.fromARGB(255, 38, 38, 38)
          : Colors.white,
      appBar: AppBar(
        leading: IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.07,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Image.asset('assets/images/R.jpg',
                height: 200, width: context.width, fit: BoxFit.cover),
            Transform.translate(
              offset: Offset(20, x),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 6)),
                child: CircleAvatar(
                  backgroundImage: imageAvatar(currUser!.imageurl),
                  radius: 70,
                ),
              ),
            )
          ]),
          Transform.translate(
              offset: Offset(20, x * 1.5),
              child: Text(
                currUser!.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 28),
              )),
          Transform.translate(
            offset: Offset(0, x * 1.5 + 10),
            child: Center(
              child: FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                    // splashFactory: InkSplash.splashFactory,
                    fixedSize:
                        MaterialStatePropertyAll(Size(context.width * 0.9, 40)),
                    backgroundColor:
                        const MaterialStatePropertyAll(Palette.facebookBlue),
                    overlayColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 10, 100, 219)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)))),
                child: Text(
                  'Add to Story',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 14),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, x * 1.5 + 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      // splashFactory: InkSplash.splashFactory,
                      fixedSize: MaterialStatePropertyAll(
                          Size(context.width * 0.67, 40)),
                      // backgroundColor:
                      //     const MaterialStatePropertyAll(Palette.facebookBlue),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)))),
                  child: Text(
                    'Edit profile',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 14),
                  ),
                ),
                SizedBox(width: context.width * 0.03),
                FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      // splashFactory: InkSplash.splashFactory,
                      fixedSize: MaterialStatePropertyAll(
                          Size(context.width * 0.2, 40)),
                      // backgroundColor:
                      //     const MaterialStatePropertyAll(Palette.facebookBlue),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)))),
                  child: Icon(Icons.more_horiz,
                      color: themeManager.themeMode == light
                          ? Colors.black
                          : whitee),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
