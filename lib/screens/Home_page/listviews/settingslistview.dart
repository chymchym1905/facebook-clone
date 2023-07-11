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
        InkWell(
          onTap: () {},
          child: Ink(
              color: themeManager.themeMode == dark
                  ? lightdark
                  : const Color.fromARGB(235, 255, 255, 255),
              child: ListTile(
                leading: Icon(
                  Entypo.logout,
                  color: Color.fromARGB(255, 176, 179, 184),
                ),
                title: Text('One-line with both widgets'),
              )),
        )
      ],
    );
  }
}
