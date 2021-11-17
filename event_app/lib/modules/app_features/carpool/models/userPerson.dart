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

  UserPerson.fromJson(Map<String, dynamic> json) :
        firstName = json['prenom'],
        lastName = json['nom'],
        email = json['mail'],
        phoneNumber = json['phone'],
        isdriver = json['isdriver'];
}