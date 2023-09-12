import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ToDotile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;
   late AnimationController _animationController;

 ToDotile({super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
    });
   

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0, right: 25.0, top: 25.0),
      
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                backgroundColor: Colors.red,
                icon: Icons.delete,
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                ),
                SlidableAction(
          onPressed: editFunction, // Use editFunction for edit action
          backgroundColor: Colors.blue,
          icon: Icons.edit,
          foregroundColor: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
            ],
            ),
            
          child: Column(
            children: [Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(15.0),
                ),
              child: Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                     onChanged: onChanged,
                     activeColor: Colors.green,
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                  ),
                  Text(taskName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    decoration: taskCompleted ? TextDecoration.lineThrough : null,
                  ),
                  ),
                ],
                ),
            ),
         ] ),
        ),
      );
  }
}