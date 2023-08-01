// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/index.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_class.g.dart';

@JsonSerializable()
class UserDummy {
  UserDummy(this.name, this.gender, this.imageurl, this.email, this.createDate,
      this.friends);

  String name;
  String gender;
  String imageurl;
  String email;
  @JsonKey(toJson: _dateTimeToJson, fromJson: _timestampToJson)
  DateTime createDate;
  List<String> friends;

  static DateTime _dateTimeToJson(DateTime dateTime) {
    return dateTime.toUtc();
  }

  static DateTime _timestampToJson(Timestamp dateTime) {
    return dateTime.toDate().toUtc();
  }

  factory UserDummy.fromJson(Map<String, dynamic> json) =>
      _$UserDummyFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserDummyToJson(this);
}
