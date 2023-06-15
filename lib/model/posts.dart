import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'posts.g.dart';

@JsonSerializable()
class SinglePost{
  final iD;
  String username;
  String content;
  List<Image>? images;
  Comment? comment;

  SinglePost({required this.iD, required this.username, required this.content, this.images, this.comment});
  factory SinglePost.fromJson(Map<String, dynamic> json) => $_SinglePostFromJson(json);
  Map<String, dynamic> toJson() => $SinglePostToJson(this);
}
@JsonSerializable()
class Comment{
  final postID;
  String username;
  String  content;

  Comment({required this.postID, required this.username, required this.content});
}





class Posts extends StatelessWidget{
  const Posts({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('2nd page'),
      ),
      body: Center(
        child: Text(data),
      )
    );
  }
}