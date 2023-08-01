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

  Future createPost(Post data) async {
    final postdoc = _db.collection('posts').doc();
    final json = Post(
            postdoc.id, data.user, data.caption, data.imageurl, 0, 0, 0, [], [])
        .toJson();
    await postdoc
        .set(json)
        .whenComplete(() => print("Post created"))
        .catchError((e) => print(e));
  }

  Future<List<Post>> getAllPost() async {
    var allPosts = await _db.collection('posts').get();
    List<Post> p = [];
    for (var i = 0; i < allPosts.docs.length; i++) {
      p.add(Post.fromJson(allPosts.docs[i].data()));
    }
    return p;
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
