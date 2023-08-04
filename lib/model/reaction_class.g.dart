// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'user', 'reaction'],
  );
  return Reaction(
    json['id'] as String,
    UserDummy.fromJson(json['user'] as Map<String, dynamic>),
    json['reaction'] as int,
  );
}

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'reaction': instance.reaction,
    };
