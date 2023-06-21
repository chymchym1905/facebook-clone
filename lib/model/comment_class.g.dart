// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment1 _$Comment1FromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'username', 'content'],
  );
  return Comment1(
    json['id'] as String,
    (json['react'] as num?)?.toDouble(),
    json['username'] as String,
    json['content'] as String,
    json['imageurl'] as String,
    (json['reply'] as List<dynamic>)
        .map((e) =>
            e == null ? null : Comment1.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$Comment1ToJson(Comment1 instance) => <String, dynamic>{
      'id': instance.id,
      'react': instance.react,
      'username': instance.username,
      'content': instance.content,
      'imageurl': instance.imageurl,
      'reply': instance.reply,
    };
