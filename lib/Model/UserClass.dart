class User {
  int? id;
  String name;
  String username;
  String image;
  bool isFollowedByMe;
  String? sincronizar;
  User({
    this.id, required this.name, required this.username, required this.image, required this.isFollowedByMe, this.sincronizar
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      name: json['name'],
      username: json['username'],
      image: json['image'],
      isFollowedByMe: json['isFollowedByMe'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "username": username,
      "image": image,
      "isFollowedByMe": isFollowedByMe ? "1" : "0",
      "sincronizar": sincronizar
    };
  }
}