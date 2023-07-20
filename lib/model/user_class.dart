// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'user_class.g.dart';

@JsonSerializable()
class UserDummy {
  UserDummy(this.id, this.name, this.gender, this.imageurl, this.email,
      this.createDate);

  String id;
  String name;
  String gender;
  String imageurl;
  String email;
  @JsonKey(toJson: _dateTimeToJson)
  DateTime createDate;

  static DateTime _dateTimeToJson(DateTime dateTime) {
    return dateTime.toUtc();
  }

  factory UserDummy.fromJson(Map<String, dynamic> json) =>
      _$UserDummyFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserDummyToJson(this);
}
