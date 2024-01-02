// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class moneyModel {
  String UID;
  num Cost;
  num point;
  String Name;
  moneyModel({
    required this.UID,
    required this.Cost,
    required this.point,
    required this.Name,
  });

  moneyModel copyWith({
    String? UID,
    num? Cost,
    num? point,
    String? Name,
  }) {
    return moneyModel(
      UID: UID ?? this.UID,
      Cost: Cost ?? this.Cost,
      point: point ?? this.point,
      Name: Name ?? this.Name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'UID': UID,
      'Cost': Cost,
      'point': point,
      'Name': Name,
    };
  }

  factory moneyModel.fromMap(Map<String, dynamic> map) {
    return moneyModel(
      UID: map['UID'] as String,
      Cost: map['Cost'] as num,
      point: map['point'] as num,
      Name: map['Name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory moneyModel.fromJson(String source) => moneyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'moneyModel(UID: $UID, Cost: $Cost, point: $point, Name: $Name)';
  }

  @override
  bool operator ==(covariant moneyModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.UID == UID &&
      other.Cost == Cost &&
      other.point == point &&
      other.Name == Name;
  }

  @override
  int get hashCode {
    return UID.hashCode ^
      Cost.hashCode ^
      point.hashCode ^
      Name.hashCode;
  }
}
