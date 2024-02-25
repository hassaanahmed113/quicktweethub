class PostModel {
  String name;
  String username;
  String time;
  String post;
  String id;

  PostModel({
    required this.name,
    required this.username,
    required this.time,
    required this.post,
    required this.id,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        name: json["name"],
        username: json["username"],
        time: json["time"],
        post: json["post"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "time": time,
        "post": post,
        "id": id,
      };
}
