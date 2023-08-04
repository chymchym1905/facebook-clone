import 'package:flutter_application_1/model/user_class.dart';
import 'package:json_annotation/json_annotation.dart';
import 'comment_class.dart';
import 'reaction_class.dart';
part 'post_class.g.dart';

// class Visibility{}
// class Public extends Visibility{}
// class Private extends Visibility{}

@JsonSerializable()
class Post {
  Post(
      this.id,
      this.user,
      this.caption,
      // this.visibility,
      this.imageurl,
      this.likes,
      this.shares,
      this.comment,
      this.reactions);
  @JsonKey(required: true)
  String id;
  @JsonKey(required: true)
  UserDummy user;
  @JsonKey(required: true)
  String caption;
  // TimeElement timeAgo;
  @JsonKey(required: false)
  // Visibility visibility;
  List<String> imageurl;

  List<Reaction> reactions;
  List<Comment1> comment;

  int? likes;

  int? shares;
  // List<String> comment;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
