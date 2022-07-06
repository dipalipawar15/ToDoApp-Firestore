import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firestore/provider/todos.dart';
import 'package:todo_app_firestore/widget/todo_widget.dart';

class UpComingListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todoUpcoming;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No  tasks.',
              style: TextStyle(fontSize: 16),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(12),
            separatorBuilder: (context, index) => Container(height: 6),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
          );
  }
}
