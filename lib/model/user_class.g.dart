// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDummy _$UserDummyFromJson(Map<String, dynamic> json) => UserDummy(
      json['id'] as String,
      json['name'] as String,
      json['imageurl'] as String,
    )..createAt = DateTime.parse(json['createAt'] as String);

Map<String, dynamic> _$UserDummyToJson(UserDummy instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageurl': instance.imageurl,
      'createAt': instance.createAt.toIso8601String(),
    };
