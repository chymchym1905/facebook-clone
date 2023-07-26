import '../main.dart';
import '../model/reaction_class.dart';

void findUserReact(String userName, List<Reaction> reactions, int reaction) {
  for (int i = 0; i < reactions.length; i++) {
    if (reactions[i].user.name == userName) {
      if (reaction != 0) {
        reactions[i].reaction = reaction - 1;
        return;
      } else {
        reactions.removeAt(0);
        return;
      }
    }
  }
  reactions.insert(0, Reaction(currUser!, reaction - 1));
}
