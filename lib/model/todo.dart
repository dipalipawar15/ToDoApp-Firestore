import 'package:flutter/cupertino.dart';
import 'package:todo_app_firestore/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;
  String taskStatus;

  Todo({
    @required this.createdTime,
    @required this.title,
    this.description = '',
    this.id,
    this.isDone = false,
  @required this.taskStatus,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
        taskStatus: json['taskStatus'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
        'taskStatus':taskStatus,
      };
}
