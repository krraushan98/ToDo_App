//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DailogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DailogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return AlertDialog(
      title: Text('Add Task'),
      content: Container(
        height: screenHeight * 0.18,
        width: screenWidth * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter Task Name',
                border: OutlineInputBorder(),
              ),
            ),
            // SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(text: "Cancel", onPressed: onCancel),
                SizedBox(width: 10.0),
                //cancel button
                MyButton(text: "Save", onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
