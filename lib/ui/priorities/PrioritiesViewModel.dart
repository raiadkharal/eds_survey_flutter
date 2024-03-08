import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PrioritiesViewModel extends ChangeNotifier {
  final List<String> _taskList = ["Cooler Not Working", "Cooling Problem"];

  List<String> get tasks => _taskList;
  int index=1;

  void addNewTask(String task) {
    _taskList.add("$task $index+1");
    notifyListeners();
  }

  void deleteTaskAtPosition(int position) {
    _taskList.removeAt(position);
    notifyListeners();
  }
// void updateTask(String task){
//   _taskList.remove(task);
// }
}
