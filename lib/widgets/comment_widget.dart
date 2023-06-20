import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/comment_class.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/theme/themes.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.data});
  final List<Comment1> data;
  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: CommentTreeWidget<Comment1, Comment1>(
          widget.data[0],
          [
            for(int i = 0; i <widget.data.length; i+=1)
              widget.data[i],
          ],  
          avatarRoot: (context, data) => PreferredSize(
            preferredSize: const Size.fromRadius(18),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(data.imageurl),
            ),
          ),
          avatarChild: (context, data) => PreferredSize(
             preferredSize: const Size.fromRadius(12),
            child: CircleAvatar(
              radius: 12,
              backgroundImage:NetworkImage(data.imageurl),
            ),
          ),
          contentChild: (context, data) { //Replies
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: themeManager.themeMode == dark ? const Color.fromARGB(255,58,59,60):Color.fromARGB(155, 180, 177, 177),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.username,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        data.content,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: const Color.fromARGB(255, 109, 107, 107), fontWeight: FontWeight.w300),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        // Text(data.timeAgo),
                        // const SizedBox(
                        //   width: 15,
                        // ),
                        const Text('Like'),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('Reply'),
                      ],
                    ),
                  ),
                )
              ],
            );
          },

          contentRoot: (context, data) { // Parent comment
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: themeManager.themeMode == dark ? const Color.fromARGB(255,58,59,60):Color.fromARGB(155, 180, 177, 177),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.username,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w300)
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        data.content,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: const Color.fromARGB(255, 109, 107, 107), fontWeight: FontWeight.w300),
                  child: Padding(
                    padding:const EdgeInsets.only(top: 4),
                    child:  Row(
                      children: [
                       const SizedBox(
                          width: 8,
                        ),
                        // Text(data.timeAgo),
                        // const SizedBox(
                        //   width: 15,
                        // ),
                        const Text('Like'),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text('Reply'),
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
}