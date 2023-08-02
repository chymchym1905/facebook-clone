import 'package:flutter_application_1/model/user_class.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reaction_class.g.dart';

// 0 : like
// 1 : love
// 2 : haha
// 3 : wow
// 4 : sad
// 5 : angry

@JsonSerializable()
class Reaction {
  Reaction(this.id, this.user, this.reaction);
  @JsonKey(required: true)
  String id;
  @JsonKey(required: true)
  UserDummy user;

  @JsonKey(required: true)
  int reaction;

  factory Reaction.fromJson(Map<String, dynamic> json) =>
      _$ReactionFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionToJson(this);
}
