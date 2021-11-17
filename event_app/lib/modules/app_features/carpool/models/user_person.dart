import 'dart:ffi';

class UserPerson {

  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String isdriver;

  UserPerson(
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.isdriver);

  UserPerson.fromJson(Map<dynamic, dynamic> json) :
        firstName = json['prenom'].toString(),
        lastName = json['nom'].toString(),
        email = json['mail'].toString(),
        phoneNumber = json['phone'].toString(),
        isdriver = json['isdriver'].toString();
}