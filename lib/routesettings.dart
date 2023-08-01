import 'package:flutter_application_1/screens/Authentication_pages/forgotpasswordscreen.dart';
import 'package:flutter_application_1/screens/Gallery_view_pages/galleryview.dart';
import 'package:flutter_application_1/widgets/friends_page.dart';

import 'index.dart';

import 'widgets/user_page.dart';
import 'screens/watch_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const FakeBook());
      // case '/login':
      //   return MaterialPageRoute(builder: (_) => const LoginRegister());
      // case '/home':
      //   return MaterialPageRoute(builder: (_) => const Home());
      case '/forgotpassword':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => ForgotPasswordPage(email: args));
        }
      case '/watch':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => Watch(data: args));
        }
      case '/posts':
        final arg = args as Postpage;
        return MaterialPageRoute(
            builder: (_) => Postpage(
                  data: arg.data,
                  reloadState: arg.reloadState,
                ));
      case '/gallery':
        final arg = args as GalleryViewPage;
        return MaterialPageRoute(
            builder: (_) => GalleryViewPage(
                initialIndex: arg.initialIndex,
                data: arg.data,
                isPostpage: arg.isPostpage));
      case '/viewreaction':
        final arg = args as ReactionPage;
        return MaterialPageRoute(
            builder: (_) => ReactionPage(
                  reactions: arg.reactions,
                  sortedList: args.sortedList,
                  totalReact: args.totalReact,
                ));
      case '/profile':
        // final arg = args as ProfilePage;
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/createpost':
        return MaterialPageRoute(builder: (_) => const CreatePost());
      case '/userprofile':
        final arg = args as UserPage;
        return MaterialPageRoute(
            builder: (_) => UserPage(
                  user: arg.user,
                  posts: args.posts,
                ));
      case '/friends':
        final arg = args as Friend;
        return MaterialPageRoute(
            builder: (_) => Friend(userFriends: arg.userFriends));
      default:
        return _errorRoute();
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
