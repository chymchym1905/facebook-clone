import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/friends.dart';
import 'package:flutter_application_1/posts.dart';
import 'package:flutter_application_1/watch.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/friends':
        if(args is String){
          return MaterialPageRoute(builder: (_) => Friends(data: args));
        }
      case '/watch':
        if(args is String){
          return MaterialPageRoute(builder: (_) => Watch(data: args));
        }
      case 'posts':
        if(args is String){
          return MaterialPageRoute(builder: (_) => Posts(data: args));
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
