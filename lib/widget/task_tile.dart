import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final bool? isChecked;
  final String taskTitle;
  final Function checkBoxCallBack;

  const TaskTile(
      {Key? key,
      required this.taskTitle,
      this.isChecked,
      required this.checkBoxCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isChecked == true ? Colors.green : Colors.black,
          decoration: isChecked == true ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: (value) {
          checkBoxCallBack();
        },
      ),
    );
  }
}
