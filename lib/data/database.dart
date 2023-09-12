import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box('myBox');

//run this method if this is the 1st time the app is running
  void CreateInitialData() {
    toDoList = [
      ["Make Tutorial",false],
      ['Do Exercise',false],
    ];
  }

//load data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

 //update the database 
 void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);
 }
}
