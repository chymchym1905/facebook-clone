// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluttericon/entypo_icons.dart';

import '../../../index.dart';

class SettingListView extends StatelessWidget {
  SettingListView({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 8,
        ),
        InkWell(
            onTap: () {},
            child: Ink(
              color: themeManager.themeMode == dark
                  ? lightdark
                  : const Color.fromARGB(235, 255, 255, 255),
              child: const ListElement(icon: Iconic.user, text: 'Profile'),
            )),
        InkWell(
            onTap: () => signOut(),
            child: Ink(
              color: themeManager.themeMode == dark
                  ? lightdark
                  : const Color.fromARGB(235, 255, 255, 255),
              child: const ListElement(icon: Entypo.logout, text: 'Log out'),
            ))
      ],
    );
  }
}

class ListElement extends StatelessWidget {
  const ListElement({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        const SizedBox(width: 10),
        Icon(icon, color: const Color.fromARGB(255, 176, 179, 184)),
        const SizedBox(width: 10),
        Text(text)
      ]),
    );
  }
}
