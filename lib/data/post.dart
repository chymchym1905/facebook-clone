import 'package:flutter_application_1/index.dart';

class PostProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<PostLocal> _posts = [];

  List<PostLocal> get posts => _posts;

  // Future<List<Comment1>> getCommentLevel1(
  //     String postID, int? start, int? end) async {
  //   final post = _posts.firstWhere((p) => p.id == postID,
  //       orElse: () => PostLocal(
  //           id: '', comment: [], commentLevel2: [], commentLevel3: []));
  //   if (post.comment.isEmpty) {
  //     List<Comment1> firebaseComment =
  //         await Database().getAlllevel1Comment(postID);
  //     post.comment = firebaseComment;
  //     return firebaseComment;
  //   }
  //   List<Comment1> rangeComment = [];
  //   if (start != null && end != null) {
  //     if (start > post.comment.length) {
  //       if (end >= post.comment.length + 1) {
  //         end = start;
  //       }
  //     } else {
  //       if (end >= post.comment.length) {
  //         end = post.comment.length;
  //       }
  //     }
  //     rangeComment = post.comment.getRange(start, end).toList();
  //     return rangeComment;
  //   }
  //   return post.comment;
  // }
  List<Comment1> getCommentLevel1(String postID) {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(id: '', comment: [], checkLastComment: false));
    return post.comment;
  }

  void addPost(PostLocal newPost) {
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
    post.comment.insert(0, newComment);
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
