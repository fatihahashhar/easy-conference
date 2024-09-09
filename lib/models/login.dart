import 'dart:convert';

class Login {
  final int? id;
  final String username;
  final String password;

  Login({
    this.id,
    required this.username,
    required this.password,
  });
  // Convert a shoe into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) => Login.fromMap(json.decode(source));
  // Implement toString to make it easier to see information about each shoe when using the print statement.
  @override
  String toString() {
    return 'Login(id: $id, username: $username, password: $password)';
  }
}
