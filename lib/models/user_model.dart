class User{
  String? name;
  String? email;
  String? uid;

  User({this.name, this.email, this.uid});

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    uid: json["uid"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "uid": uid,
  };
}