import 'index.dart';

enum CommentLevel { one, two, three }

class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  PaginatedQueryHelper helper = PaginatedQueryHelper();

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

  // Future<List<Post>> getAllPost() async {
  //   var allPosts = await _db.collection('posts').get();
  //   List<Post> p = [];
  //   if (allPosts.docs.isNotEmpty) {
  //     for (var i = 0; i < allPosts.docs.length; i++) {
  //       p.add(Post(
  //         allPosts.docs[i]['id'],
  //         UserDummy.fromJson(allPosts.docs[i]['user']),
  //         allPosts.docs[i]['caption'],
  //         allPosts.docs[i]['imageurl'].cast<String>(),
  //         sharesCount: allPosts.docs[i]['sharesCount'],
  //         reactionsCount: allPosts.docs[i]['reactionsCount'],
  //         commentsCount: allPosts.docs[i]['commentsCount'],
  //       ));
  //     }
  //   }
  //   return p;
  // }

  Future<List<Post>> getPosts() async {
    List<Post> p = [];
    final postDocRef = helper.lastPostQuery == null
        ? await _db
            .collection('posts')
            .orderBy('createDate', descending: true)
            .limit(1)
            .get()
        : await _db
            .collection('posts')
            .orderBy('createDate', descending: true)
            .startAfter([helper.lastPostQuery?.data()['createDate']])
            .limit(1)
            .get();
    if (postDocRef.docs.isEmpty) {
      helper.lastPostQuery = null;
      return [];
    }
    helper.lastPostQuery = postDocRef.docs[postDocRef.size - 1];
    for (int i = 0; i < postDocRef.docs.length; i++) {
      p.add(Post(
        postDocRef.docs[i]['id'],
        UserDummy.fromJson(postDocRef.docs[i]['user']),
        postDocRef.docs[i]['caption'],
        postDocRef.docs[i]['imageurl'].cast<String>(),
        sharesCount: postDocRef.docs[i]['sharesCount'],
        reactionsCount: postDocRef.docs[i]['reactionsCount'],
        commentsCount: postDocRef.docs[i]['commentsCount'],
      ));
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
    if (helper.lastPostId != postId) {
      helper.lastCommentlevel1Query = null;
    }
    helper.lastPostId = postId;
    List<Comment1> c = [];
    // print(helper.lastCommentlevel1Query?.data()['createDate'].toDate());
    // final snapshot = await _db
    //     .collection('post/$postId/comment')
    //     .doc(helper.lastCommentlevel1Query?.data()['id'])
    //     .get();
    final commentDocRef = helper.lastCommentlevel1Query == null
        ? _db
            .collection('posts/$postId/comment')
            .where('parentID', isNull: true)
            .orderBy('createDate', descending: true)
            .limit(1)
        : _db
            .collection('posts/$postId/comment')
            .where('parentID', isNull: true)
            .orderBy('createDate', descending: true)
            .startAfter(
                [helper.lastCommentlevel1Query?.data()['createDate']]).limit(1);

    await commentDocRef.get().then((value) {
      if (value.docs.isEmpty) {
        return [];
      }
      helper.lastCommentlevel1Query = value.docs[value.size - 1];
      for (int i = 0; i < value.docs.length; i++) {
        c.add(Comment1(
          value.docs[i]['id'],
          UserDummy.fromJson(value.docs[i]['user']),
          value.docs[i]['content'],
          childCommentCount: value.docs[i]['childCommentCount'],
          reactionCount: value.docs[i]['reactionCount'],
          // ignore: prefer_null_aware_operators
          firstChild: value.docs[i]['firstChild'] == null
              ? null
              : value.docs[i]['firstChild'].cast<Comment1>(),
        ));
      }
    });
    return c;
  }

  Future<List<Comment1>> getAlllevel2Comment(
      String postId, String parentCommentId) async {
    if (helper.lastParentCommentId != parentCommentId) {
      helper.lastCommentlevel2Query = null;
    }
    List<Comment1> c = [];
    final commentDocRef = helper.lastCommentlevel2Query == null
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
            .startAfter([helper.lastCommentlevel2Query])
            .limit(10)
            .get();

    if (commentDocRef.docs.isEmpty) {
      helper.lastCommentlevel2Query = null;
      return [];
    }
    helper.lastCommentlevel2Query = commentDocRef.docs[commentDocRef.size - 1];
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
    if (helper.lastGrandParentCommentId != grandParentCommentId) {
      helper.lastCommentlevel3Query = null;
    }
    List<Comment1> c = [];
    final commentDocRef = helper.lastCommentlevel3Query == null
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
            .startAfter([helper.lastCommentlevel3Query])
            .limit(10)
            .get();
    if (commentDocRef.docs.isEmpty) {
      helper.lastCommentlevel3Query = null;
      return [];
    }
    helper.lastCommentlevel3Query = commentDocRef.docs[commentDocRef.size - 1];

    for (int i = 0; i < commentDocRef.docs.length; i++) {
      c.add(Comment1.level3(
          commentDocRef.docs[i]['id'],
          commentDocRef.docs[i]['parentID'],
          commentDocRef.docs[i]['grandParentID'],
          UserDummy.fromJson(commentDocRef.docs[i]['user']),
          commentDocRef.docs[i]['content'],
          // childCommentCount: commentDocRef.docs[i]['childCommentCount'],
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
      await _db
          .collection('posts')
          .doc(postId)
          .update({'commentsCount': FieldValue.increment(1)});
    } else if (cmt == CommentLevel.two) {
      final comment = _db.collection('posts/$postId/comment').doc();
      reply.id = comment.id;
      comment
          .set(reply.toJson())
          .whenComplete(() => debugPrint('OK'))
          .catchError((e) => debugPrint(e));
      await _db
          .collection('posts/$postId/comment')
          .doc(reply.parentID)
          .update({'childCommentCount': FieldValue.increment(1)});
    } else if (cmt == CommentLevel.three) {
      final comment = _db.collection('posts/$postId/comment').doc();
      reply.id = comment.id;
      comment
          .set(reply.toJson())
          .whenComplete(() => debugPrint('OK'))
          .catchError((e) => debugPrint(e));
      await _db
          .collection('posts/$postId/comment')
          .doc(reply.parentID)
          .update({'childCommentCount': FieldValue.increment(1)});
    }
  }

// xóa comment và tất cả các child
  Future deleteComment(
      String postId, Comment1 comment, CommentLevel cmt) async {
    if (cmt == CommentLevel.three) {
      await _db
          .collection('posts/$postId/comment')
          .doc(comment.grandParentID)
          .update({'childCommentCount': FieldValue.increment(-1)});
      await _db
          .collection('posts/$postId/comment')
          .doc(comment.parentID)
          .update({'childCommentCount': FieldValue.increment(-1)});
      await _db
          .collection('posts')
          .doc(postId)
          .update({'commentsCount': FieldValue.increment(-1)});
      await _db.collection('posts/$postId/comment').doc(comment.id).delete();
    } else if (cmt == CommentLevel.two) {
      int totalCount = 1;
      await _db.collection('posts/$postId/comment').doc(comment.id).delete();
      final childComment = await _db
          .collection('posts/$postId/comment')
          .where('parentID', isEqualTo: comment.id)
          .get();
      if (childComment.docs.isEmpty) return;
      totalCount += childComment.docs.length;
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
      await _db
          .collection('posts/$postId/comment')
          .doc(comment.parentID)
          .update({'childCommentCount': FieldValue.increment(-totalCount)});
      await _db
          .collection('posts')
          .doc(postId)
          .update({'commentsCount': FieldValue.increment(-totalCount)});
    } else if (cmt == CommentLevel.one) {
      int totalCount = 1;
      await _db.collection('posts/$postId/comment').doc(comment.id).delete();
      final childComment = await _db
          .collection('posts/$postId/comment')
          .where('parentID', isEqualTo: comment.id)
          .where('grandParentID', isEqualTo: comment.id)
          .get();
      if (childComment.docs.isEmpty) return;
      totalCount += childComment.docs.length;
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
      await _db
          .collection('posts')
          .doc(postId)
          .update({'commentsCount': FieldValue.increment(-totalCount)});
    }
  }
}

class PaginatedQueryHelper {
  String lastPostId = ''; //for Comment
  String lastParentCommentId = ''; //for Comment
  String lastGrandParentCommentId = ''; //for Comment
  QueryDocumentSnapshot<Map<String, dynamic>>? lastPostQuery; //for PostPage
  QueryDocumentSnapshot<Map<String, dynamic>>?
      lastCommentlevel1Query; //for Comment
  QueryDocumentSnapshot<Map<String, dynamic>>?
      lastCommentlevel2Query; //for Comment
  QueryDocumentSnapshot<Map<String, dynamic>>?
      lastCommentlevel3Query; //for Comment
  dynamic t;
}
