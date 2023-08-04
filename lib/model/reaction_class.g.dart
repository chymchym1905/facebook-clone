// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reaction _$ReactionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['user', 'emoji'],
  );
  return Reaction(
    UserDummy.fromJson(json['user'] as Map<String, dynamic>),
    json['emoji'] as int,
    json['destinationID'] as String,
  );
}

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'user': instance.user,
      'destinationID': instance.destinationID,
      'emoji': instance.emoji,
    };
