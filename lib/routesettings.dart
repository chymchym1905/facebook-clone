import 'package:flutter/material.dart';
import 'main.dart';
import 'screens/friends_page.dart';
import 'model/post_class.dart';
import 'screens/watch_page.dart';
import 'screens/Post_page/post_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/friends':
        if(args is String){
          return MaterialPageRoute(builder: (_) => Friends(data: args));
        }
      case '/watch':
        if(args is String){
          return MaterialPageRoute(builder: (_) => Watch(data: args));
        }
      case '/posts':
        if(args is Post){
          return MaterialPageRoute(builder: (_) => Postpage(data: args));
        }
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
