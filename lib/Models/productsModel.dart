// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';



class productsModel {
  String Name;
  String ImageURL;
  num Cost;
  String UID;
  bool? haspurchased;
  BuildContext? context;
  productsModel({
    required this.Name,
    required this.ImageURL,
    required this.Cost,
    required this.UID,
    this.haspurchased,
    this.context,
  });

  productsModel copyWith({
    String? Name,
    String? ImageURL,
    num? Cost,
    String? UID,
    bool? haspurchased,
    BuildContext? context,
  }) {
    return productsModel(
      Name: Name ?? this.Name,
      ImageURL: ImageURL ?? this.ImageURL,
      Cost: Cost ?? this.Cost,
      UID: UID ?? this.UID,
      haspurchased: haspurchased ?? this.haspurchased,
      context: context ?? this.context,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Name': Name,
      'ImageURL': ImageURL,
      'Cost': Cost,
      'UID': UID,
      'haspurchased': haspurchased,
      'context': context,
    };
  }

  factory productsModel.fromMap(Map<String, dynamic> map) {
    return productsModel(
      Name: map['Name'] as String,
      ImageURL: map['ImageURL'] as String,
      Cost: map['Cost'] as num,
      UID: map['UID'] as String,
      haspurchased: map['haspurchased'] as bool,
      context: map['context'] as BuildContext,
    );
  }

  String toJson() => json.encode(toMap());

  factory productsModel.fromJson(String source) => productsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'productsModel(Name: $Name, ImageURL: $ImageURL, Cost: $Cost, UID: $UID, haspurchased: $haspurchased, context: $context)';
  }

  @override
  bool operator ==(covariant productsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.Name == Name &&
      other.ImageURL == ImageURL &&
      other.Cost == Cost &&
      other.UID == UID &&
      other.haspurchased == haspurchased &&
      other.context == context;
  }

  @override
  int get hashCode {
    return Name.hashCode ^
      ImageURL.hashCode ^
      Cost.hashCode ^
      UID.hashCode ^
      haspurchased.hashCode ^
      context.hashCode;
  }
}
