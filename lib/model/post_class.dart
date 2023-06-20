import 'package:json_annotation/json_annotation.dart';

import 'user_class.dart';
import 'comment_class.dart';

part 'post_class.g.dart';

class Visibility{}
class Public extends Visibility{}
class Private extends Visibility{}

@JsonSerializable()
class Post {
  Post(
    this.iD,
    this.user,
    this.caption,
    this.timeAgo,
    this.visibility,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
    this.comment,
  );
  List<String>? imageUrl;
  @JsonKey(required: true)
  String iD;
  @JsonKey(required: true)
  User user;
   @JsonKey(required: true)
  String caption;
   @JsonKey(required: true)
  String timeAgo;
   @JsonKey(required: true)
  Visibility visibility;
   @JsonKey(required: true)
  int likes;
   @JsonKey(required: true)
  int comments;
   @JsonKey(required: true)
  int shares;
   @JsonKey(required: true)
  Comment1? comment;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
  
}








