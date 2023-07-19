// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'user_class.g.dart';

@JsonSerializable()
class UserDummy {
  UserDummy(this.id, this.name, this.imageurl);

  String id;
  String name;
  String imageurl;
  DateTime createAt = DateTime.now();

  factory UserDummy.fromJson(Map<String, dynamic> json) =>
      _$UserDummyFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserDummyToJson(this);
}
