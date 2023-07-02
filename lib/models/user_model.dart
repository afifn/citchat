class User {
  String name;
  String email;
  String uid;
  String photo;
  bool isOnline;

  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.photo,
    required this.isOnline,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        uid: json["uid"] ?? "",
        photo: json["photo"] ?? "",
        isOnline: json["isOnline"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "photo": photo,
        "isOnline": isOnline,
      };
}
