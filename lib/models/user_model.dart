// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final String id;
  final List<dynamic> cart;

  UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.type,
    required this.id,
    required this.token,
    required this.password,
    required this.cart,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        email = json['email'] ?? '',
        address = json['address'] ?? '',
        password = json['password'] ?? '',
        type = json['type'] ?? '',
        id = json['_id'] ?? '',
        token = json['token'] ?? '',
        cart = List<Map<String, dynamic>>.from(
          json['cart']?.map(
            (x) => Map<String, dynamic>.from(x),
          ),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['type'] = type;
    data['password'] = password;
    data['_id'] = id;
    data[''] = token;
    data['cart'] = cart;
    return data;
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    String? id,
    List<dynamic>? cart,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      id: id ?? this.id,
      cart: cart ?? this.cart,
    );
  }
}
