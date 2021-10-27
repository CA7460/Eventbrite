class GameRoom {
  String _gameroomid;
  DateTime createdAt;
  String _userid;
  String hostName;
  int capacity;
  int playerCount;
  int progress;
  String roomStatus;

  GameRoom(this._gameroomid, this.createdAt, this._userid, this.hostName,
      this.capacity, this.playerCount, this.progress, this.roomStatus);

  String get gameroomid => _gameroomid;
  String get userid => _userid;

  set gameroomid(String gameroomid) {
    _gameroomid = gameroomid;
  }

  set userid(String userid) {
    _userid = userid;
  }

  // OTHER CONSTRUCTORS
  GameRoom.fromJson(Map<String, dynamic> json)
      : _gameroomid = json['gameroomid'],
        createdAt = DateTime.parse(json['createdAt']),
        _userid = json['userid'],
        hostName = json['hostname'],
        capacity = int.parse(json['capacity']),
        playerCount = int.parse(json['playerCount']),
        progress = int.parse(json['progress']),
        roomStatus = json['roomStatus'];

  GameRoom.fromMapToObject(Map<String, dynamic> map)
      : _gameroomid = map['gameroomid'],
        createdAt = map['createdAt'],
        _userid = map['userid'],
        hostName = map['hostname'],
        capacity = map['capacity'],
        playerCount = map['playerCount'],
        progress = map['progress'],
        roomStatus = map['roomStatus'];

  //MAPPING
  Map<String, dynamic> fromObjectToMap() {
    var map = <String, dynamic>{};
    if (_gameroomid != null) {
      map['gameroomid'] = _gameroomid;
    }
    map['createdAt'] = createdAt;
    map['userid'] = _userid;
    map['hostname'] = hostName;
    map['capacity'] = capacity;
    map['playerCount'] = playerCount;
    map['progress'] = progress;
    map['roomStatus'] = roomStatus;
    return map;
  }
}
