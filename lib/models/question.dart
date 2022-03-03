import 'package:quiz/models/tags.dart';

import 'answers.dart';
import 'correctanswers.dart';
class Question {
  int? id;
  String? question;
  String? description;
  Answers? answers;
  String? multipleCorrectAnswers;
  CorrectAnswers? correctAnswers;
  String? correctAnswer;
  String? explanation;
  String? tip;
  List<Tags>? tags;
  String? category;
  String? difficulty;

  Question(
      {this.id,
        this.question,
        this.description,
        this.answers,
        this.multipleCorrectAnswers,
        this.correctAnswers,
        this.correctAnswer,
        this.explanation,
        this.tip,
        this.tags,
        this.category,
        this.difficulty});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    description = json['description'];
    answers =
    json['answers'] != null ? new Answers.fromJson(json['answers']) : null;
    multipleCorrectAnswers = json['multiple_correct_answers'];
    correctAnswers = json['correct_answers'] != null
        ? new CorrectAnswers.fromJson(json['correct_answers'])
        : null;
    correctAnswer = json['correct_answer'];
    explanation = json['explanation'];
    tip = json['tip'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    category = json['category'];
    difficulty = json['difficulty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['description'] = this.description;
    if (this.answers != null) {
      data['answers'] = this.answers!.toJson();
    }
    data['multiple_correct_answers'] = this.multipleCorrectAnswers;
    if (this.correctAnswers != null) {
      data['correct_answers'] = this.correctAnswers!.toJson();
    }
    data['correct_answer'] = this.correctAnswer;
    data['explanation'] = this.explanation;
    data['tip'] = this.tip;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['difficulty'] = this.difficulty;
    return data;
  }
}