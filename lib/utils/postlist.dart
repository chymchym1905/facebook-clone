// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_1/model/post_class.dart';

class PostList extends ValueNotifier<List<Post>> {
  
  List<dynamic> _post ;
  PostList(this._post) : super([]);

  List get post => _post;

  Future<void> readPostJsonData() async{
    final jsondata = await rootBundle.loadString('assets/jsons/posts.json');
    _post = json.decode(jsondata) as List<dynamic>;
    // await Future<List<Post>?>.delayed(const Duration(seconds: 1));
    _post = _post.map((e) => Post.fromJson(e)).toList();
    // print(_post);
    notifyListeners();
  }
}
