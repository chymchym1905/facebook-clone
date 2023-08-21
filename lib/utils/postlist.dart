import 'package:loading_more_list/loading_more_list.dart';

import '../index.dart';

// class PostList {
//   List<dynamic> _post;
//   PostList(this._post);

//   List get post => _post;

//   Future<void> readPostJsonData(start, end) async {
//     // final jsondata = await rootBundle.loadString('assets/jsons/posts.json');
//     // var string = json.decode(jsondata) as List<dynamic>;
//     var string = await dbObject.getAllPost();
//     await Future<List<Post>?>.delayed(const Duration(seconds: 1));
//     // _post = string.getRange(start, end).map((e) => Post.fromJson(e)).toList();
//     if (string.isNotEmpty && string.length >= end) {
//       // print('$start+$end+${string.length}');

//       _post = string.getRange(start, end).toList();
//     } else {
//       _post = [];
//     }

//     // var _post1 = _post.map((e) => Post.fromJson(e)).toList();
//     // _post =[];
//     // for (int i =0; i<100; i++){
//     //   _post.addAll(_post1);
//     // }
//     // print(_post);
//   }
// }

class LoadMorePost extends LoadingMoreBase<Post> {
  // bool isFirstLoad = true;
  bool _hasMore = true;
  bool forceRefresh = false;
  int _pageIndex = 1;

  @override
  bool get hasMore => (_hasMore && length < 1000) || forceRefresh;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    _pageIndex = 1;
    dbObject.helper.lastPostQuery = null;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false;
    try {
      List<Post>? posts = await dbObject.getPosts();
      //to show loading more clearly, in your app,remove this
      await Future.delayed(const Duration(milliseconds: 500));
      // posts = postManager.post;
      // print(fullPost);
      if (_pageIndex == 1) {
        //clear list when refresh
        clear();
      }
      for (final Post item in posts) {
        if (hasMore) add(item);
      }
      // if (res==false)_hasMore=false;
      _hasMore = posts.isNotEmpty;
      _pageIndex++;
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      if (kDebugMode) {
        print(exception);
        print(stack);
      }
    }
    return isSuccess;
  }
}
