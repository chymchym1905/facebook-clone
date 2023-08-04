import 'package:loading_more_list/loading_more_list.dart';

import '../data/post.dart';
import '../index.dart';

class LoadMoreComment extends LoadingMoreBase<Comment1> {
  final PostProvider postProvider;
  final String commentID;
  LoadMoreComment(this.postProvider, this.commentID);
  // bool isFirstLoad = true;
  bool _hasMore = true;
  bool forceRefresh = false;
  int _pageIndex = 1;

  @override
  bool get hasMore => (_hasMore && length < 1000) || forceRefresh;

  @override
  // ignore: avoid_renaming_method_parameters
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    _pageIndex = 1;
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
      List<Comment1> comments =
          await postProvider.getCommentByID(commentID, length, length + 5);
      //to show loading more clearly, in your app,remove this
      await Future.delayed(const Duration(milliseconds: 500));
      // print(fullPost);
      if (_pageIndex == 1) {
        clear();
      }
      for (final Comment1 item in comments) {
        if (hasMore) add(item);
      }
      // if (res==false)_hasMore=false;
      _hasMore = comments.isNotEmpty;
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
