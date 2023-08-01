import 'package:flutter_application_1/index.dart';

class FriendProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<UserDummy?> _friends = [];
  List<UserDummy?> get friends => _friends;
}
