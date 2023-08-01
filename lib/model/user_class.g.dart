// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDummy _$UserDummyFromJson(Map<String, dynamic> json) => UserDummy(
      json['name'] as String,
      json['gender'] as String,
      json['imageurl'] as String,
      json['email'] as String,
      UserDummy._timestampToJson(json['createDate'] as Timestamp),
      (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserDummyToJson(UserDummy instance) => <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'imageurl': instance.imageurl,
      'email': instance.email,
      'createDate': UserDummy._dateTimeToJson(instance.createDate),
      'friends': instance.friends,
    };
