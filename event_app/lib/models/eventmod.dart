// ignore_for_file: unnecessary_getters_setters, file_names

class EventMod {
  String _eventid;
  String name;
  DateTime startTime;
  DateTime endTime;
  String location;
  int streetNumber;
  String streetName;
  String city;
  int numberOfTickets;

  EventMod(
      this._eventid,
      this.name,
      this.startTime,
      this.endTime,
      this.location,
      this.streetNumber,
      this.streetName,
      this.city,
      this.numberOfTickets);

  String get eventid => _eventid;

  set eventid(String gameroomid) {
    _eventid = gameroomid;
  }

  // OTHER CONSTRUCTORS
  EventMod.fromJson(Map<String, dynamic> json)
      : _eventid = json['eventid'],
        name = json['name'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        location = json['location'],
        streetNumber = json['streetNumber'],
        streetName = json['streetName'],
        city = json['city'],
        numberOfTickets = json['numberOfTickets'];

  EventMod.fromMapToObject(Map<String, dynamic> map)
      : _eventid = map['eventid'],
        name = map['name'],
        startTime = map['startTime'],
        endTime = map['endTime'],
        location = map['location'],
        streetNumber = map['streetNumber'],
        streetName = map['streetName'],
        city = map['city'],
        numberOfTickets = map['numberOfTickets'];

  //MAPPING
  Map<String, dynamic> fromObjectToMap() {
    var map = <String, dynamic>{};
    map['eventid'] = _eventid;
    map['name'] = name;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['location'] = location;
    map['streetNumber'] = streetNumber;
    map['streetName'] = streetName;
    map['city'] = city;
    map['numberOfTickets'] = numberOfTickets;
    return map;
  }
}
