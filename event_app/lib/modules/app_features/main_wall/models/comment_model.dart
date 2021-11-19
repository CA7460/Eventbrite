class CommentModel {
  String _commentid;
  String _postid;
  String _userid;
  String message;
  DateTime publishTime;

  CommentModel(this._commentid, this._postid, this._userid, this.message,
      this.publishTime);

  String get eventid => _commentid;
  set commentid(String commentid) {
    _commentid = commentid;
  }

  String get postid => _postid;
  set postid(String postid) {
    _postid = postid;
  }

  String get userid => _userid;
  set userid(String userid) {
    _userid = userid;
  }

  // OTHER CONSTRUCTORS
  CommentModel.fromJson(Map<String, dynamic> json)
      : _commentid = json['commentid'],
        _postid = json['postid'],
        _userid = json['userid'],
        publishTime = DateTime.parse(json['publishTime']),
        message = json['message'];

  CommentModel.fromMapToObject(Map<String, dynamic> map)
      : _commentid = map['commentid'],
        _postid = map['postid'],
        _userid = map['userid'],
        publishTime = map['publishTime'],
        message = map['message'];

  //MAPPING
  Map<String, dynamic> fromObjectToMap() {
    var map = <String, dynamic>{};
    map['commentid'] = _commentid;
    map['postid'] = _postid;
    map['userid'] = _userid;
    map['message'] = message;
    map['publishTime'] = publishTime;
    return map;
  }
}
