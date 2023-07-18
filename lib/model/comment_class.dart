// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/model/reaction_class.dart';
import 'package:flutter_application_1/model/user_class.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_class.g.dart';

@JsonSerializable()
class Comment1 {
  @JsonKey(required: true)
  UserDummy user;
  double? react;
  // String timeAgo;
  @JsonKey(required: true)
  String content;

  List<Comment1> reply;

  List<Reaction> reactions;
  
  Comment1(
    this.user, 
    this.react, 
    this.content, 
    this.reply, 
    this.reactions
  );

  factory Comment1.fromJson(Map<String, dynamic> json) =>
      _$Comment1FromJson(json);

  Map<String, dynamic> toJson() => _$Comment1ToJson(this);
}
