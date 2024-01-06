
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class questions {
   String Imageurl;
   String Category;
   String Level;
   String Question;
   String Answer;
   List<dynamic> Responses;
  questions({
    required this.Imageurl,
    required this.Category,
    required this.Level,
    required this.Question,
    required this.Answer,
    required this.Responses,
  });

  questions copyWith({
    String? Imageurl,
    String? Category,
    String? Level,
    String? Question,
    String? Answer,
    List<String>? Responses,
  }) {
    return questions(
      Imageurl: Imageurl ?? this.Imageurl,
      Category: Category ?? this.Category,
      Level: Level ?? this.Level,
      Question: Question ?? this.Question,
      Answer: Answer ?? this.Answer,
      Responses: Responses ?? this.Responses,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Imageurl': Imageurl,
      'Category': Category,
      'Level': Level,
      'Question': Question,
      'Answer': Answer,
      'Responses': Responses,
    };
  }
  questions.fromDocumentSnapshot(DocumentSnapshot<Map<dynamic, dynamic>> map):
     Imageurl  = map.data()!["ImageUrl"],
     Category = map.data()!['Category'],
     Level = map.data()!['Level'],
     Question = map.data()!['Question'],
     Answer = map.data()!['Answer'],
     Responses =  List<dynamic>.from((map.data()!['Responses'] as List<dynamic>));


  @override
  String toString() {
    return 'questions(Imageurl: $Imageurl, Category: $Category, Level: $Level, Question: $Question, Answer: $Answer, Responses: $Responses)';
  }

  @override
  bool operator ==(covariant questions other) {
    if (identical(this, other)) return true;
  
    return 
      other.Imageurl == Imageurl &&
      other.Category == Category &&
      other.Level == Level &&
      other.Question == Question &&
      other.Answer == Answer &&
      listEquals(other.Responses, Responses);
  }

  @override
  int get hashCode {
    return Imageurl.hashCode ^
      Category.hashCode ^
      Level.hashCode ^
      Question.hashCode ^
      Answer.hashCode ^
      Responses.hashCode;
  }
}
