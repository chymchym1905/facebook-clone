import '../index.dart';

ImageProvider imageAvatar(String string) {
  //user for circle avatar of user
  if (string.isEmpty) {
    return const AssetImage("assets/images/blank-profile-picture.png");
  } else {
    return NetworkImage(string);
  }
}
