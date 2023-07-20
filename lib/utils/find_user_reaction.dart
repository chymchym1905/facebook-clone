import '../model/reaction_class.dart';

int findUserReact(int reaction, List<Reaction> reactions){
  int index = -1;
  for(int i = 0; i < reactions.length; i++){
    if(reactions[i].reaction == reaction){
      return index;
    }
  }
  return index;
}