import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/themes.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/post_class.dart';

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
            color: themeManager.themeMode == dark? const Color.fromARGB(255, 38, 38, 38) : const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children:[
                NameBar(imageUrl: widget.data.user.imageurl, username: widget.data.user.name),
                Caption(caption: widget.data.caption),
                ],
              ),
            ),
          ),
        );
  }
}

class NameBar extends StatelessWidget {
  const NameBar({
    Key? key,
    required this.imageUrl, required this.username,
  }) : super(key: key);

  final String imageUrl;
  final String username;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(imageUrl)
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: Theme.of(context).textTheme.titleMedium
                  ),         
                  Wrap(
                    direction: Axis.horizontal,
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
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              child: IconButton(
                padding: EdgeInsets.zero,
                splashRadius: MediaQuery.of(context).size.width * 0.07,
                icon: const Icon(Icons.more_horiz),
                iconSize: 20,
                color: Colors.grey,
                onPressed: () {},
              ),
            )

          ],
          ),
    );
  }
}

class Caption extends StatelessWidget {
  const Caption({
    Key? key,
    required this.caption,
  }) : super(key: key);
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        child: Ink(
          color: themeManager.themeMode == dark? const Color.fromARGB(255, 38, 38, 38) : const Color.fromARGB(255, 255, 255, 255),
          child: Text(
            caption,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}