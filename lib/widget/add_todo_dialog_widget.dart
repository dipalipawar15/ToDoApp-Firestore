import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firestore/model/todo.dart';
import 'package:todo_app_firestore/provider/todos.dart';
import 'package:todo_app_firestore/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  final int selectedIndex;
  const AddTodoDialogWidget({Key key, @required this.selectedIndex}) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String taskStatus;

  @override
  void initState() {
    super.initState();

     taskStatus=widget.selectedIndex ==0 ? 'Today':widget.selectedIndex == 1? 'Tomorrow':'Upcoming';

  }


  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child:SingleChildScrollView(    // Expanded is added
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              TodoFormWidget(
                taskStatus: taskStatus,
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onChangeStatus:(taskStatus)=>setState(()=>this.taskStatus=taskStatus) ,
                onSavedTodo: addTodo,
              ),
            ],
            ),
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
        taskStatus: taskStatus,
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
