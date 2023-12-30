// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class profileimageModel {
  String UID;
  String Name;
  String ImageLink;
  
  double? Cost;
  profileimageModel({
    required this.UID,
    required this.Name,
    required this.ImageLink,
    this.Cost,
  });

  profileimageModel copyWith({
    String? UID,
    String? Name,
    String? ImageLink,
    double? Cost,
  }) {
    return profileimageModel(
      UID: UID ?? this.UID,
      Name: Name ?? this.Name,
      ImageLink: ImageLink ?? this.ImageLink,
      Cost: Cost ?? this.Cost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'UID': UID,
      'Name': Name,
      'ImageLink': ImageLink,
      'Cost': Cost,
    };
  }

  factory profileimageModel.fromMap(Map<String, dynamic> map) {
    return profileimageModel(
      UID: map['UID'] as String,
      Name: map['Name'] as String,
      ImageLink: map['ImageLink'] as String,
      Cost: map['Cost'] != null ? map['Cost'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory profileimageModel.fromJson(String source) => profileimageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'profileimageModel(UID: $UID, Name: $Name, ImageLink: $ImageLink, Cost: $Cost)';
  }

  @override
  bool operator ==(covariant profileimageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.UID == UID &&
      other.Name == Name &&
      other.ImageLink == ImageLink &&
      other.Cost == Cost;
  }

  @override
  int get hashCode {
    return UID.hashCode ^
      Name.hashCode ^
      ImageLink.hashCode ^
      Cost.hashCode;
  }
}
