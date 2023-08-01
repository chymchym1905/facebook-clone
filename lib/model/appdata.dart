// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import '../index.dart';

// class AppData {
//   int notificationCount;
//   final FocusNode commentPostPage;
//   final FocusNode commentModal;
//   // Function(Post) updateCallback;
//   // Function(BuildContext) navigateCallback;
//   // Post currentViewData =
//   //     Post("", UserDummy("", "", ""), "", [], 0, 0, 0, [], 0);

//   AppData({
//     required this.notificationCount,
//     required this.commentPostPage,
//     required this.commentModal,
//     // required this.updateCallback,
//     // required this.navigateCallback,
//   });

//   void incrementCount() {
//     notificationCount++;
//   }

//   // void updateState(Post data) {
//   //   currentViewData = data;
//   // }
// }

// class AppDataProvider extends InheritedWidget {
//   final AppData data;
//   const AppDataProvider(this.data, {Key? key, required Widget child})
//       : super(key: key, child: child);

//   static AppData of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AppDataProvider>()!.data;
//   }

//   @override
//   bool updateShouldNotify(AppDataProvider oldWidget) {
//     return data != oldWidget.data;
//   }
// }
