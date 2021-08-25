import 'dart:convert';

import 'package:flutter/foundation.dart';

class TaskModel {
  final String? title;
  final DateTime? date;
  final bool? check;
  final List<String>? categories;

  TaskModel({
    this.title,
    this.date,
    this.check,
    this.categories,
  });

  TaskModel copyWith({
    String? title,
    DateTime? date,
    bool? check,
    List<String>? categories,
  }) {
    return TaskModel(
      title: title ?? this.title,
      date: date ?? this.date,
      check: check ?? this.check,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date!.millisecondsSinceEpoch,
      'check': check,
      'categories': categories,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      check: map['check'],
      categories: List<String>.from(map['categories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(title: $title, date: $date, check: $check, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.title == title &&
        other.date == date &&
        other.check == check &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        date.hashCode ^
        check.hashCode ^
        categories.hashCode;
  }
}
