class Message {
  String sentBy;
  String content;
  bool isSeen;
  DateTime sentAt;

  Message(this.sentBy, this.content, this.sentAt, this.isSeen);

  Message.fromJson(Map<String, dynamic> json) 
    : sentBy = json['sentBy'],
      content = json['content'],
      isSeen = json['isSeen'],
      sentAt = DateTime.parse(json['sentAt']);

  Map<String, dynamic> toJson() => {
      'sentBy': sentBy,
      'content': content,
      'isSeen': isSeen,
      'sentAt': sentAt.toString()
  };

}