// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppData {
    int notificationCount;
    List<dynamic> postlist; 
  AppData({
    required this.notificationCount,
    required this.postlist,
  });

  void incrementCount(){
    notificationCount++;
  }

}

class AppDataProvider extends InheritedWidget{
  final AppData data;
  const AppDataProvider(this.data, {Key? key, required Widget child}):super(key: key, child: child);

  static AppData of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AppDataProvider>()!.data;
  }
  
  @override
  bool updateShouldNotify(AppDataProvider oldWidget) {
    return data != oldWidget.data;
  }


}