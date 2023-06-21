import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:flutter_application_1/model/post_class.dart';
import '../widgets/post_card_container.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  int page = 10;
  PaginationViewType paginationViewType = PaginationViewType.listView;
  late ScrollController _scrollController;
  double _savedScrollPosition = 0.0;

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
    _restoreScrollPosition();
  }

   @override
  void dispose() {
    _saveScrollPosition();
    _scrollController.dispose();
    super.dispose();
  }

  void _saveScrollPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('scrollPosition', _scrollController.offset);
  }

Future<void> _restoreScrollPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final double savedScrollPosition = prefs.getDouble('scrollPosition') ?? 0;
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(savedScrollPosition);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return PaginationView(
      scrollController: _scrollController,
      pullToRefresh: true,
      paginationViewType: paginationViewType,
      itemBuilder: (BuildContext context, Post post, int index){
        return Posts(data: post);
      }, 
      pageFetch: pageFetch, 
      physics: BouncingScrollPhysics(),
      onError: (dynamic error) => Center(
        child: Text('Some error occured'),
      ),
      onEmpty: Center(
        child: Text('Sorry! This is empty'),
      ),
      bottomLoader: Center(
        child: CircularProgressIndicator(),
      ),
      initialLoader: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

    int offset = 0;
   Future<List<Post>> pageFetch(int offset) async {
    final startIndex = offset;
    var endIndex = startIndex + 8;
    var items = await rootBundle.loadString('assets/jsons/posts.json');
    final list = json.decode(items) as List<dynamic> ;
    if (endIndex > list.length){
      endIndex = list.length;
    }
    final nextUsersList = list.sublist(startIndex, endIndex);

    await Future<List<Post>?>.delayed(const Duration(seconds: 1));
    return nextUsersList.map((e) => Post.fromJson(e)).toList();
  }
}