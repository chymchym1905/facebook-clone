import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/post_class.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({super.key, required this.data});
  final Post data;
  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: (){
           FocusScope.of(context).requestFocus(FocusNode());
            showModalBottomSheet <void>(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10)
                )
              ),
              context: context,
              builder: (BuildContext context){
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                     Row(
                       children: [
                         Padding(
                          padding: const EdgeInsets.all(5),
                           child: SizedBox(
                             width: 50,
                             height: 50,
                             child: CircleAvatar(
                               radius: 120,
                               backgroundImage: NetworkImage(widget.data.user.imageurl),
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
                                  widget.data.user.name,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              // Row(
                              //   children: [

                              //   ],
                              // ),
                            ],
                          ),
                         ),
                       ],
                     )
                    ],
                  ),
                );
              }
            );
          },
          icon: const Icon(
            FontAwesomeIcons.share,
            size: 22,
            color: Colors.grey,
          ),
          label: Text(
            "Share",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}