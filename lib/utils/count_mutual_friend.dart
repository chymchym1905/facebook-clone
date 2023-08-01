int countMutualFriend(List<String> userfriend, List<String> otherfriend) {
  int count = 0;
  for (int i = 0; i < userfriend.length; i++) {
    int index = otherfriend.indexOf(userfriend[i].replaceAll(" ", ""));
    if (index != -1) {
      count++;
      String element = otherfriend.removeAt(index);
      otherfriend.insert(0, element);
    }
  }
  return count;
}
