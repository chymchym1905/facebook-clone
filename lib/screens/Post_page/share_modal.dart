// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class shareModal extends StatefulWidget {
  const shareModal({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Post data;

  @override
  State<shareModal> createState() => _shareModalState();
}

class _shareModalState extends State<shareModal> {
  @override
  Widget build(BuildContext context) {
    final bool isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SizedBox(
      height: isKeyboard
          ? MediaQuery.of(context).size.height * 0.7
          : MediaQuery.of(context).size.height * 0.6,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: imageAvatar(widget.data.user.imageurl),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          widget.data.user.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey,
                                side: const BorderSide(color: Colors.grey),
                                padding: const EdgeInsets.only(left: 5)),
                            onPressed: () {},
                            child: const Row(children: [
                              Text(
                                'Feed',
                              ),
                              Icon(Icons.arrow_drop_down),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey,
                                  side: const BorderSide(color: Colors.grey),
                                  padding: const EdgeInsets.only(left: 5)),
                              onPressed: () {},
                              child: const Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 3),
                                  child: Icon(Icons.public),
                                ),
                                Text(
                                  'Public',
                                ),
                                Icon(Icons.arrow_drop_down),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    icon: const Icon(FontAwesome5.expand_alt),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Say something about this...',
                  hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.only(bottom: 100),
                  suffixIcon: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      foregroundColor: Colors.white,
                      backgroundColor: blue,
                    ),
                    child: const Text(
                      "Share now",
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Iconic.book_open),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Share to your story'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(FontAwesome5.facebook_messenger),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Send in Messenger'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Elusive.group),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('Share to a group'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Iconic.share),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text('More options...'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
