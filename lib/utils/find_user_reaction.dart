import '../model/reaction_class.dart';

void findUserReact(String userName, List<Reaction> reactions) {
  int index = reactions.indexWhere((element) => element.user.name == userName);
  if (index != -1) {
    Reaction element = reactions.removeAt(index);
    reactions.insert(0, element);
  }
}
