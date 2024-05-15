
import 'package:eds_survey/data/db/entities/outlet_request/RequestForm.dart';

class RequestFormSingleton{
  static RequestForm? _request;

  static RequestForm? getRequest(){
    return _request;
  }

   static void setRequest(RequestForm? requestForm){
    _request = requestForm;
   }
}