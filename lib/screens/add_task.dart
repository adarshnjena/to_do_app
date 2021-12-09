import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:to_do/models/tasks.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String newTaskTitle;
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 35,
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                cursorColor: Colors.lightBlueAccent,
                style: const TextStyle(fontSize: 25),
                onChanged: (value) {
                  newTaskTitle = value;
                },
              ),
              const SizedBox(height: 30),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                onPressed: () {
                  if (newTaskTitle != '') {
                    final box = Hive.box('tasks');
                    box.add(Task(name: newTaskTitle));
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Add Task',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
