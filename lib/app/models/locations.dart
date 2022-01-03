import 'package:flutter/foundation.dart';

@immutable
class LocationModel {
  final String id;
  final String name;
  final String on;

  const LocationModel({
    required this.id,
    required this.name,
    required this.on,
  });

  factory LocationModel.fromMap(Map data) {
    return LocationModel(
      id: data['id'],
      name: data['name'] ?? '',
      on: data['on'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "on": on,
      };

  static LocationModel fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['id'],
        name: json['name'],
        on: json['on'],
      );

  LocationModel copy({
    String? id,
    String? name,
    String? on,
  }) =>
      LocationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        on: on ?? this.on,
      );
}