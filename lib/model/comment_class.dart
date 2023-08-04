// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_application_1/model/user_class.dart';

import '../index.dart';

part 'comment_class.g.dart';

@JsonSerializable()
class Comment1 {
  @JsonKey(required: true)
  String id;
  @JsonKey(required: false)
  String? parentID;
  @JsonKey(required: false)
  String? grandParentID;
  @JsonKey(required: true, toJson: _usertoJson)
  UserDummy user;
  // String timeAgo;
  @JsonKey(required: true)
  String content;
  @JsonKey(required: false)
  int childCommentCount;
  int reactionCount;
  Comment1? firstChild;
  @JsonKey(fromJson: _timestampTotimestamp, toJson: _timestampTotimestamp)
  Timestamp createDate;

  //tạo comment level 1
  Comment1(this.id, this.user, this.content,
      {this.childCommentCount = 0, this.reactionCount = 0, this.firstChild})
      : createDate = Timestamp.now();
  //tạo comment level 2
  Comment1.level2(this.id, this.parentID, this.user, this.content,
      {this.childCommentCount = 0, this.reactionCount = 0, this.firstChild})
      : createDate = Timestamp.now();
  //tạo comment level 3
  Comment1.level3(
      this.id, this.parentID, this.grandParentID, this.user, this.content,
      {this.childCommentCount = 0, this.reactionCount = 0})
      : createDate = Timestamp.now();

  static Map<String, dynamic> _usertoJson(UserDummy user) {
    return user.toJson();
  }

  static Timestamp _timestampTotimestamp(dynamic dateTime) {
    return dateTime;
  }

  factory Comment1.fromJson(Map<String, dynamic> json) =>
      _$Comment1FromJson(json);

  Map<String, dynamic> toJson() => _$Comment1ToJson(this);
}
