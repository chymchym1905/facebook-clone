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
    final data = Database().getAlllevel1Comment(postID);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {},
    );
  }
}
