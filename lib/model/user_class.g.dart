// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name'],
  );
  return User(
    json['id'] as String,
    json['name'] as String,
    json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'id': instance.id,
      'name': instance.name,
    };
