import 'dart:convert';

class Post {
  late int id;
  late String title;
  late String content;
  late String image;
  late String thumbnail;
  late int userId;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.thumbnail,
    required this.userId,
  });

  Post.empty();
  Post copyWith({
    int? id,
    String? url,
    String? title,
    String? content,
    String? image,
    String? thumbnail,
    int? userId,
  }) =>
      Post(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
        userId: userId ?? this.userId,
      );

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: int.parse(json["id"].toString()),
        title: json["title"],
        content: json["content"] ?? "",
        image: json["image"] ?? "",
        thumbnail: json["thumbnail"],
        userId: int.parse(json["userId"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
        "thumbnail": thumbnail,
        "userId": userId,
      };

  Map<String, dynamic> toJsonForDb() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "userId": userId,
      };

  static List<Post> fromList(List<dynamic> list) {
    return list.map((item) => Post.fromJson(item)).toList();
  }

  static List<Map<String, dynamic>> toList(List<Post> postList) {
    return postList.map((post) => post.toJson()).toList();
  }
}
