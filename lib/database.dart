import 'index.dart';

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future createUser(User? user, String username, String gender) async {
    if (user != null) {
      final userdoc = _db.collection('users').doc(user.uid);
      final json = UserDummy(user.uid, username, gender, '', user.email!,
          DateTime.timestamp(), []).toJson();
      await userdoc
          .set(json)
          .whenComplete(() => print("Registered!"))
          .catchError((e) => print(e));
    }
  }

  Future<UserDummy?> getUser(String id) async {
    final documentSnapshot = _db.collection('users').doc(id);
    var snapshot = await documentSnapshot.get();
    if (snapshot.exists) {
      return UserDummy(
          snapshot.data()!['id'],
          snapshot.data()!['name'],
          snapshot.data()!['gender'],
          snapshot.data()!['imageurl'],
          snapshot.data()!['email'],
          snapshot.data()!['createDate'].toDate(),
          snapshot.data()!['friends'].cast<String>());
    }
    return null;
  }

  Future<List<UserDummy?>> getUsersbyId(List<String> id) async {
    List<DocumentSnapshot<Map<String, dynamic>>> snapshots = [];
    List<UserDummy?> users = [];
    for (var i = 0; i < id.length; i++) {
      final snapshot = await _db.collection('users').doc(id[i]).get();
      snapshots.add(snapshot);
    }
    for (var i = 0; i < snapshots.length; i++) {
      if (snapshots[i].exists) {
        users.add(UserDummy(
            snapshots[i].data()!['id'],
            snapshots[i].data()!['name'],
            snapshots[i].data()!['gender'],
            snapshots[i].data()!['imageurl'],
            snapshots[i].data()!['email'],
            snapshots[i].data()!['createDate'].toDate(),
            snapshots[i].data()!['friends'].cast<String>()));
      }
    }
    return users;
  }
}
