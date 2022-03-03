import 'package:flutter/foundation.dart';

@immutable
class VlanModel {
  final String? id,
      station,
      ipInterface,
      description,
      name,
      creationDate,
      vlanMemo,
      vlanMemoAuthor,
      vlanType;

  const VlanModel(
      {this.id,
      this.name,
      this.vlanType,
      this.description,
      this.ipInterface,
      this.station,
      this.vlanMemo,
      this.creationDate,
      this.vlanMemoAuthor});

  factory VlanModel.fromMap(Map data) {
    return VlanModel(
      id: data['id'],
      name: data['name'] ?? '',
      vlanType: data['vlanType'] ?? '',
      description: data['description'] ?? '',
      ipInterface: data['ipInterface'] ?? '',
      station: data['station'] ?? '',
      vlanMemo: data['vlanMemo'] ?? '',
      creationDate: data['creationDate'] ?? '',
      vlanMemoAuthor: data['vlanMemoAuthor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vlanType": vlanType,
        "description": description,
        "ipInterface": ipInterface,
        "station": station,
        "vlanMemo": vlanMemo,
        "creationDate": creationDate,
        "vlanMemoAuthor": vlanMemoAuthor,
      };

  static VlanModel fromJson(Map<String, dynamic> json) => VlanModel(
        id: json['id'],
        name: json['name'],
        vlanType: json['vlanType'],
        description: json['description'],
        ipInterface: json['ipInterface'],
        station: json['station'],
        vlanMemo: json['vlanMemo'],
        creationDate: json['creationDate'],
        vlanMemoAuthor: json['vlanMemoAuthor'],
      );

  VlanModel copy({
    String? id,
    String? name,
    String? vlanType,
    String? description,
    String? ipInterface,
    String? station,
    String? vlanMemo,
    String? creationDate,
    String? vlanMemoAuthor,
  }) =>
      VlanModel(
        id: id ?? this.id,
        name: name ?? this.name,
        vlanType: vlanType ?? this.vlanType,
        description: description ?? this.description,
        ipInterface: ipInterface ?? this.ipInterface,
        station: station ?? this.station,
        vlanMemo: vlanMemo ?? this.vlanMemo,
        creationDate: creationDate ?? this.creationDate,
        vlanMemoAuthor: vlanMemoAuthor ?? this.vlanMemoAuthor,
      );
}
