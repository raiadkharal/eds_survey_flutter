import 'dart:io';
import 'dart:typed_data';

import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/db/entities/outlet_request/OutletTable.dart';
import '../../../data/db/entities/outlet_request/RequestForm.dart';
import '../../../data/models/DocumentTable.dart';
import '../../../data/models/Request.dart';
import '../../../data/models/RoutesModel.dart';
import '../../../utils/Event.dart';

class FormTwoViewModel extends GetxController {

  final Repository _repository;
  Rx<File> signatureImage = Rx<File>(File(""));
  Rx<File> cnicFrontImage = Rx<File>(File(""));
  Rx<File> cnicBackImage = Rx<File>(File(""));
  Rx<File> outletImage = Rx<File>(File(""));


  FormTwoViewModel(this._repository);

  void saveSignatureImage(Uint8List? image) async{
    if(image!=null) {
     File file = await createImageFile();
      signatureImage.value = await file.writeAsBytes(image);
      signatureImage.refresh();
    }
  }


  Future<File> createImageFile()async{
    Directory tempDir = await Directory.systemTemp.createTemp();

    // Generate a random file name
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

    // Write the Uint8List to a file in the temporary directory
    File file = File('${tempDir.path}/$fileName');
    return file;
  }

  void saveCnicFrontImage(File file) async{
    cnicFrontImage.value = file;
    cnicFrontImage.refresh();
    }

  void saveCnicBackImage(File file) {
    cnicBackImage.value = file;
    cnicBackImage.refresh();
    }

  void saveOutletImage(File file) {
    outletImage.value = file;
    outletImage.refresh();
    }

  void addRequest(RequestForm outletRequestForm) {
    _repository.addRequest(outletRequestForm);
  }

  void updateReqForm(RequestForm outletRequestForm) {
    _repository.updateRequest(outletRequestForm);
  }

  void newOutletRequest(Request request, RequestForm? outletRequestForm){
    _repository.postOutletRequest(request, outletRequestForm);
  }

  RxBool isLoading()=>_repository.isLoading();

  Rx<Event<String>> getMessage() => _repository.getMessage();

  Rx<RoutesModel> getRoutesLiveData()=>_repository.getRoutesLiveData();


  RxBool isOutletRequestSaved()=>_repository.isOutletRequestSaved();

  void setLoading(bool value){
    _repository.setLoading(value);
  }

  void deleteTables(bool getRouteTables) {
    _repository.deleteTables(getRouteTables);
  }

  void addDocuments(List<DocumentTable>? documents) {
    _repository.addDocuments(documents);
  }

  void addOutlets(List<OutletTable>? outlets) {
    _repository.addOutlets(outlets);
  }

  RxMap<String, dynamic> getHashMapLiveData()=>_repository.getHashMapLiveData();

  void deleteReq(RequestForm requestForm) {
    _repository.deleteRequestForm(requestForm);
  }


  void getRouteInformation() {
    _repository.getRoutesModel();
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

}
