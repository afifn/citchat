class User{
  String? name;
  String? email;
  String? uid;
  String? photo;

  User({this.name, this.email, this.uid, this.photo});

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    uid: json["uid"] ?? "",
    photo: json["photo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "uid": uid,
    "photo": photo,
  };
}