// import 'dart:ffi';

// class CarPool {
//   String _carpoolid;
//   String _creatorId;
//   String _eventId;
//   DateTime createdOn;
//   String startLocation;
//   String endLocation;
//   String title;
//   String description;
//   double? price;
//   int numberOfSeats;
//   String _guests;
//   String status; //enum
//   String _requests;

//   CarPool(this._carpoolid, this._creatorId, this._eventId, this.createdOn,
//       this.startLocation, this.endLocation, this.title, this.description,
//       this.price, this.numberOfSeats, this._guests, this.status, this._requests);

//   CarPool.fromJson(Map<String, dynamic> json) :
//         _carpoolid = json['carpoolid'],
//         _creatorId = json['creatorId'],
//         _eventId = json['eventId'],
//         createdOn = DateTime.parse(json['createdOn']),
//         startLocation = json['startLocation'],
//         endLocation = json['endLocation'],
//         title = json['title'],
//         description = json['description'],
//         price = double.tryParse(json['price']),
//         numberOfSeats = int.parse(json['numberOfSeats']),
//         _guests = json['guests'],
//         status = json['status'],
//         _requests = json['requests'];
// }

class CarPool {
  String _carpoolid;
  DateTime createdOn;
  String title;
  String description;
  double? price;
  int numberOfSeats;
  String status; //enum
  String driverid;
  String passengerid;
  String _eventId;
  String pickupaddressid;

  CarPool(
      this._carpoolid,
      this.createdOn,
      this.title,
      this.description,
      this.price,
      this.numberOfSeats,
      this.status,
      this.driverid,
      this.passengerid,
      this._eventId,
      this.pickupaddressid);

  CarPool.fromJson(Map<String, dynamic> json)
      : _carpoolid = json['carpoolid'],
        createdOn = DateTime.parse(json['createdOn']),
        title = json['title'],
        description = json['description'],
        price = double.tryParse(json['price']),
        numberOfSeats = int.parse(json['numberOfSeats']),
        status = json['status'],
        driverid = json['driverid'],
        passengerid = json['passengerid'],
        _eventId = json['eventId'],
        pickupaddressid = json['pickupaddressid'];
}
