import '../index.dart';

class PostList {
  List<dynamic> _post;
  PostList(this._post);

  List get post => _post;

  Future<void> readPostJsonData(start, end) async {
    final jsondata = await rootBundle.loadString('assets/jsons/posts.json');
    var string = json.decode(jsondata) as List<dynamic>;
    // await Future<List<Post>?>.delayed(const Duration(seconds: 1));
    _post = string.getRange(start,end).map((e) => Post.fromJson(e)).toList();
    
    // var _post1 = _post.map((e) => Post.fromJson(e)).toList();
    // _post =[];
    // for (int i =0; i<100; i++){
    //   _post.addAll(_post1);
    // }
    // print(_post);
  }
}
