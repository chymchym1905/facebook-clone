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
          .whenComplete(() => debugPrint("Registered!"))
          .catchError((e) => debugPrint(e));
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
            reactionsCount: data.reactionsCount,
            commentsCount: data.commentsCount,
            sharesCount: data.sharesCount)
        .toJson();
    json['user'] = json['user'].toJson();
    await postdoc
        .set(json)
        .whenComplete(() => debugPrint("Post created"))
        .catchError((e) => debugPrint(e));
  }

  List<Comment1> convert(List<dynamic> json) {
    // debugPrint(json);
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
        p.add(Post(
          allPosts.docs[i]['id'],
          UserDummy.fromJson(allPosts.docs[i]['user']),
          allPosts.docs[i]['caption'],
          allPosts.docs[i]['imageurl'].cast<String>(),
          sharesCount: allPosts.docs[i]['sharesCount'],
          reactionsCount: allPosts.docs[i]['reactionsCount'],
          commentsCount: allPosts.docs[i]['commentsCount'],
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

  Future<List<Comment1>> getAlllevel1Comment(String postId) async {
    List<Comment1> c = [];
    final commentDocRef = PaginatedQueryHelper.lastCommentlevel1Query == null
        ? await _db
            .collection('posts/$postId/comment')
            .where('parentID', isEqualTo: null)
            .orderBy('createDate')
            .limit(10)
            .get()
        : await _db
            .collection('posts/$postId/comment')
            .where('parentId', isNull: true)
            .orderBy('createDate')
            .limit(10)
            .startAfter([PaginatedQueryHelper.lastCommentlevel1Query]).get();

    if (commentDocRef.docs.isEmpty) {
      PaginatedQueryHelper.lastCommentlevel1Query = null;
      return [];
    }
    PaginatedQueryHelper.lastCommentlevel1Query =
        commentDocRef.docs[commentDocRef.size - 1];
    for (int i = 0; i < commentDocRef.docs.length; i++) {
      c.add(Comment1(
        commentDocRef.docs[i]['id'],
        UserDummy.fromJson(commentDocRef.docs[i]['user']),
        commentDocRef.docs[i]['content'],
        childCommentCount: commentDocRef.docs[i]['childCommentCount'],
        reactionCount: commentDocRef.docs[i]['reactionCount'],
        // ignore: prefer_null_aware_operators
        firstChild: commentDocRef.docs[i]['firstChild'] == null
            ? null
            : commentDocRef.docs[i]['firstChild'].cast<Comment1>(),
      ));
    }
    return c;
  }

  Future<List<Comment1>> getAlllevel2Comment(
      String postId, String parentCommentId) async {
    List<Comment1> c = [];
    final commentDocRef = PaginatedQueryHelper.lastCommentlevel1Query == null
        ? await _db
            .collection('posts/$postId/comment')
            .where('parentID', isEqualTo: parentCommentId)
            .where('grandParentID', isNull: true)
            .orderBy('createDate')
            .limit(10)
            .get()
        : await _db
            .collection('posts/$postId/comment')
            .where('parentID', isEqualTo: parentCommentId)
            .where('grandParentID', isNull: true)
            .orderBy('createDate')
            .limit(10)
            .startAfter([PaginatedQueryHelper.lastCommentlevel2Query]).get();

    if (commentDocRef.docs.isEmpty) {
      PaginatedQueryHelper.lastCommentlevel2Query = null;
      return [];
    }
    PaginatedQueryHelper.lastCommentlevel2Query =
        commentDocRef.docs[commentDocRef.size - 1];
    for (int i = 0; i < commentDocRef.docs.length; i++) {
      c.add(Comment1.level2(
        commentDocRef.docs[i]['id'],
        commentDocRef.docs[i]['parentID'],
        UserDummy.fromJson(commentDocRef.docs[i]['user']),
        commentDocRef.docs[i]['content'],
        childCommentCount: commentDocRef.docs[i]['childCommentCount'],
        reactionCount: commentDocRef.docs[i]['reactionCount'],
        firstChild: commentDocRef.docs[i]['firstChild'].cast<Comment1>(),
      ));
    }
    return c;
  }

  Future<List<Comment1>> getAlllevel3Comment(String postId,
      String grandParentCommentId, String parentCommentId) async {
    List<Comment1> c = [];
    final commentDocRef = PaginatedQueryHelper.lastCommentlevel2Query == null
        ? await _db
            .collection('posts/$postId/comment')
            .where('parentID', isEqualTo: parentCommentId)
            .where('grandParentID', isEqualTo: grandParentCommentId)
            .orderBy('createDate')
            .limit(10)
            .get()
        : await _db
            .collection('posts/$postId/comment')
            .where('parentID', isEqualTo: parentCommentId)
            .where('grandParentID', isEqualTo: grandParentCommentId)
            .orderBy('createDate')
            .limit(10)
            .startAfter([PaginatedQueryHelper.lastCommentlevel3Query]).get();
    if (commentDocRef.docs.isEmpty) {
      PaginatedQueryHelper.lastCommentlevel3Query = null;
      return [];
    }
    PaginatedQueryHelper.lastCommentlevel3Query =
        commentDocRef.docs[commentDocRef.size - 1];

    for (int i = 0; i < commentDocRef.docs.length; i++) {
      c.add(Comment1.level3(
          commentDocRef.docs[i]['id'],
          commentDocRef.docs[i]['parentID'],
          commentDocRef.docs[i]['grandParentID'],
          UserDummy.fromJson(commentDocRef.docs[i]['user']),
          commentDocRef.docs[i]['content'],
          childCommentCount: commentDocRef.docs[i]['childCommentCount'],
          reactionCount: commentDocRef.docs[i]['reactionCount']));
    }
    return c;
  }

  Future writeComment(String postId, Comment1 reply, CommentLevel cmt) async {
    // var snapshot = await post.get();
    if (cmt == CommentLevel.one) {
      final comment = _db.collection('posts/$postId/comment').doc();
      reply.id = comment.id;
      comment
          .set(reply.toJson())
          .whenComplete(() => debugPrint("OK"))
          .catchError((e) => debugPrint(e));
    } else if (cmt == CommentLevel.two) {
      final comment = _db.collection('posts/$postId/comment').doc();
      reply.id = comment.id;
      comment
          .set(reply.toJson())
          .whenComplete(() => debugPrint('OK'))
          .catchError((e) => debugPrint(e));
    } else if (cmt == CommentLevel.three) {
      final comment = _db.collection('posts/$postId/comment').doc();
      reply.id = comment.id;
      comment
          .set(reply.toJson())
          .whenComplete(() => debugPrint('OK'))
          .catchError((e) => debugPrint(e));
    }
  }

// xóa comment và tất cả các child
  Future deleteComment(String postID, String id, CommentLevel cmt) async {
    if (cmt == CommentLevel.three) {
      await _db.collection('posts/$postID/comment').doc(id).delete();
    } else if (cmt == CommentLevel.two) {
      await _db.collection('posts/$postID/comment').doc(id).delete();
      final childComment = await _db
          .collection('posts/$postID/comment')
          .where('parentID', isEqualTo: id)
          .get();
      if (childComment.docs.isEmpty) return;
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in childComment.docs) {
        batch.delete(doc.reference);
      }
      try {
        await batch.commit();
        debugPrint('Documents deleted successfully.');
      } catch (e) {
        debugPrint('Error deleting documents: $e');
      }
    } else if (cmt == CommentLevel.one) {
      await _db.collection('posts/$postID/comment').doc(id).delete();
      final childComment = await _db
          .collection('posts/$postID/comment')
          .where('parentID', isEqualTo: id)
          .where('grandParentID', isEqualTo: id)
          .get();
      if (childComment.docs.isEmpty) return;
      final batch = FirebaseFirestore.instance.batch();
      for (final doc in childComment.docs) {
        batch.delete(doc.reference);
      }
      try {
        await batch.commit();
        debugPrint('Documents deleted successfully.');
      } catch (e) {
        debugPrint('Error deleting documents: $e');
      }
    }
  }
}

class PaginatedQueryHelper {
  static QueryDocumentSnapshot<Map<String, dynamic>>? lastCommentlevel1Query;
  static QueryDocumentSnapshot<Map<String, dynamic>>? lastCommentlevel2Query;
  static QueryDocumentSnapshot<Map<String, dynamic>>? lastCommentlevel3Query;
}
