import '../../../data/post.dart';
import '../../../index.dart';
import 'package:loading_more_list/loading_more_list.dart';

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

class _PostListViewState extends State<PostListView>
    with AutomaticKeepAliveClientMixin {
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    bool isRefreshing = false;
    final postProvider = Provider.of<PostProvider>(context);
    super.build(context);
    // AppData appdata = AppDataProvider.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        // print(isRefreshing);
        if (isRefreshing) {
          return;
        }
        isRefreshing = true;
        await widget.source.refresh();
        isRefreshing = false;
        // print(dbObject.helper.lastPostQuery?.data()['caption']);
        // print('${dbObject.helper.lastPostQuery?.data()['caption']} + \n');
      },
      child: LoadingMoreList<Post>(ListConfig<Post>(
        sourceList: widget.source,
        itemBuilder: (context, item, index) {
          postProvider.addPost(
              PostLocal(id: item.id, comment: [], checkLastComment: false));
          // var items = list.map((e) => Post.fromJson(e)).toList();
          return Posts(data: item);
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
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Text('No posts available',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
              );
            case IndicatorStatus.fullScreenBusying:
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
