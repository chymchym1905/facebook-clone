// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:flutter_application_1/model/user_class.dart';


import 'comment_class.dart';
// import 'fb_reaction_box.dart';


class Visibility{}
class Public extends Visibility{}
class Private extends Visibility{}


class Post {
  final int iD;
  User user;
  String caption;
  String timeAgo;
  Visibility visibility;
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
    required this.visibility,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    this.comment,
  });
}








