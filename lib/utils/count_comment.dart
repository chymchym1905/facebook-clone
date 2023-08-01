import '../model/comment_class.dart';

void countReply(Comment1 data, List<Comment1> listdata) {
  int count = 0;
  var countLoop = data.reply.length;
  while (countLoop > 0) {
    listdata.add(data.reply[count]);
    if (data.reply[count].reply.isNotEmpty) {
      countReply(data.reply[count], listdata);
    }
    count++;
    countLoop--;
  }
}

int countComment(List<Comment1> listdata) {
  int count = 0;
  for (int i = 0; i < listdata.length; i++) {
    count++;
    for (int j = 0; j < listdata[i].reply.length; j++) {
      count++;
      for (int k = 0; k < listdata[i].reply[j].reply.length; k++) {
        count++;
      }
    }
  }
  return count;
}
