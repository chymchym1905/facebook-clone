import '../index.dart';
import 'package:loading_more_list/loading_more_list.dart';

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
      List<dynamic>? posts;
      //to show loading more clearly, in your app,remove this
      await Future.delayed(const Duration(milliseconds: 500));
      await postManager.readPostJsonData(length, length + 100);
      posts = postManager.post;
      // print(fullPost);
      if (_pageIndex == 1) {
        clear();
      }
      for (final Post item in posts) {
        if (hasMore) add(item);
      }
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

class PostListView extends StatefulWidget {
  final LoadMorePost source;
  // final List<dynamic> list;
  // final ScrollController controller;
  final PageStorageKey pagekey;

  const PostListView({
    Key? key,
    // required this.list,
    // required this.controller,
    required this.source,
    required this.pagekey,
  }) : super(key: key);

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  void initState() {
    super.initState();
    initLoad();
  }

  void initLoad() async {
    // await widget.source.loadData()==true;
  }

  @override
  void dispose() {
    // widget.source.dispose();
    super.dispose();
  }

  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // AppData appdata = AppDataProvider.of(context);

    return ExtendedVisibilityDetector(
      uniqueKey: widget.pagekey,
      child: LoadingMoreList<Post>(ListConfig<Post>(
        sourceList: widget.source,
        itemBuilder: (context, item, index) {
          // var items = list.map((e) => Post.fromJson(e)).toList();
          return Posts(data: widget.source[index]);
        },
        indicatorBuilder: (context, status) {
          switch (status) {
            case IndicatorStatus.loadingMoreBusying:
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case IndicatorStatus.error:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ErrorWidget('Not found'),
                ),
              );
            case IndicatorStatus.noMoreLoad:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Come back tommrow!',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              );
            case IndicatorStatus.empty:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('No posts available',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              );
            case IndicatorStatus.fullScreenBusying:
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Fullscreen Busying...',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              );
            case IndicatorStatus.none:
            case IndicatorStatus.fullScreenError:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Cannot load data',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              );
          }
        },
      )),
    );

    // return ListView.builder(
    //   key: widget.key,
    //   padding: EdgeInsets.zero,
    //   itemCount: widget.source.length+1,
    //   itemBuilder: (context, index) {
    //     // var items = list.map((e) => Post.fromJson(e)).toList();
    //     if (index<widget.source.length){
    //       return Posts(data: widget.source[index]);
    //     }else{
    //       return const Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     }
    //   },
    //   );
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
