class User {
  String userid;
  String prenom;
  String nom;
  String mail;

  User(this.userid, this.prenom, this.nom, this.mail);
  
  User.fromJson(Map<String, dynamic> json)
    : userid = json['userid'],
      prenom = json['prenom'],
      nom = json['nom'],
      mail = json['mail'];

  Map<String, dynamic> toJson(){
  return {
    "userid": userid,
    "prenom": prenom,
    "nom": nom,
    "mail": mail
  };
}
}
