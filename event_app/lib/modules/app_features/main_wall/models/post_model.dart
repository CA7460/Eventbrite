import 'package:event_app/modules/app_features/main_wall/models/comment_model.dart';

class PostModel {
  String _postid;
  String _eventid;
  String _userid;
  String message;
  DateTime publishTime;

  PostModel(this._postid, this._eventid, this._userid, this.message,
      this.publishTime);

  String get eventid => _eventid;
  set eventid(String eventid) {
    _eventid = eventid;
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
  PostModel.fromJson(Map<String, dynamic> json)
      : _postid = json['postid'],
        _eventid = json['eventid'],
        _userid = json['userid'],
        publishTime = DateTime.parse(json['publishTime']),
        message = json['message'];

  PostModel.fromMapToObject(Map<String, dynamic> map)
      : _postid = map['postid'],
        _eventid = map['eventid'],
        _userid = map['userid'],
        publishTime = map['publishTime'],
        message = map['message'];

  //MAPPING
  Map<String, dynamic> fromObjectToMap() {
    var map = <String, dynamic>{};
    map['postid'] = _postid;
    map['eventid'] = _eventid;
    map['userid'] = _userid;
    map['message'] = message;
    map['publishTime'] = publishTime;
    return map;
  }
}
