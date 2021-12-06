import 'package:flutter/material.dart';
import 'package:to_do/models/tasks.dart';
import 'package:to_do/widget/task_tile.dart';

class TaskList extends StatefulWidget {
  final List<Task> tasks;
  const TaskList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
          taskTitle: widget.tasks[index].name,
          isChecked: widget.tasks[index].isDone,
          checkBoxCallBack: (value) {
            setState(() {
              widget.tasks[index].isDone = value;
            });
          },
        );
      },
      itemCount: widget.tasks.length,
    );
  }
}
