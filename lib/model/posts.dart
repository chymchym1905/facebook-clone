
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';

class Post{
  final iD;
  User user;
  String caption;
  String timeAgo;
  List<String>? imageUrl;
  final likes;
  final comments;
  final shares;
  Comment? comment;


  Post({
    required this.iD,
    required this.user,
    required this.caption,
    required this.timeAgo,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
});
}

class Comment{
  final postID;
  String username;
  String  content;

  Comment({required this.postID, required this.username, required this.content});
}





class Posts extends StatelessWidget{
  Posts({super.key, required this.data});
  Post data;
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Color.fromARGB(255, 199, 167, 27)
    );
  }
}