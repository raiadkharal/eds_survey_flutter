import 'package:eds_survey/ui/home/HomeRepository.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/Util.dart';

class HomeViewModel extends ChangeNotifier {
  late final HomeRepository repository;
  late ValueNotifier<bool> _isLoading;
  bool startDay = false;
  bool endDay = false;
  bool isLoading = false;
  Event<String> msg = Event("");
  Event<String> progressMsg = Event("");

  HomeViewModel() {
    repository = HomeRepository.singleInstance();
    _isLoading = repository.isLoading();

    addValueListeners();
  }

  void start() {
    repository.getToken();
  }

  void setStartDay() {
    repository.setStartDay();
  }

  void checkDayEnd() {
    PreferenceUtil.getInstance().then((preferenceUtil) {
      int lastSyncDate = preferenceUtil.getWorkSyncData().syncDate;
      if (lastSyncDate != 0) {
        if (!Util.isDateToday(lastSyncDate)) {
          repository.startDay().value = false;
        } else {
          repository.startDay().value = true;
        }
      } else {
        repository.startDay().value = false;
      }
    });
  }

  void addValueListeners() {
    repository.isLoading().addListener(() {
      isLoading = repository.isLoading().value;
      notifyListeners();
    });

    repository.startDay().addListener(() {
      startDay = repository.startDay().value;
      notifyListeners();
    });

    repository.endDay().addListener(() {
      endDay = repository.endDay().value;
      notifyListeners();
    });

    repository.getMessage().addListener(() {
      Fluttertoast.showToast(msg: repository.getMessage().value.peekContent());
      notifyListeners();
    });

    repository.getProgressMsg().addListener(() {
      progressMsg = repository.getProgressMsg().value;
      notifyListeners();
    });
  }
}
