import '../../index.dart';

class SettingListView extends StatelessWidget {
  SettingListView({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: TextButton(
          onPressed: () => signOut(),
          child: const Text('Signout'),
        ),
      ),
    );
  }
}
