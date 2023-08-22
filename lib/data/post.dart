import 'package:flutter_application_1/index.dart';

class PostProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<PostLocal> _posts = [];

  List<PostLocal> get posts => _posts;

  Future<List<Comment1>> getCommentLevel1(
      String postID, int? start, int? end) async {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(
            id: '', comment: [], commentLevel2: [], commentLevel3: []));
    if (post.comment.isEmpty) {
      List<Comment1> firebaseComment =
          await dbObject.getAlllevel1Comment(postID);
      post.comment = firebaseComment;
      return firebaseComment;
    }
    List<Comment1> rangeComment = [];
    if (start != null && end != null) {
      if (start > post.comment.length) {
        if (end >= post.comment.length + 1) {
          end = start;
        }
      } else {
        if (end >= post.comment.length) {
          end = post.comment.length;
        }
      }
      rangeComment = post.comment.getRange(start, end).toList();
      return rangeComment;
    }
    return post.comment;
  }

  void addPost(PostLocal post) {
    _posts.add(post);
  }

  void addCommentLevel1(String postID, Comment1 newComment) {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(
            id: '', comment: [], commentLevel2: [], commentLevel3: []));
    post.comment.add(newComment);
    notifyListeners();
  }
}

class PostLocal {
  String id;
  List<Comment1> comment;
  List<Comment1> commentLevel2;
  List<Comment1> commentLevel3;

  PostLocal(
      {required this.id,
      required this.comment,
      required this.commentLevel2,
      required this.commentLevel3});
}
