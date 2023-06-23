// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'comment_class.g.dart';

@JsonSerializable()
class Comment1 {
  @JsonKey(required: true)
  String id;
  double? react;
  // String timeAgo;
  @JsonKey(required: true)
  String username;
  @JsonKey(required: true)
  String content;
  String imageurl;
  List<Comment1> reply;
  Comment1(
    this.id,
    this.react,
    this.username,
    this.content,
    this.imageurl,
    this.reply);

  factory Comment1.fromJson(Map<String, dynamic> json) => _$Comment1FromJson(json);

  Map<String, dynamic> toJson() => _$Comment1ToJson(this);

}
