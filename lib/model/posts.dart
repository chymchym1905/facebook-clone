
import 'package:flutter_application_1/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'comments.dart';
// import 'fb_reaction_box.dart';
import 'package:flutter_application_1/main.dart';




class Post{
  final int iD;
  User user;
  String caption;
  String timeAgo;
  List<String>? imageUrl;
  final int likes;
  final int comments;
  final int shares;
  Comment1? comment;

  List<String>? get getImage => imageUrl;
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



class Posts extends StatefulWidget {
  const Posts({Key? key, required this.data}) : super(key: key);
  final Post data;
  State<Posts> createState() => _PostsState();
  
}
class _PostsState extends State<Posts>{
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () => setState(() {
            Navigator.of(context).pushNamed('/posts',
            arguments: widget.data);
          }),
          child: Ink(
            height: 100,
            color: themeManager.themeMode == dark? Color.fromARGB(255, 38, 38, 38) : Color.fromARGB(255, 255, 255, 255),
          ),
        ),
    );
  }
}




