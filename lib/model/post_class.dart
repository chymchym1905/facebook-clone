import 'package:flutter_application_1/model/user_class.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_class.g.dart';

// class Visibility{}
// class Public extends Visibility{}
// class Private extends Visibility{}

@JsonSerializable()
class Post {
  Post(this.id, this.user, this.caption, this.imageurl,
      {this.commentsCount = 0, this.reactionsCount = 0, this.sharesCount = 0});
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

  int reactionsCount;
  int commentsCount;
  int sharesCount;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
