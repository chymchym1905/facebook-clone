import 'index.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future createUser(User user) async {
    final userdoc = _db.collection('user').doc(user.uid);
    final json = UserDummy(user.uid, user.email!);
  }
}
