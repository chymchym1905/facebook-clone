import 'package:json_annotation/json_annotation.dart';

part 'user_class.g.dart';

@JsonSerializable()
class User {
  User(
    this.id,
    this.name,
    this.imageUrl,
  );
  String imageUrl;

  @JsonKey(required: true)
  String id;

  @JsonKey(required: true)
  String name;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}