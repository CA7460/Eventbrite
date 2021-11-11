import 'package:event_app/models/user.dart';

class Message {
  String? messageId;
  User sentBy;
  String content;
  bool isSeen;
  DateTime sentAt;

  Message(this.messageId, this.sentBy, this.content, this.sentAt, this.isSeen);

  Message.noId(this.sentBy, this.content, this.sentAt, this.isSeen);

  Message.fromJson(Map<String, dynamic> json) 
    : messageId = json['messageId'],
      sentBy = User.fromJson(json['sentBy']),
      content = json['content'],
      isSeen = json['isSeen'] == 1? true: false,
      sentAt = DateTime.parse(json['sentAt']);

  Map<String, dynamic> toJson() => {
      'messageId': messageId,
      'sentby': sentBy.userid,
      'content': content,
      'isSeen': isSeen == true? 1: 0,
      'sentAt': sentAt.toString()
  };

}