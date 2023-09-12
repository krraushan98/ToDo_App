import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/util/dailog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

import '../data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();
  final _controller = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync:this, // Use the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 500),
    );
    if (_myBox.isEmpty) {
      db.CreateInitialData();
      //db.updateDataBase();
    } else {
      db.loadData();
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DailogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void editTask(int index) {
    _controller.text = db.toDoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return DailogBox(
          controller: _controller,
          onSave: () {
            setState(() {
              db.toDoList[index][0] = _controller.text;
            });
            Navigator.of(context).pop();
            db.updateDataBase();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('To Do'),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 30.0),
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          final slideOffSet = 100.0;
          _animationController.forward();
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animationController, // Use the animation controller
                curve: Curves.easeOut,
              ),
            ),
            child: ToDotile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (bool? value) {
                setState(() {
                  db.toDoList[index][1] = value!;
                });
              },
              deleteFunction: (context) => deleteTask(index),
              editFunction: (context) => editTask(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: Icon(Icons.add),
        // backgroundColor: Colors.blue,
      ),
    );
  }
}
