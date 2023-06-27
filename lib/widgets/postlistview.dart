// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pagination_view/pagination_view.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/model/appdata.dart';
// import 'package:flutter_application_1/main.dart';
// import 'package:flutter_application_1/model/post_class.dart';

import 'post_card_container.dart';

class PostListView extends StatelessWidget {
  
  final List<dynamic> list;
  final PageStorageKey pagekey;

  const PostListView({
    Key? key,
    required this.list,
    required this.pagekey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppData appdata = AppDataProvider.of(context);
    return CustomScrollView(
      key: pagekey,
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverPadding(
        padding: EdgeInsets.zero,
        sliver: SliverList.builder(
          itemCount: list.length+1,
          itemBuilder: (context, index) {
            // var items = list.map((e) => Post.fromJson(e)).toList();
            if (index<list.length){
              return Posts(data: list[index]);
            }else{
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          addAutomaticKeepAlives: true,),
      ),]
    );
  }
}

  //   int offset = 0;
  //  Future<List<Post>> pageFetch(int offset) async {
  //   final startIndex = offset;
  //   var endIndex = startIndex + 8;
  //   var items = await rootBundle.loadString('assets/jsons/posts.json');
  //   final list = json.decode(items) as List<dynamic> ;
  //   if (endIndex > list.length){
  //     endIndex = list.length;
  //   }
  //   final nextUsersList = list.sublist(startIndex, endIndex);

  //   await Future<List<Post>?>.delayed(const Duration(seconds: 1));
  //   return nextUsersList.map((e) => Post.fromJson(e)).toList();
  // }
