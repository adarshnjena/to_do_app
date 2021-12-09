import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String name;
  @HiveField(1)
  bool isDone;

  Task({required this.name, this.isDone = false});
}
