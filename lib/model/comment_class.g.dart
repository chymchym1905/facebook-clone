// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment1 _$Comment1FromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user', 'content'],
  );
  return Comment1(
    UserDummy.fromJson(json['user'] as Map<String, dynamic>),
    json['content'] as String,
    (json['reply'] as List<dynamic>)
        .map((e) => Comment1.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['reactions'] as List<dynamic>)
        .map((e) => Reaction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$Comment1ToJson(Comment1 instance) => <String, dynamic>{
      'user': Comment1._usertoJson(instance.user),
      'content': instance.content,
      'reply': instance.reply,
      'reactions': instance.reactions,
    };
