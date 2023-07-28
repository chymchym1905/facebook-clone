import 'package:flutter_application_1/index.dart';

class Friends extends StatefulWidget {
  const Friends({super.key, required this.user, required this.posts});
  final UserDummy user;
  final Post posts;

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  Widget build(BuildContext context) {
    double x = 40;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.07,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Row(
          children: [
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                    // isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 241, 242, 246),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Search"),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Stack(children: [
            Column(children: [
              Image.asset('assets/images/R.jpg',
                  height: 200, width: context.width, fit: BoxFit.cover),
              Container(
                color: themeManager.themeMode == dark
                    ? const Color.fromARGB(255, 38, 38, 38)
                    : whitee,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 12,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: x),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(widget.user.name,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            // icon: const Icon(Icons.person_add),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.06)),
                            child: Row(
                              children: [
                                Transform.flip(
                                    flipX: true,
                                    child: const Icon(Icons.person_add)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Respond",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              // icon: const Icon(Icons.person_add),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: themeManager.themeMode ==
                                          dark
                                      ? const Color.fromARGB(255, 58, 59, 60)
                                      : const Color.fromARGB(
                                          255, 241, 242, 246),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.09)),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesome5.facebook_messenger,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text("Message",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: themeManager.themeMode ==
                                          dark
                                      ? const Color.fromARGB(255, 58, 59, 60)
                                      : const Color.fromARGB(
                                          255, 241, 242, 246),
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical: 5)),
                              child: Icon(Icons.more_horiz,
                                  color: themeManager.themeMode == light
                                      ? Colors.black
                                      : whitee),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.4))),
                          height: 1,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.more_horiz,
                                color: themeManager.themeMode == light
                                    ? Colors.black
                                    : whitee),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "See ${widget.user.name} Info",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.4))),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Friends",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Text("Number "),
                            if (true) ...[Text("(mutual friend)")]
                          ],
                        ),
                      ),
                      for (int i = 0; i < 2; i++) ...[
                        // && i < user.friend.length
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int j = 0; j < 3; j++) ...[
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image(
                                      image: imageAvatar(widget.user.imageurl),
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        widget.user.name,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ]
                          ],
                        )
                      ],
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 8),
                        child: ElevatedButton(
                          onPressed: () {},
                          // icon: const Icon(Icons.person_add),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeManager.themeMode == dark
                                ? const Color.fromARGB(255, 58, 59, 60)
                                : const Color.fromARGB(255, 241, 242, 246),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text("See all friends",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            Transform.translate(
              offset: const Offset(20, 75),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, border: Border.all(width: 6)),
                child: CircleAvatar(
                  backgroundImage: imageAvatar(widget.user.imageurl),
                  radius: 70,
                ),
              ),
            )
          ]),
          // Row()
          Container(
              color: themeManager.themeMode == dark
                  ? const Color.fromARGB(255, 38, 38, 38)
                  : whitee,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
              child: Text("Posts",
                  style: Theme.of(context).textTheme.titleMedium)),
          Container(
              color: themeManager.themeMode == dark
                  ? const Color.fromARGB(255, 38, 38, 38)
                  : whitee,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: themeManager.themeMode == dark
                            ? const Color.fromARGB(255, 58, 59, 60)
                            : const Color.fromARGB(255, 241, 242, 246),
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03,
                            vertical: 8)),
                    label: Text("Photos",
                        style: Theme.of(context).textTheme.bodyMedium),
                    icon: Icon(Icons.photo_library,
                        color: themeManager.themeMode != dark
                            ? const Color.fromARGB(255, 38, 38, 38)
                            : whitee,
                        size: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: themeManager.themeMode == dark
                              ? const Color.fromARGB(255, 58, 59, 60)
                              : const Color.fromARGB(255, 241, 242, 246),
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                              vertical: 8)),
                      label: Text("Music",
                          style: Theme.of(context).textTheme.bodyMedium),
                      icon: Icon(
                        Elusive.music,
                        color: themeManager.themeMode != dark
                            ? const Color.fromARGB(255, 38, 38, 38)
                            : whitee,
                        size: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              )),
          Posts(data: widget.posts),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                "No posts available",
                style: TextStyle(color: Color.fromARGB(255, 109, 117, 125)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
