import 'dart:convert';

class User {
  String identify;
  String name;
  String email;

  User({this.identify, this.name = '', this.email = ''});

  factory User.fromJson(jsonData) {
    return User(
        identify: jsonData['identify'],
        name: jsonData['name'],
        email: jsonData['email'],);
  }

  toJson() {
    return jsonEncode({
      'identify': identify,
      'name': name,
      'email': email,
    });
  }
}
