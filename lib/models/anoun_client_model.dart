import 'dart:convert';

class AnounClientModel {
  final String name;
  final String phone;
  AnounClientModel({
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  String toJson() => json.encode(toMap());
}
