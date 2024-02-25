class UserModel {
  String? email;
  String? username;
  String? name;
  List<String>? friend;
  String? id;

  UserModel({
    this.email,
    this.username,
    this.name,
    this.friend,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        username: json["username"],
        name: json["name"],
        friend: json["friend"] == null
            ? []
            : List<String>.from(json["friend"]!.map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "name": name,
        "friend":
            friend == null ? [] : List<dynamic>.from(friend!.map((x) => x)),
        "id": id,
      };
}
