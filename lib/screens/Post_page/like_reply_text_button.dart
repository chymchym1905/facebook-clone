// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../index.dart';

class LikeReply extends StatelessWidget {
  const LikeReply({
    Key? key,
    required this.func,
    required this.string,
  }) : super(key: key);
  final Function func;
  final String string;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => func,
      child: Text(string, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
