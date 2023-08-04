// import '../index.dart';

import '../model/reaction_class.dart';

// 0 : like
// 1 : love
// 2 : haha
// 3 : wow
// 4 : sad
// 5 : angry

void countReact(List<Reaction> reactions, Map<String, int> listreact) {
  for (int i = 0; i < reactions.length; i++) {
    switch (reactions[i].emoji) {
      case 0:
        listreact["like"] = (listreact["like"] ?? 0) + 1;
        break;
      case 1:
        listreact["love"] = (listreact["love"] ?? 0) + 1;
        break;
      case 2:
        listreact["haha"] = (listreact["haha"] ?? 0) + 1;
        break;
      case 3:
        listreact["wow"] = (listreact["wow"] ?? 0) + 1;
        break;
      case 4:
        listreact["sad"] = (listreact["sad"] ?? 0) + 1;
        break;
      case 5:
        listreact["angry"] = (listreact["angry"] ?? 0) + 1;
        break;
    }
  }
}
