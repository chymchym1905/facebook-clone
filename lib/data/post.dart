import 'package:flutter_application_1/index.dart';

class PostProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<PostLocal> _posts = [];

  List<PostLocal> get posts => _posts;

  Future<List<Comment1>> getCommentByID(
      String postID, int start, int end) async {
    final post = _posts.firstWhere((p) => p.id == postID,
        orElse: () => PostLocal(id: '', comments: []));
    if (post.comments.isEmpty) {
      List<Comment1> firebaseComment =
          await Database().getAlllevel1Comment(postID);
      post.comments = firebaseComment;
      return firebaseComment;
    }
    if (start > post.comments.length) {
      if (end >= post.comments.length + 1) {
        end = start;
      }
    } else {
      if (end >= post.comments.length) {
        end = post.comments.length;
      }
    }
    var rangeComment = post.comments.getRange(start, end).toList();
    return rangeComment;
  }

  void addPost(PostLocal post) {
    _posts.add(post);
    // notifyListeners();
  }
}

class PostLocal {
  String id;
  List<Comment1> comments;

  PostLocal({required this.id, required this.comments});
}
