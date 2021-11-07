class Message {
  String sentBy;
  String content;
  bool isSeen;
  DateTime sentAt;

  Message(this.sentBy, this.content, this.sentAt, this.isSeen);

  Message.fromJson(Map<String, dynamic> json) 
    : sentBy = json['sentby'],
      content = json['content'],
      isSeen = json['isseen'],
      sentAt = DateTime.parse(json['sentat']);

  Map<String, dynamic> toJson() => {
      'sentby': sentBy,
      'content': content,
      'isseen': isSeen,
      'sentat': sentAt.toString()
  };

}