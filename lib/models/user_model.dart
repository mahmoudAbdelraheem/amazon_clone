class UserModel {
  String name;
  String email;
  String password;
  String address;
  String type;
  String token;
  String id;

  UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.type,
    required this.id,
    required this.token,
    required this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        email = json['email'] ?? '',
        address = json['address'] ?? '',
        password = json['password'] ?? '',
        type = json['type'] ?? '',
        id = json['_id'] ?? '',
        token = json['token'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['type'] = type;
    data['password'] = password;
    data['_id'] = id;
    data[''] = token;
    return data;
  }
}
