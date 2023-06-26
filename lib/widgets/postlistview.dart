import '../index.dart';
import 'package:loading_more_list/loading_more_list.dart';


class LoadMorePost extends LoadingMoreBase<Post>{
  List posts = [];
  bool _hasMore = true;
  bool forceRefresh = false;


  @override
  bool get hasMore => (_hasMore && length < 40) || forceRefresh;

  // @override
  // Future<bool> refresh([bool clearBeforeRequest = false]) async {
  //   _hasMore = true;
  //   //force to refresh list when you don't want clear list before request
  //   //for the case, if your list already has 20 items.
  //   forceRefresh = !clearBeforeRequest;
  //   var result = await super.refresh(clearBeforeRequest);
  //   forceRefresh = false;
  //   return result;
  // }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false;
    try {
      //to show loading more clearly, in your app,remove this
      await Future.delayed(const Duration(milliseconds: 500));

      if (index + 5<fullPost.length){
        posts = fullPost.sublist(index, index + 5);
        index +=5;
        for (int i = 0; i<posts.length; i++) {add(posts[i]);}
        _hasMore = true;
        print(index);
      }else if(index+5 >= fullPost.length && index != fullPost.length){
        posts = fullPost.sublist(index, fullPost.length);
        index = fullPost.length;
        for (int i = 0; i<posts.length; i++) {add(posts[i]);}
        _hasMore=false;
        print(index);
      }else{
        if (kDebugMode) {
          // print(index);
        }
      }
    isSuccess =  true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }
}

class PostListView extends StatefulWidget {
  
  final List<dynamic> list;
  final ScrollController controller;
  final PageStorageKey pagekey;

  const PostListView({
    Key? key,
    required this.list,
    required this.controller,
    required this.pagekey,
  }) : super(key: key);

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> with AutomaticKeepAliveClientMixin{
  final LoadMorePost source = LoadMorePost();

  @override
  void dispose() {
    source.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // AppData appdata = AppDataProvider.of(context);
    return ExtendedVisibilityDetector(
      uniqueKey: widget.pagekey,
      child: LoadingMoreList<Post>(
        ListConfig<Post>(
          sourceList: source,
          itemBuilder: (context, item, index) {
          // var items = list.map((e) => Post.fromJson(e)).toList();
            return Posts(data: source[index]);
          },
          indicatorBuilder: (context, status) {
            switch(status){
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
                    child: Text('Come back tommrow!', style: Theme.of(context).textTheme.titleMedium),
                  ),
                );
              case IndicatorStatus.empty:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('No posts available', style: Theme.of(context).textTheme.titleMedium),
                  ),
                );
              case IndicatorStatus.fullScreenBusying:
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case IndicatorStatus.none:
              case IndicatorStatus.fullScreenError:
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Fullscreen Error', style: Theme.of(context).textTheme.titleMedium),
                  ),
                );
            }

          },
          )
      ),
    );
  
      // child: ListView.builder(
      //   key: pagekey,
      //   controller: controller,
      //   padding: EdgeInsets.zero,
      //   itemCount: list.length+1,
      //   itemBuilder: (context, index) {
      //     // var items = list.map((e) => Post.fromJson(e)).toList();
      //     if (index<list.length){
      //       return Posts(data: list[index]);
      //     }else{
      //       return const Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       );
      //     }
      //   },
      //   addAutomaticKeepAlives: true,),
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
