import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_firestore/model/todo.dart';
import 'package:todo_app_firestore/utils.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos(int selectedIndex) => FirebaseFirestore.instance
      .collection('todo')
      .where('taskStatus',isEqualTo: selectedIndex ==0 ? 'Today':selectedIndex == 1? 'Tomorrow':'Upcoming')
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));

  static Stream<List<Todo>> readDataTodos(int selectedIndex,String x) => FirebaseFirestore.instance
      .collection('todo')
      .where('title',isGreaterThanOrEqualTo: x)
      .where('taskStatus',isEqualTo: selectedIndex ==0 ? 'Today':selectedIndex == 1? 'Tomorrow':'Upcoming')
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}
