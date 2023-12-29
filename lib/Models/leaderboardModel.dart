// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: file_names
class Leaderboardmodel {
  int? currentPosition;
  String profileImage;
  int points;
  String username;
  Leaderboardmodel({
    this.currentPosition,
    required this.profileImage,
    required this.points,
    required this.username,
  });

  Leaderboardmodel copyWith({
    int? currentPosition,
    String? profileImage,
    int? points,
    String? username,
  }) {
    return Leaderboardmodel(
      currentPosition: currentPosition ?? this.currentPosition,
      profileImage: profileImage ?? this.profileImage,
      points: points ?? this.points,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPosition': currentPosition,
      'profileImage': profileImage,
      'points': points,
      'username': username,
    };
  }

  factory Leaderboardmodel.fromMap(Map<String, dynamic> map) {
    return Leaderboardmodel(
      currentPosition: map['currentPosition'] as int,
      profileImage: map['profileImage'] as String,
      points: map['points'] as int,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Leaderboardmodel.fromJson(String source) => Leaderboardmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Leaderboardmodel(currentPosition: $currentPosition, profileImage: $profileImage, points: $points, username: $username)';
  }

  @override
  bool operator ==(covariant Leaderboardmodel other) {
    if (identical(this, other)) return true;
  
    return 
      other.currentPosition == currentPosition &&
      other.profileImage == profileImage &&
      other.points == points &&
      other.username == username;
  }

  @override
  int get hashCode {
    return currentPosition.hashCode ^
      profileImage.hashCode ^
      points.hashCode ^
      username.hashCode;
  }
}
