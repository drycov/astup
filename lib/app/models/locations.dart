
import 'package:flutter/foundation.dart';

@immutable
class LocationModel {
  const LocationModel({
    required this.id,
    required this.name,
  });

  LocationModel.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
  );

  final String id;
  final String name;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}