// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDummy _$UserDummyFromJson(Map<String, dynamic> json) => UserDummy(
      json['id'] as String,
      json['name'] as String,
      json['gender'] as String,
      json['imageurl'] as String,
      json['email'] as String,
      DateTime.parse(json['createDate'] as String),
    );

Map<String, dynamic> _$UserDummyToJson(UserDummy instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'imageurl': instance.imageurl,
      'email': instance.email,
      'createDate': UserDummy._dateTimeToJson(instance.createDate),
    };
