// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user', 'caption'],
  );
  return Post(
    UserDummy.fromJson(json['user'] as Map<String, dynamic>),
    json['caption'] as String,
    (json['imageurl'] as List<dynamic>).map((e) => e as String).toList(),
    json['likes'] as int?,
    json['shares'] as int?,
    (json['comment'] as List<dynamic>)
        .map((e) => Comment1.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['reactions'] as List<dynamic>)
        .map((e) => Reaction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'user': instance.user,
      'caption': instance.caption,
      'imageurl': instance.imageurl,
      'reactions': instance.reactions,
      'likes': instance.likes,
      'shares': instance.shares,
      'comment': instance.comment,
    };
