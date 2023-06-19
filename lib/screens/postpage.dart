import 'package:flutter_application_1/model/fb_reaction.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:flutter_application_1/data/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '/model/posts.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/theme/themes.dart';
import 'package:flutter_brand_palettes/palettes.dart';
import 'comment.dart';


const _blue = Facebook.blue();
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
        border: Border(

          bottom: BorderSide(color: Colors.grey, width:0.2 ))
      ),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // _builButton(Colors.grey, Icons.thumb_up_off_alt, 'Like'),
            const FbReaction(),
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
    Widget comment = CommentSection(data: commentLi);
    return MaterialApp(
      theme: themeManager.themeMode,
      home: Scaffold(
          backgroundColor:themeManager.themeMode == dark ? const Color.fromARGB(255, 38, 38, 38):Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              splashRadius: MediaQuery.of(context).size.width*0.07,
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false)
            ),
            title: Text('Feed name',
            style: Theme.of(context).textTheme.titleLarge),
            actions: [
               IconButton(onPressed: () {},icon: const Icon(Icons.search), splashRadius: MediaQuery.of(context).size.width*0.07),
            ],
          ),
          body: ListView(
              children: [
                pagename,
                textfeed,
                buttonSection,
                iconSection,
                comment,
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