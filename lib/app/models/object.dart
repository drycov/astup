//User Model

class ObjectModel {
  final String addressPos,
      description,
      id,
      ip,
      serialID,
      sysName,
      type,
      vlanMapID;




  ObjectModel(
      { required this.addressPos,
        required this.description,
        required this.id,
        required this.ip,
        required this.serialID,
        required this.sysName,
        required this.type,
        required this.vlanMapID});

  factory ObjectModel.fromMap(Map data) {
    return ObjectModel(
      addressPos: data['addressPos'],
      description: data['description'] ?? '',
      id: data['id'] ?? '',
      ip: data['ip'] ?? '',
      serialID: data['serialID'] ?? '',
      sysName: data['sysName'] ?? '',
      type: data['type'] ?? '',
      vlanMapID: data['vlanMapID'] ?? '',
    );
  }

  // final String addressPos,
  //     description,
  //     id,
  //     ip,
  //     serialID,
  //     sysName,
  //     type,
  //     vlanMapID;

  Map<String, dynamic> toJson() => {
    "addressPos": addressPos,
    "description": description,
    "id": id,
    "ip": ip,
    "serialID": serialID,
    "sysName": sysName,
    "type": type,
    "vlanMapID": vlanMapID
  };

  static ObjectModel fromJson(Map<String, dynamic> json) => ObjectModel(
    addressPos: json['addressPos'],
    description: json['description'],
    id: json['id'],
    ip: json['ip'],
    serialID: json['serialID'],
    sysName: json['sysName'],
    type: json['type'],
    vlanMapID: json['vlanMapID'],
  );

  ObjectModel copy({
    String? addressPos,
    String? description,
    String? id,
    String? ip,
    String? serialID,
    String? sysName,
    String? type,
    String? vlanMapID,
  }) =>
      ObjectModel(
        addressPos: addressPos ?? this.addressPos,
        description: description ?? this.description,
        id: id ?? this.id,
        ip: ip ?? this.ip,
        serialID: serialID ?? this.serialID,
        sysName: sysName ?? this.sysName,
        type: type ?? this.type,
        vlanMapID: vlanMapID ?? this.vlanMapID,
      );
}
