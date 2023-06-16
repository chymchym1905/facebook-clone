
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_brand_palettes/palettes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/main.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';


const _blue = Facebook.blue();
class Post{
  final iD;
  User user;
  String caption;
  String timeAgo;
  List<String>? imageUrl;
  final likes;
  final comments;
  final shares;
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
  final postID;
  String username;
  String  content;

  Comment({required this.postID, required this.username, required this.content});
}

class Posts extends StatefulWidget {
  const Posts({Key? key, required this.data}) : super(key: key);
  final Post data;
  State<Posts> createState() => _PostsState();
  
}
class _PostsState extends State<Posts>{
  var containerColor = Color.fromARGB(255, 255, 255, 255);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () => setState(() {
            Navigator.of(context).pushNamed('/posts',
            arguments: widget.data);
          }),
          child: Ink(
            height: 100,
            color: containerColor,
          ),
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
      child: Row(
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
    return MaterialApp(
      theme: themeManager.themeMode,
      home: Scaffold(
          appBar: AppBar(
            title: const  Text('Feed name'),
            actions: const <Widget>[
              Icon(
              Icons.search,
              size: 25,
              ),
            ],
          ),
          body: Ink(
            child: ListView(
              children: [
                pagename,
                textfeed,
                buttonSection,
                iconSection,
              ],
            ),
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