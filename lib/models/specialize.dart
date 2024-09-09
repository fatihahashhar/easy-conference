import 'dart:convert';

class SpecializationArea {
  final int? id;
  final String area;
  final String role;

  SpecializationArea({
    this.id,
    required this.area,
    required this.role,
  });
  // Convert a Specialize Area into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area,
    };
  }

  factory SpecializationArea.fromMap(Map<String, dynamic> map) {
    return SpecializationArea(
      id: map['id']?.toInt() ?? 0,
      area: map['area'] ?? '',
      role: map['role'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory SpecializationArea.fromJson(String source) =>
      SpecializationArea.fromMap(json.decode(source));
  // Implement toString to make it easier to see information about
  // each specialization area when using the print statement.
  @override
  String toString() => 'SpecializationArea(id: $id, area: $area)';
}
