import 'index.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future createUser(User? user) async {
    if (user != null) {
      final userdoc = _db.collection('users').doc(user.uid);
      final json =
          UserDummy(user.uid, user.email!, '', DateTime.timestamp()).toJson();
      await userdoc
          .set(json)
          .whenComplete(() => print("Registered!"))
          .catchError((e) => print(e));
    }
  }

  Future<UserDummy?> getUser(String id) async {
    final documentSnapshot =
        FirebaseFirestore.instance.collection('users').doc(id);
    var snapshot = await documentSnapshot.get();
    if (snapshot.exists) {
      return UserDummy(
          snapshot.data()!['id'],
          snapshot.data()!['name'],
          snapshot.data()!['imageurl'],
          snapshot.data()!['createDate'].toDate());
    }
    return null;
  }
}
