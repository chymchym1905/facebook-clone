// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'user', 'caption'],
  );
  return Post(
    json['id'] as String,
    UserDummy.fromJson(json['user'] as Map<String, dynamic>),
    json['caption'] as String,
    (json['imageurl'] as List<dynamic>).map((e) => e as String).toList(),
    commentsCount: json['commentsCount'] as int? ?? 0,
    reactionsCount: json['reactionsCount'] as int? ?? 0,
    sharesCount: json['sharesCount'] as int? ?? 0,
  )..createDate = Post._timestampTotimestamp(json['createDate']);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'caption': instance.caption,
      'imageurl': instance.imageurl,
      'createDate': Post._timestampTotimestamp(instance.createDate),
      'reactionsCount': instance.reactionsCount,
      'commentsCount': instance.commentsCount,
      'sharesCount': instance.sharesCount,
    };
