import 'package:flutter_application_1/index.dart';

class FocusNodeProvider extends ChangeNotifier {
  // int _notificationCount = 0;
  final FocusNode commentPostPage = FocusNode();
  final FocusNode commentModal = FocusNode();

  @override
  void dispose() {
    commentPostPage.dispose();
    commentModal.dispose();
    super.dispose();
  }
}
