import 'package:flutter/foundation.dart';

@immutable
class StationModel {
  final String? id, locUnit, name;

  const StationModel({
    this.id,
    this.name,
    this.locUnit,
  });

  factory StationModel.fromMap(Map data) {
    return StationModel(
      id: data['id'],
      name: data['name'] ?? '',
      locUnit: data['locUnit'] ?? '',
    );
  }

  static StationModel fromJson(Map<String, dynamic> json) => StationModel(
        id: json['id'],
        name: json['name'],
        locUnit: json['locUnit'],
      );

  Map<String, dynamic?> toJson() {
    return {
      'id': id,
      'name': name,
      'locUnit': locUnit,
    };
  }

  StationModel copy({
    String? id,
    String? name,
    String? locUnit,
  }) =>
      StationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        locUnit: locUnit ?? this.locUnit,
      );
}
