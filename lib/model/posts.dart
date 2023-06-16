import 'package:comment_tree/comment_tree.dart';
import 'package:flutter_application_1/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_brand_palettes/palettes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'fb_reaction_box.dart';
import 'package:flutter_application_1/main.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';


const _blue = Facebook.blue();
class Post{
  final int iD;
  User user;
  String caption;
  String timeAgo;
  List<String>? imageUrl;
  final int likes;
  final int comments;
  final int shares;
  Comment? comment;

  List<String>? get getImage => imageUrl;
  Post({
    required this.iD,
    required this.user,
    required this.caption,
    required this.timeAgo,
    this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
});
}

class Comment{
  final double postID;
  final double react;
  String timeAgo;
  String username;
  String content;
  String imageUrl;

  Comment({
    required this.postID, 
    required this.username, 
    required this.content, 
    required this.react, 
    required this.imageUrl,
    required this.timeAgo
  });
}

class Posts extends StatefulWidget {
  const Posts({Key? key, required this.data}) : super(key: key);
  final Post data;
  State<Posts> createState() => _PostsState();
  
}
class _PostsState extends State<Posts>{
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () => setState(() {
            Navigator.of(context).pushNamed('/posts',
            arguments: widget.data);
          }),
          child: Ink(
            height: 100,
            color: themeManager.themeMode == dark? Color.fromARGB(255, 38, 38, 38) : Color.fromARGB(255, 255, 255, 255),
          ),
        ),
    );
  }
}




class Postpage extends StatefulWidget{
  const Postpage({Key? key, required this.data}) : super(key:key);
  final Post data;
  
  @override
  State<Postpage> createState() => _PostPageState() ;
}
class _PostPageState extends State<Postpage>{
  @override
  Widget build(BuildContext context){
    Widget pagename = Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage('https://www.tutorialkart.com/img/hummingbird.png'),
              ),
            ),
          ), 
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Page name',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Time ·',
                      style: Theme.of(context).textTheme.labelSmall
                    ),
                    const Icon(
                      Icons.public,
                      size: 10,
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            )
          ),
          IconButton(
            splashRadius: MediaQuery.of(context).size.width*0.07,
            icon: const Icon(Icons.more_horiz),
            iconSize: 20,
            color: Colors.grey,
            onPressed: () {
            },
          )
        ],
      ),
    );
    Widget textfeed = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Text(
        LoremIpsumGenerator.generate(paragraphs: 2),
        style: Theme.of(context).textTheme.labelLarge,
      )
      ,
    );
    Widget buttonSection = Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _builButton(Colors.grey, Icons.thumb_up_off_alt, 'Like'),
            _builButton(Colors.grey, FontAwesomeIcons.message, 'Comment'),
            _builButton(Colors.grey, FontAwesomeIcons.share, 'Share'),
          ],
      ),
    );
    Widget iconSection = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _blue.color,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.thumb_up,
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          'Number',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
    Widget commentSection(data) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: CommentTreeWidget<Comment, Comment>(
          data[0],
          [
            for(int i = 0; i <data.length; i+=1)
              data[i]
          ],  
          treeThemeData: const TreeThemeData(lineColor: Colors.grey, lineWidth: 3),
          avatarRoot: (context, data) => PreferredSize(
            preferredSize: const Size.fromRadius(18),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(data.imageUrl),
            ),
          ),
          avatarChild: (context, data) => PreferredSize(
             preferredSize: const Size.fromRadius(12),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey,
              backgroundImage:NetworkImage(data.imageUrl),
            ),
          ),
          contentChild: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.username,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        data.content,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                  child: const Padding(
                    padding:  EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text('Like'),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Reply'),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
          contentRoot: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.username,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        data.content,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text('Like'),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Reply'),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Feed name',
          style: Theme.of(context).textTheme.titleLarge),
          actions: [
            IconButton(splashRadius: MediaQuery.of(context).size.width*0.07,
                        onPressed: () {},
                        icon: const Icon(Icons.search))
          ],
        ),
        body: Ink(
          child: ListView(
            children: [
              pagename,
              textfeed,
              buttonSection,
              iconSection,
              commentSection(commentLi),
            ],
          ),
        ),
    );
  }
  Column _builButton(Color color, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          
          children: [
            TextButton.icon(
            onPressed: (){},
            icon: Icon(
              icon,
              size: 22,
              color: color,
            ),
            label: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            ),
          ], 
        )
      ],
    );
  }
}