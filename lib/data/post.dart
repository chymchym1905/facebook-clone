import 'package:flutter_application_1/index.dart';

class PostProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<PostLocal> _posts = [];

  List<PostLocal> get posts => _posts;

  List<Comment1> getCommentLevel1(String postID) {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(id: '', comment: [], checkLastComment: false));
    return post.comment;
  }

  void addPost(PostLocal newPost) {
    // ignore: unused_local_variable
    final post = _posts.firstWhere(
      (p) => p.id == newPost.id,
      orElse: () {
        _posts.add(newPost);
        return newPost;
      },
    );
  }

  void setCommentLevel1(String postID, List<Comment1> comments) {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(id: '', comment: [], checkLastComment: false));
    post.comment = comments;
    notifyListeners();
  }

  void addCommentLevel1(String postID, Comment1 newComment) {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(id: '', comment: [], checkLastComment: false));
    for (int i = 0; i < post.comment.length; i++) {
      if (post.comment[i].id == newComment.id) {
        return;
      }
    }
    post.comment.add(newComment);
    notifyListeners();
  }

  void setEndCommnt(String postID) {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(id: '', comment: [], checkLastComment: false));
    post.checkLastComment = true;
    notifyListeners();
  }

  bool checkEndComment(String postID) {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(id: '', comment: [], checkLastComment: false));
    return post.checkLastComment;
  }
}

class PostLocal {
  String id;
  bool checkLastComment;
  List<Comment1> comment;

  PostLocal(
      {required this.id,
      required this.comment,
      required this.checkLastComment});
}
