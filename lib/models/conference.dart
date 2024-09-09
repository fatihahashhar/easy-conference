import 'dart:convert';

class Conference {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final int areaId;

  Conference({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.areaId,
  });
  // Convert a shoe into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'areaId': areaId,
    };
  }

  factory Conference.fromMap(Map<String, dynamic> map) {
    return Conference(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      areaId: map['areaId'].toInt() ?? 0,
    );
  }
  String toJson() => json.encode(toMap());

  factory Conference.fromJson(String source) =>
      Conference.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Conference(id: $id, name: $name, email: $email,  phone: $phone, role: $role, areaId: $areaId)';
  }
}
