import 'index.dart';

enum CommentLevel { one, two, three }

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future createUser(User? user, String username, String gender) async {
    if (user != null) {
      final userdoc = _db.collection('users').doc(user.uid);
      final json =
          UserDummy(username, gender, '', user.email!, DateTime.now(), [])
              .toJson();
      await userdoc
          .set(json)
          .whenComplete(() => print("Registered!"))
          .catchError((e) => print(e));
    }
  }

  Future createPost(Post data, List<Media> media) async {
    final postdoc = _db.collection('posts').doc();
    final List<String> mediaURLS = [];
    if (media.isNotEmpty) {
      for (int i = 0; i < media.length; i++) {
        var task = Storage().uploadBytes(
            'posts/${postdoc.id}/${media[i].file!.path}', media[i].mediaByte!);
        if (task == null) {
          continue;
        }
        final snapshot = await task.whenComplete(() => null);
        mediaURLS.add(await snapshot.ref.getDownloadURL());
      }
    }

    final json = Post(postdoc.id, data.user, data.caption, mediaURLS,
            data.likes, data.shares, data.comment, data.reactions)
        .toJson();
    json['user'] = json['user'].toJson();
    await postdoc
        .set(json)
        .whenComplete(() => print("Post created"))
        .catchError((e) => print(e));
  }

  List<Comment1> convert(List<dynamic> json) {
    // print(json);
    final List<Comment1> res = [];
    if (json.isNotEmpty) {
      for (int i = 0; i < json.length; i++) {
        res.add(Comment1.fromJson(json[i]));
      }
    }
    return res;
  }

  Future<List<Post>> getAllPost() async {
    var allPosts = await _db.collection('posts').get();
    List<Post> p = [];
    if (allPosts.docs.isNotEmpty) {
      for (var i = 0; i < allPosts.docs.length; i++) {
        // final listcomment = convert(allPosts.docs[i]['comment']);

        p.add(Post(
          allPosts.docs[i]['id'],
          UserDummy.fromJson(allPosts.docs[i]['user']),
          allPosts.docs[i]['caption'],
          allPosts.docs[i]['imageurl'].cast<String>(),
          allPosts.docs[i]['likes'],
          allPosts.docs[i]['shares'],
          allPosts.docs[i]['comment'],
          allPosts.docs[i]['reactions'].cast<Reaction>(),
        ));
      }
    }
    return p;
  }

  Future<UserDummy?> getUser(String id) async {
    final documentSnapshot = _db.collection('users').doc(id);
    var snapshot = await documentSnapshot.get();
    if (snapshot.exists) {
      return UserDummy(
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

  // Future getAllcommentsfromPost(String postId) async{
  //   List<Comment1> comments = await getAlllevel1Comment(postId);

  // }

  Future getAlllevel1Comment(String postId) async {
    final commentDocRef = await _db.collection('posts/$postId/comment').get();
    List<Comment1> c = [];
    if (commentDocRef.docs.isNotEmpty) {
      for (int i = 0; i < commentDocRef.docs.length; i++) {
        c.add(Comment1(
          commentDocRef.docs[i]['id'],
          UserDummy.fromJson(commentDocRef.docs[i]['user']),
          commentDocRef.docs[i]['react'],
          commentDocRef.docs[i]['content'],
          commentDocRef.docs[i]['reply'],
          commentDocRef.docs[i]['reactions'],
        ));
      }
    }
    return c;
  }

  Future getAlllevel2Comment(String postId, String parentCommentId) async {
    final commentDocRef = await _db
        .collection('posts/$postId/comment/$parentCommentId/reply')
        .get();
    List<Comment1> c = [];
    if (commentDocRef.docs.isNotEmpty) {
      for (int i = 0; i < commentDocRef.docs.length; i++) {
        c.add(Comment1(
          commentDocRef.docs[i]['id'],
          UserDummy.fromJson(commentDocRef.docs[i]['user']),
          commentDocRef.docs[i]['react'],
          commentDocRef.docs[i]['content'],
          commentDocRef.docs[i]['reply'],
          commentDocRef.docs[i]['reactions'],
        ));
      }
    }
    return c;
  }

  Future getAlllevel3Comment(String postId, String grandParentCommentId,
      String parentCommentId) async {
    final commentDocRef = await _db
        .collection(
            'posts/$postId/comment/$grandParentCommentId/reply/$parentCommentId/reply')
        .get();
    List<Comment1> c = [];
    if (commentDocRef.docs.isNotEmpty) {
      for (int i = 0; i < commentDocRef.docs.length; i++) {
        c.add(Comment1(
          commentDocRef.docs[i]['id'],
          UserDummy.fromJson(commentDocRef.docs[i]['user']),
          commentDocRef.docs[i]['react'],
          commentDocRef.docs[i]['content'],
          commentDocRef.docs[i]['reply'],
          commentDocRef.docs[i]['reactions'],
        ));
      }
    }
    return c;
  }

  Future writeComment(String postId, Comment1 reply, CommentLevel cmt) async {
    // var snapshot = await post.get();
    if (cmt == CommentLevel.one) {
      final comment = _db.collection('posts/$postId/comment').doc();
      reply.id = comment.id;
      final commentListPost = await _db.collection('posts').doc(postId).get();
      _db
          .collection('posts')
          .doc(postId)
          .set(commentListPost.data()!['comment'].add(comment.id))
          .whenComplete(() => print("setId"))
          .catchError((e) => print(e));
      comment
          .set(reply.toJson())
          .whenComplete(() => print("OK"))
          .catchError((e) => print(e));
    } else if (cmt == CommentLevel.two) {
      final comment = _db.collection('posts').doc(postId);
      var snap = await comment.get();
      var json = snap.data()!['comment'][IndexReply.intdex];
      final commentlv2 =
          _db.collection('posts/$postId/comment/$json/reply').doc();
      reply.id = commentlv2.id;
      commentlv2
          .set(reply.toJson())
          .whenComplete(() => print('OK'))
          .catchError((e) => print(e));
    }
    //   if (snap.exists) {
    //     json['comment'][IndexReply.intdex]['reply'][IndexReply.intdex2]['reply']
    //         .add(reply.toJson());
    //     // print(json);
    //   }
    //   await post
    //       .set(json, SetOptions(merge: true))
    //       .whenComplete(() => print("Done"))
    //       .catchError((error) => print(error));
    // } else if (cmt == CommentLevel.two) {
    //   final post = _db.collection('posts').doc(id);
    //   var snap = await post.get();
    //   var json = snap.data()!;
    //   if (snap.exists) {
    //     json['comment'][IndexReply.intdex]['reply'].add(reply.toJson());
    //     // print(json);
    //   }
    //   await post
    //       .set(json, SetOptions(merge: true))
    //       .whenComplete(() => print("Done"))
    //       .catchError((error) => print(error));
    // } else {
    //   final post = _db.collection('posts').doc(id);
    //   // var snap = await post.get();
    //   var snap = await post.get();
    //   var json = snap.data()!;
    //   if (snap.exists) {
    //     json['comment'].add(reply.toJson());
    //     // print(json);
    //   }
    //   await post
    //       .set(json, SetOptions(merge: true))
    //       .whenComplete(() => print("Done"))
    //       .catchError((error) => print(error));
    // }
  }

  Future deleteComment(String id, CommentLevel cmt) async {
    if (cmt == CommentLevel.three) {
      final post = _db.collection('posts').doc(id);
      var snap = await post.get();
      var json = snap.data()!;
      if (snap.exists) {
        json['comment'][IndexComment.intdex1]['reply'][IndexComment.intdex2]
                ['reply']
            .removeAt(IndexComment.intdex3);
        // print(json);
      }
      await post
          .set(json)
          .whenComplete(() => print("Done"))
          .catchError((error) => print(error));
    } else if (cmt == CommentLevel.two) {
      final post = _db.collection('posts').doc(id);
      var snap = await post.get();
      var json = snap.data()!;
      if (snap.exists) {
        json['comment'][IndexComment.intdex1]['reply']
            .removeAt(IndexComment.intdex2);
        // print(json);
      }
      await post
          .set(json)
          .whenComplete(() => print("Done"))
          .catchError((error) => print(error));
    } else if (cmt == CommentLevel.one) {
      final post = _db.collection('posts').doc(id);
      var snap = await post.get();
      var json = snap.data()!;
      if (snap.exists) {
        json['comment'].removeAt(IndexComment.intdex1);
        // print(json);
      }
      await post
          .set(json)
          .whenComplete(() => print("Done"))
          .catchError((error) => print(error));
    }
  }
}
