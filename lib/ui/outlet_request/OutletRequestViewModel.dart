import 'package:eds_survey/data/db/entities/outlet_request/RequestForm.dart';
import 'package:eds_survey/data/models/Request.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:get/get.dart';

import '../../utils/Event.dart';

class OutletRequestViewModel extends GetxController {
  final Repository _repository;

  final List<String> tabTitles = ["DRAFT", "SYNCED", "REVERTED"];

  OutletRequestViewModel(this._repository);

  Future<List<RequestForm>> getAllUnSyncedRequestForms(int requestId) async{
    return _repository.getAllUnSyncedRequestForms(requestId);
  }

  void setLoading(bool value) {
    _repository.setLoading(value);
  }

  String validateRequestForm(RequestForm requestForm) {
    if ((requestForm.getOutletName() == null ||
            requestForm.getOutletName()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "Outlet Name cannot be empty!";
    }

    if ((requestForm.getOutletAddress() == null ||
            requestForm.getOutletAddress()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "Outlet Address cannot be empty!";
    }

    if (requestForm.getRouteId() == null &&
        requestForm.getRequesTypeId() != 8) {
      return "Route cannot be empty!";
    }

    if (requestForm.getCompetitorExist() == null &&
        requestForm.getRequesTypeId() != 8) {
      return "Must select 'Competitors Cooler' field";
    }

    if (requestForm.getAgreedYTDSalesVolume() == null &&
        requestForm.getRequesTypeId() != 8) {
      return "Agreed Sales cannot be empty!";
    }

    if ((requestForm.getCnicFrontImageFilePath() == null ||
            requestForm.getCnicFrontImageFilePath()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "CNIC Front Image is required!";
    }

    if (requestForm.getCnicBackImageFilePath() == null &&
        requestForm.getRequesTypeId() != 8) {
      return "CNIC Back Image is required!";
    }

    if ((requestForm.getOutletImagePath() == null ||
            requestForm.getOutletImagePath()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "Outlet Image is Required!";
    }

    if ((requestForm.getESignatureFilePath() == null ||
            requestForm.getESignatureFilePath()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "e-Signature is Required!";
    }

    if ((requestForm.getDistributionName() != null &&
            requestForm.getDistributionName()!.isEmpty &&
            requestForm.getRequesTypeId() == 1) ||
        (requestForm.getDistributionName() != null &&
            requestForm.getDistributionName()!.isEmpty &&
            requestForm.getRequesTypeId() == 9)) {
      return "Distribution Field is Required!";
    }

    if (((requestForm.getMdeSignature() == null ||
            requestForm.getMdeSignature()!.isEmpty) &&
        requestForm.getRequesTypeId() == 1)) {
      return "e-Signature MDE is Required!";
    }

    if ((requestForm.getComments() == null ||
            requestForm.getComments()!.isEmpty) &&
        requestForm.getRequesTypeId() == 9) {
      return "Comments Field is Required!";
    }

    if ((requestForm.getReason() == null || requestForm.getReason()!.isEmpty) &&
        requestForm.getRequesTypeId() == 9) {
      return "Reason Field is Required!";
    }

    if ((requestForm.getIssuanceCategory() == null &&
            requestForm.getRequesTypeId() == 1) ||
        (requestForm.getIssuanceCategory() == null &&
            requestForm.getRequesTypeId() == 9)) {
      return "Issuance Category Field is Required!";
    }

    if ((requestForm.getRefferedBy() == null ||
            requestForm.getRefferedBy()!.isEmpty) &&
        requestForm.getRequesTypeId() == 9) {
      return "Referred By Field is Required!";
    }

    if (requestForm.getLatitude() == 0.0 || requestForm.getLongitude() == 0.0) {
      return "Geo Coordinates is Required!";
    }

    if ((requestForm.getVpoClassification() == null ||
            requestForm.getVpoClassification()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "VPO Classification is Required!";
    }

    if ((requestForm.getOwnerName() == null ||
            requestForm.getOwnerName()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "Owner Name is Required!";
    }
    if ((requestForm.getOwnerFatherName() == null ||
            requestForm.getOwnerFatherName()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "Owner Father Name is Required!";
    }
//            if ((requestForm.getCompetitorExist()==null || requestForm.getCompetitorExist()==false) && requestForm.getRequesTypeId()!=8){
//                return "Select Competitors Cooler Field!";
//            }

    if (requestForm.getLocation() != null &&
        requestForm.getLocation()!.isEmpty &&
        requestForm.getRequesTypeId() == 4) {
      return "Landmark field is Required!";
    }
    if (requestForm.getCityId() == null && requestForm.getRequesTypeId() == 4) {
      return "City field is Required!";
    }
    if (requestForm.getOutletTypeId() == null &&
        requestForm.getRequesTypeId() == 4) {
      return "Outlet type field is Required!";
    }
    if (requestForm.getMarketeTypeId() == null &&
        requestForm.getRequesTypeId() == 4) {
      return "Market Type field is Required!";
    }
    // if (requestForm.getTradeClassificationId() == null &&
    //     requestForm.getRequesTypeId() == 4) {
    //   return "Segment field is Required!";
    // }
    if (requestForm.getOutletClassificationId() == null &&
        requestForm.getRequesTypeId() == 4) {
      return "Outlet Classification field is Required!";
    }
    if (requestForm.getChannelId() == null &&
        requestForm.getRequesTypeId() == 4) {
      return "Channel Type field is Required!";
    }

    if ((requestForm.getOutletAddress() == null ||
            requestForm.getOutletAddress()!.isEmpty) &&
        requestForm.getRequesTypeId() == 4) {
      return "Address Field is Required!";
    }

    if ((requestForm.getOwnerCNIC() == null ||
            requestForm.getOwnerCNIC()!.isEmpty) &&
        requestForm.getRequesTypeId() == 4) {
      return "CNIC Field is Required!";
    }

    if (requestForm.getRadius() != null &&
        requestForm.getRadius() == 0.0 &&
        requestForm.getRequesTypeId() == 4) {
      return "Shop Radius field is Required!";
    }
    if ((requestForm.getContactPerson1() == null ||
            requestForm.getContactPerson1()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "Contact Person 1 field is Required!";
    }

    if ((requestForm.getContactPerson1CellNumber() == null ||
            requestForm.getContactPerson1CellNumber()!.isEmpty) &&
        requestForm.getRequesTypeId() != 8) {
      return "Contact Person 1 Cell # field is Required!";
    }

    if (requestForm.getContactPerson2() != null &&
        requestForm.getContactPerson2()!.isEmpty &&
        requestForm.getRequesTypeId() == 4) {
      return "Contact Person 2 field is Required!";
    }
    if (requestForm.getContactPerson2CellNumber() != null &&
        requestForm.getContactPerson2CellNumber()!.isEmpty &&
        requestForm.getRequesTypeId() == 4) {
      return "Contact Person Cell 2 field is Required!";
    }

    if (requestForm.getContactPerson3() != null &&
        requestForm.getContactPerson3()!.isEmpty &&
        requestForm.getRequesTypeId() == 4) {
      return "Contact Person 3 field is Required!";
    }
    if (requestForm.getContactPerson3CellNumber() != null &&
        requestForm.getContactPerson3CellNumber()!.isEmpty &&
        requestForm.getRequesTypeId() == 4) {
      return "Contact Person Cell 3 field is Required!";
    }

    return "";
  }

  void deleteReq(RequestForm requestForm) {
    _repository.deleteRequestForm(requestForm);
  }


  void newOutletRequest(Request request, RequestForm? outletRequestForm){
    _repository.postOutletRequest(request, outletRequestForm);
  }

  void getRouteInformation() {
    _repository.getRoutesModel();
  }


  RxBool isLoading()=>_repository.isLoading();

  Rx<Event<String>> getMessage() => _repository.getMessage();

  RxMap<String, dynamic> getHashMapLiveData()=>_repository.getHashMapLiveData();
}
