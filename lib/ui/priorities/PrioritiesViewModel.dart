import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/data/db/entities/task.dart';
import 'package:eds_survey/data/db/entities/task_type.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:provider/provider.dart';

class PrioritiesViewModel extends GetxController {
  final Rx<List<dynamic>> tasksTypes = Rx<List<dynamic>>([]);
  late final Repository _repository;
  int index = 1;
  int? outletId;

  Rx<List<Task>> tasks = Rx<List<Task>>([]);

  PrioritiesViewModel(this._repository);

  void addNewTask(Task task) {
    tasks.value.add(task);
    tasks.refresh();
  }

  void deleteTaskAtPosition(int position) {
    tasks.value.removeAt(position);
    tasks.refresh();
  }

  void setOutletId(int? id) => outletId = id;

  void loadMVTaskTypes(int outletId) async =>
    tasksTypes.value = await _repository.getMVTaskTypes();

  void loadWWTaskTypes(int outletId) async{
    tasksTypes.value = await _repository.getWWTaskTypes();
  }

  RxBool isLoading()=>_repository.isLoading();

  Rx<Event<String>> getMessage()=>_repository.getMessage();
  Rx<bool> getPostWorkWithSaved()=>_repository.getWorkWithSaved();

  void priorityRemarksDataSet() {
    try {
      WorkWithSingletonModel.getInstance().setTasks(tasks.value);
      WorkWithSingletonModel.getInstance()
          .setEndTime(DateTime.now().millisecondsSinceEpoch);
      WorkWithSingletonModel.getInstance().setDailyVisitId(25);

      _repository.postWorkWith(WorkWithSingletonModel.getInstance());
    } catch (e) {
      _repository.setLoading(false);
      showToastMessage(e.toString());
    }
  }

  void updateTask(Task task) {
    tasks.value.remove(task);
    tasks.value.add(task);
  }

}
