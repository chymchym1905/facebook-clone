// import '../index.dart';

import '../model/reaction_class.dart';

// 0 : like
// 1 : love
// 2 : haha
// 3 : wow
// 4 : sad
// 5 : angry

void countReact(List<Reaction> reactions, List<int> listreact){
  for(int i = 0; i < reactions.length; i++){
    switch(reactions[i].reaction){
      case 0:
        listreact[0]++;
        break;
      case 1:
        listreact[1]++;
        break;
      case 2:
        listreact[2]++;
        break;
      case 3:
        listreact[3]++;
        break;
      case 4:
        listreact[4]++;
        break;
      case 5:
        listreact[5]++;
        break;
    }
  }
}