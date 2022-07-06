import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firestore/api/firebase_api.dart';
import 'package:todo_app_firestore/model/todo.dart';
import 'package:todo_app_firestore/provider/todos.dart';
import 'package:todo_app_firestore/widget/add_todo_dialog_widget.dart';
import 'package:todo_app_firestore/widget/tomorrow _list_widget.dart';
import 'package:todo_app_firestore/widget/todo_list_widget.dart';
import 'package:todo_app_firestore/widget/upcoming_list_widget.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  TextEditingController controller;
  Icon actionIcon;
  Widget appBarTitle;
  String searchInput = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
     actionIcon = new Icon(Icons.search);
     appBarTitle = new Text("Search...");
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      TomorrowListWidget(),
      UpComingListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          // Navigate to the Search Screen
          IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      controller: controller,
                      onChanged: (input) {
                        setState(() {
                          searchInput = input.toString();
                        });
                      },
                      decoration: new InputDecoration(
                        /*prefixIcon: new Icon(Icons.search, color: Colors.white),*/
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white),
                      ),
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      autofocus: true,
                      cursorColor: Colors.white,
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("ToDo App");
                    controller.clear();
                  }
                });
              },
          )
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) =>
            setState(() {
              selectedIndex = index;
            }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 22),
            label: 'Tomorrow',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 22),
            label: 'Upcoming',
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream:
     (searchInput != null && searchInput != "") ?
     FirebaseApi.readDataTodos(selectedIndex,searchInput):
    FirebaseApi.readTodos(selectedIndex),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final todos = snapshot.data;

                final provider = Provider.of<TodosProvider>(context,listen: false);
                provider.setTodos(todos);
                searchInput='';
                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () =>
            showDialog(
              context: context,
              builder: (context) =>
                  AddTodoDialogWidget(selectedIndex: selectedIndex),
              barrierDismissible: false,
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) =>
    Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
