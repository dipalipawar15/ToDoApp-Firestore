import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final String taskStatus;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangeStatus;
  final VoidCallback onSavedTodo;


  const TodoFormWidget({
    Key key,
    this.title = '',
    this.description = '',
    this.taskStatus='',
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onChangeStatus,
    @required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            SizedBox(height: 16),
            buildTaskStatus(),
            SizedBox(height: 8),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: description,
        onChanged: onChangedDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );

  Widget buildTaskStatus() => TextFormField(
    maxLines: 1,
    initialValue: taskStatus,
    enabled: false,
    readOnly: true,
    onChanged: onChangeStatus,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Task Status',
    ),
  );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedTodo,
          child: Text('Save'),
        ),
      );
}
