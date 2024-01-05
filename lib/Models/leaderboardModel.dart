
class Leaderboardmodel {
  int? currentPosition;
  String profileImage;
  int points;
  String username;
  bool isSubscribed;

//<editor-fold desc="Data Methods">
  Leaderboardmodel({
    this.currentPosition,
    required this.profileImage,
    required this.points,
    required this.username,
    required this.isSubscribed,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Leaderboardmodel &&
          runtimeType == other.runtimeType &&
          currentPosition == other.currentPosition &&
          profileImage == other.profileImage &&
          points == other.points &&
          username == other.username &&
          isSubscribed == other.isSubscribed);

  @override
  int get hashCode =>
      currentPosition.hashCode ^
      profileImage.hashCode ^
      points.hashCode ^
      username.hashCode ^
      isSubscribed.hashCode;

  @override
  String toString() {
    return 'Leaderboardmodel{' +
        ' currentPosition: $currentPosition,' +
        ' profileImage: $profileImage,' +
        ' points: $points,' +
        ' username: $username,' +
        ' isSubscribed: $isSubscribed,' +
        '}';
  }

  Leaderboardmodel copyWith({
    int? currentPosition,
    String? profileImage,
    int? points,
    String? username,
    bool? isSubscribed,
  }) {
    return Leaderboardmodel(
      currentPosition: currentPosition ?? this.currentPosition,
      profileImage: profileImage ?? this.profileImage,
      points: points ?? this.points,
      username: username ?? this.username,
      isSubscribed: isSubscribed ?? this.isSubscribed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentPosition': this.currentPosition,
      'profileImage': this.profileImage,
      'points': this.points,
      'username': this.username,
      'isSubscribed': this.isSubscribed,
    };
  }

  factory Leaderboardmodel.fromMap(Map<String, dynamic> map) {
    return Leaderboardmodel(
      currentPosition: map['currentPosition'] as int,
      profileImage: map['profileImage'] as String,
      points: map['points'] as int,
      username: map['username'] as String,
      isSubscribed: map['isSubscribed'] as bool,
    );
  }

//</editor-fold>
}