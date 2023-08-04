// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment1 _$Comment1FromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'user', 'content'],
  );
  return Comment1(
    json['id'] as String,
    UserDummy.fromJson(json['user'] as Map<String, dynamic>),
    json['content'] as String,
    childCommentCount: json['childCommentCount'] as int? ?? 0,
    reactionCount: json['reactionCount'] as int? ?? 0,
    firstChild: json['firstChild'] == null
        ? null
        : Comment1.fromJson(json['firstChild'] as Map<String, dynamic>),
  )
    ..parentID = json['parentID'] as String?
    ..grandParentID = json['grandParentID'] as String?
    ..createDate = Comment1._timestampTotimestamp(json['createDate']);
}

Map<String, dynamic> _$Comment1ToJson(Comment1 instance) => <String, dynamic>{
      'id': instance.id,
      'parentID': instance.parentID,
      'grandParentID': instance.grandParentID,
      'user': Comment1._usertoJson(instance.user),
      'content': instance.content,
      'childCommentCount': instance.childCommentCount,
      'reactionCount': instance.reactionCount,
      'firstChild': instance.firstChild,
      'createDate': Comment1._timestampTotimestamp(instance.createDate),
    };
