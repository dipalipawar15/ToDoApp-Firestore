import 'package:flutter/cupertino.dart';
import 'package:todo_app_firestore/api/firebase_api.dart';
import 'package:todo_app_firestore/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.taskStatus== "Today").toList();


  List<Todo> get todoTomorrow =>
      _todos.where((todo) => todo.taskStatus == "Tomorrow").toList();

  List<Todo> get todoUpcoming =>
      _todos.where((todo) => todo.taskStatus == "Upcoming").toList();

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description,String taskStatus) {
    todo.title = title;
    todo.description = description;
    todo.taskStatus=taskStatus;

    FirebaseApi.updateTodo(todo);
  }
}
