import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/models/tasks.dart';
import 'package:to_do/widget/task_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('tasks');
    return ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              var data = box.getAt(index);
              return Slidable(
                // Specify a key if the Slidable is dismissible.
                key: UniqueKey(),
                child: TaskTile(
                  taskTitle: data.name,
                  isChecked: data.isDone,
                  checkBoxCallBack: () {
                    bool temp = !data.isDone;
                    String tempName = data.name;
                    box.put(index, Task(name: tempName, isDone: temp));
                  },
                ),
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {
                    onDelete(box, index, context);
                  }),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (context) {
                        onDelete(box, index, context);
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      // An action can be bigger than the others.
                      flex: 2,
                      onPressed: (context) {
                        bool temp = !data.isDone;
                        String tempName = data.name;
                        box.put(index, Task(name: tempName, isDone: temp));
                      },
                      backgroundColor: data.isDone == false
                          ? const Color(0xFF7BC043)
                          : Colors.black,
                      foregroundColor: Colors.white,
                      icon: data.isDone == false ? Icons.done : Icons.undo,
                      label: data.isDone == false ? 'Done' : 'Undo',
                    ),
                  ],
                ),
              );
            },
            itemCount: box.length,
          );
        });
  }
}

void onDelete(box, int index, BuildContext context) {
  final snackBar = SnackBar(
    backgroundColor: Colors.black,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Task ${box.getAt(index).name} Deleated !!',
          style: GoogleFonts.nunito(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const Icon(
          Icons.delete,
          color: Colors.lightBlueAccent,
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);

  box.deleteAt(index);
}
