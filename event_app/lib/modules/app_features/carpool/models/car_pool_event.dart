class CarPoolEvent {
  String carpoolid;
  DateTime createdOn;
  String title;
  String description;
  double? price;
  int numberOfSeats;
  int status; //enum
  String driverid;
  String passengerid;
  String eventId;
  String pickupaddressid;

  CarPoolEvent(
      this.carpoolid,
      this.createdOn,
      this.title,
      this.description,
      this.price,
      this.numberOfSeats,
      this.status,
      this.driverid,
      this.passengerid,
      this.eventId,
      this.pickupaddressid);

  CarPoolEvent.fromJson(Map<dynamic, dynamic> json) :
        carpoolid = json['carpoolid'],
        createdOn = DateTime.parse(json['createdOn']),
        title = json['title'],
        description = json['description'],
        price = double.tryParse(json['price']),
        numberOfSeats = int.parse(json['numberOfSeats']),
        status = int.parse(json['status']),
        driverid = json['driverid'],
        passengerid = json['passengerid'],
        eventId = json['eventId'],
        pickupaddressid = json['pickupaddressid'];
}