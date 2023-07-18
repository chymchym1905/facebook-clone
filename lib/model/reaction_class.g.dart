// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user', 'reaction'],
  );
  return Reaction(
    UserDummy.fromJson(json['user'] as Map<String, dynamic>),
    json['reaction'] as int,
  );
}

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'user': instance.user,
      'reaction': instance.reaction,
    };
