import '../../index.dart';

class LoadMoreCommentList extends StatefulWidget {
  const LoadMoreCommentList({super.key});

  @override
  State<LoadMoreCommentList> createState() => _LoadMoreCommentListState();
}

class _LoadMoreCommentListState extends State<LoadMoreCommentList> {
  final ScrollController _scrollController = ScrollController();
  List<Comment1> data = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {});
  }

  Future<void> fetchItems(String postID) async {
    if (isLoading) return;
    isLoading = true;
    try {
      final getter = await Database().getAlllevel1Comment(postID);
      for (final Comment1 item in getter) {
        if (hasMore) data.add(item);
      }
      hasMore = getter.isNotEmpty;
      page++;
    } catch (exception, stack) {
      if (kDebugMode) {
        print('Exception (* ￣︿￣): $exception');
        print('Stack (ﾟДﾟ*)ﾉ: $stack');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {},
    );
  }
}
