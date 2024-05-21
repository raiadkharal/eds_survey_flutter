import 'dart:io';
import 'dart:typed_data';

import 'package:eds_survey/Route.dart';
import 'package:eds_survey/data/models/FormOneModel.dart';
import 'package:eds_survey/data/models/FormTwoModel.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/new_outlet_request/form_two/FormTwoViewModel.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/Util.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/ImageSectionView.dart';
import '../../../components/progress_dialog/PregressDialog.dart';
import '../../../components/textfield/UnderlinedTextField.dart';
import '../../../data/db/entities/outlet_request/RequestForm.dart';
import '../../../data/models/Request.dart';
import '../../../data/models/RequestFormSingleton.dart';
import '../../../utils/NetworkManager.dart';
import '../../signature_pad/SignatureScreen.dart';

class FormTwo extends StatefulWidget {
  const FormTwo({super.key});

  @override
  State<FormTwo> createState() => _FormTwoState();
}

class _FormTwoState extends State<FormTwo> {
  final FormTwoViewModel controller =
      Get.put<FormTwoViewModel>(FormTwoViewModel(Get.find<Repository>()));

  final FormTwoModel formTwoModel = FormTwoModel();

  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerFNameController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _cellNumController = TextEditingController();
  final TextEditingController _contactPerson1Controller =
      TextEditingController();
  final TextEditingController _contactPersonCellNum1Controller =
      TextEditingController();
  final TextEditingController _contactPerson2Controller =
      TextEditingController();
  final TextEditingController _contactPersonCellNum2Controller =
      TextEditingController();
  final TextEditingController _contactPerson3Controller =
      TextEditingController();
  final TextEditingController _contactPersonCellNum3Controller =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RequestForm? outletRequestForm;

  final List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];

  int? updateOutletRequestId;

  @override
  void initState() {
    setObservers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FormOneSingletonModel model = FormOneSingletonModel.getInstance();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                syncFunction(false);
              },
              icon: const Icon(Icons.sync)),
          TextButton(
              onPressed: () {
                if (validateForm()) {
                  okFunction();
                }
              },
              child: Text(
                "OK",
                style: GoogleFonts.roboto(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ))
        ],
        title: Text(
          "OUTLET REQUEST",
          style: GoogleFonts.roboto(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 26.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  UnderlinedTextField(
                                    controller: _ownerNameController,
                                    labelText: 'Owner Name',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Owner Name";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller: _ownerFNameController,
                                    labelText: 'Owner Father Name',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Owner Father Name";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller: _cnicController,
                                    labelText: 'CNIC',
                                    maxLength: 13,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty || value.length != 13) {
                                        return "Enter Correct CNIC";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller: _cellNumController,
                                    labelText: 'Contact Person Phone',
                                    helperText:
                                        Constants.PHONE_NUMBER_HELPER_TEXT,
                                    maxLength: 12,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.isEmpty || value.length != 12) {
                                        return "Enter Correct Phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller: _contactPerson1Controller,
                                    labelText: 'Contact Person',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Contact Person";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller:
                                        _contactPersonCellNum1Controller,
                                    labelText: 'Contact Person 1 Phone',
                                    helperText:
                                        Constants.PHONE_NUMBER_HELPER_TEXT,
                                    maxLength: 12,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.isEmpty || value.length != 12) {
                                        return "Enter Correct Phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller: _contactPerson2Controller,
                                    labelText: 'Contact Person 2',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Contact Person 2";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller:
                                        _contactPersonCellNum2Controller,
                                    labelText: 'Contact Person 2 Phone',
                                    helperText:
                                        Constants.PHONE_NUMBER_HELPER_TEXT,
                                    maxLength: 12,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.isEmpty || value.length != 12) {
                                        return "Enter Correct Phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller: _contactPerson3Controller,
                                    labelText: 'Contact Person 3',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Enter Contact Person 3";
                                      }
                                      return null;
                                    },
                                  ),
                                  UnderlinedTextField(
                                    controller:
                                        _contactPersonCellNum3Controller,
                                    labelText: 'Contact Person 3 Phone',
                                    keyboardType: TextInputType.phone,
                                    helperText:
                                        Constants.PHONE_NUMBER_HELPER_TEXT,
                                    maxLength: 12,
                                    validator: (value) {
                                      if (value.isEmpty || value.length != 12) {
                                        return "Enter Correct Phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                  Obx(
                                    () => ImageSectionView(
                                        text: 'CNIC Front Image',
                                        iconData: Icons.camera_alt,
                                        imageFile:
                                            controller.cnicFrontImage.value,
                                        onIconClick: () => _getImageFromCamera(
                                            ImageType.CNIC_FRONT)),
                                  ),
                                  Obx(
                                    () => ImageSectionView(
                                        text: 'CNIC Back Image',
                                        iconData: Icons.camera_alt,
                                        imageFile:
                                            controller.cnicBackImage.value,
                                        onIconClick: () => _getImageFromCamera(
                                            ImageType.CNIC_BACK)),
                                  ),
                                  Obx(
                                    () => ImageSectionView(
                                      text: 'E-Signature',
                                      iconData: Icons.edit,
                                      termsAndConditions:
                                          "Terms and Conditions",
                                      imageFile:
                                          controller.signatureImage.value,
                                      onIconClick: () =>
                                          _navigateToSignatureScreen(),
                                    ),
                                  ),
                                  Obx(
                                    () => ImageSectionView(
                                      text: 'Outlet Image',
                                      iconData: Icons.camera_alt,
                                      imageFile: controller.outletImage.value,
                                      onIconClick: () =>
                                          _getImageFromCamera(ImageType.OUTLET),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50)),
                        width: 8,
                        height: 8,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)),
                        width: 8,
                        height: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => controller.isLoading().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  Future<void> _getImageFromCamera(ImageType imageType) async {
    PermissionStatus cameraPermission = await Permission.camera.status;

    if (cameraPermission == PermissionStatus.denied) {
      cameraPermission = await Permission.camera.request();

      if (cameraPermission == PermissionStatus.permanentlyDenied) {
        return Future.error(
            "Camera permissions are permanently denied, we cannot request permissions.");
      }
    }

    final ImagePicker picker = ImagePicker();
    controller.setLoading(true);
    picker
        .pickImage(source: ImageSource.camera)
        .then((pickedFile) async {
          if (pickedFile != null) {
            switch (imageType) {
              case ImageType.CNIC_FRONT:
                controller.saveCnicFrontImage(File(pickedFile.path));
                break;
              case ImageType.CNIC_BACK:
                controller.saveCnicBackImage(File(pickedFile.path));
                break;
              case ImageType.OUTLET:
                controller.saveOutletImage(File(pickedFile.path));
                break;
            }
          } else {
            controller.setLoading(false);
            showToastMessage("Something went wrong.Please try again!");
          }
        })
        .whenComplete(() => controller.setLoading(false))
        .onError((error, stackTrace) {
          controller.setLoading(false);
        });
  }

  void _navigateToSignatureScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignatureScreen()),
    );

    // Handle the result received from Screen B
    if (result != null) {
      Uint8List imageFile = Uint8List.fromList(result);
      controller.saveSignatureImage(imageFile);
      // signature = base64Encode(imageFile);
    }
  }

  bool validateForm() {
    if (_formKey.currentState != null) {
      if (!_formKey.currentState!.validate()) {
        showToastMessage("Please enter all the fields");
        return false;
      }
    } else {
      return false;
    }

    return true;
  }

  Future<void> saveFormData() async {
    formTwoModel.ownerName = _ownerNameController.text.toString().trim();

    formTwoModel.ownerFatherName = _ownerFNameController.text.toString().trim();

    formTwoModel.cnic = _cnicController.text.toString().trim();

    formTwoModel.cellNo = _cellNumController.text.toString().trim();

    formTwoModel.contactPerson1 =
        _contactPerson1Controller.text.toString().trim();

    formTwoModel.contactPerson1CellNum =
        _contactPersonCellNum1Controller.text.toString().trim();

    formTwoModel.contactPerson2 =
        _contactPerson2Controller.text.toString().trim();

    formTwoModel.contactPerson2CellNum =
        _contactPersonCellNum2Controller.text.toString().trim();

    formTwoModel.contactPerson3 =
        _contactPerson3Controller.text.toString().trim();

    formTwoModel.contactPerson3CellNum =
        _contactPersonCellNum3Controller.text.toString().trim();

    formTwoModel.frontImage = controller.cnicFrontImage.value.path;
    formTwoModel.backImage = controller.cnicBackImage.value.path;
    formTwoModel.outletImage = controller.outletImage.value.path;
    formTwoModel.signature = controller.signatureImage.value.path;
  }

  void okFunction() async {
    FormOneSingletonModel formOneSingletonModel =
        FormOneSingletonModel.getInstance();

    await saveFormData();

    RequestForm outletRequestForm = RequestForm();
    outletRequestForm.setId(formOneSingletonModel.outletId);
    outletRequestForm.setRequesTypeId(formOneSingletonModel.requestTypeId);
    outletRequestForm.setOutletName(formOneSingletonModel.outletName);
    outletRequestForm.setOutletAddress(formOneSingletonModel.outletAddress);
    outletRequestForm.setLocation(formOneSingletonModel.landmark);
    outletRequestForm.setRadius(formOneSingletonModel.radius);
    outletRequestForm
        .setVpoClassification(formOneSingletonModel.vpoClassification);
    outletRequestForm.setCityId(formOneSingletonModel.cityId);

    outletRequestForm.setRouteId(formOneSingletonModel.routeId);
    outletRequestForm.setOutletImagePath(formTwoModel.outletImage);
    outletRequestForm
        .setVpoClassificationId(formOneSingletonModel.vpoClassificationId);
    outletRequestForm.setOutletTypeId(formOneSingletonModel.outletTypeId);
    outletRequestForm.setMarketeTypeId(formOneSingletonModel.marketTypeId);
    outletRequestForm.setDistributionId(formOneSingletonModel.distributionId);
    outletRequestForm.setOrganizationId(formOneSingletonModel.organizationId);
    outletRequestForm
        .setTradeClassificationId(formOneSingletonModel.tradeClassificationId);
    outletRequestForm.setOutletClassificationId(
        formOneSingletonModel.outletClassificationId);
    outletRequestForm.setChannelId(formOneSingletonModel.channelId);
    outletRequestForm
        .setCompetitorExist(formOneSingletonModel.competitorsCooler);
    outletRequestForm.setIsPJPFixed(formOneSingletonModel.journeyPlan);
    outletRequestForm
        .setAgreedYTDSalesVolume(formOneSingletonModel.agreedSalesVolume);
    outletRequestForm.setPjPs(formOneSingletonModel.pjpModels);
    outletRequestForm.setComments(formOneSingletonModel.comments);
    if (formOneSingletonModel.lat != null) {
      outletRequestForm.setLatitude(formOneSingletonModel.lat);
      outletRequestForm.setLongitude(formOneSingletonModel.lng);
    } else {
      outletRequestForm.setLatitude(0.0);
      outletRequestForm.setLongitude(0.0);
    }
    outletRequestForm.setOwnerName(formTwoModel.ownerName);
    outletRequestForm.setOwnerFatherName(formTwoModel.ownerFatherName);
    outletRequestForm.setOwnerCNIC(formTwoModel.cnic);
    outletRequestForm.setPhoneNumber(formTwoModel.cellNo);
    outletRequestForm.setOutletImagePath(formTwoModel.outletImage);
    outletRequestForm.setContactPerson1(formTwoModel.contactPerson1);
    outletRequestForm
        .setContactPerson1CellNumber(formTwoModel.contactPerson1CellNum);
    outletRequestForm.setContactPerson2(formTwoModel.contactPerson2);
    outletRequestForm
        .setContactPerson2CellNumber(formTwoModel.contactPerson2CellNum);
    outletRequestForm.setContactPerson3(formTwoModel.contactPerson3);
    outletRequestForm
        .setContactPerson3CellNumber(formTwoModel.contactPerson3CellNum);
    outletRequestForm.setCnicFrontImageFilePath(formTwoModel.frontImage);
    outletRequestForm.setCnicBackImageFilePath(formTwoModel.backImage);
    outletRequestForm.setESignatureFilePath(formTwoModel.signature);
    outletRequestForm.setWorkflowStateId(formOneSingletonModel.workFlowId);
    outletRequestForm.setRequestDate(Util.formatDate(
        Util.DATE_FORMAT_6, DateTime.now().millisecondsSinceEpoch));
    outletRequestForm.setRequestStatus(
        controller.validateRequestForm(outletRequestForm) == "" ? 1 : 0);
    if (updateOutletRequestId == null) {
      controller.addRequest(outletRequestForm);
    } else {
      outletRequestForm.setFormId(updateOutletRequestId);
      controller.updateReqForm(outletRequestForm);
    }

  }

  void syncFunction(bool doNotDisturb) async {
    FormOneSingletonModel formOneSingletonModel =
        FormOneSingletonModel.getInstance();

    await saveFormData();

    Request request = Request();
    request.setRequesTypeId(Constants.NEW_OUTLET_REQUEST_TYPE_ID);
    request.setId(formOneSingletonModel.requestId);
    request.setCode(formOneSingletonModel.outletCode);
    request.setOutletName(formOneSingletonModel.outletName);
    request.setOutletAddress(formOneSingletonModel.outletAddress);
    request.setLocation(formOneSingletonModel.landmark);
    request.setRadius(formOneSingletonModel.radius);
    request.setDistributionId(formOneSingletonModel.distributionId);
    request.setOrganizationId(formOneSingletonModel.organizationId);
    request.setRouteId(formOneSingletonModel.routeId);
    request.setOwnerName(formTwoModel.ownerName);
    request.setOutletImagePath(formTwoModel.outletImage);
    // request.setDonotValidatePhoneNumbers(doNotDisturb);
    request.setVpoClassificationId(formOneSingletonModel.vpoClassificationId);
    request.setAgreedYTDSalesVolume(formOneSingletonModel.agreedSalesVolume);
    request.setVpoClassification(formOneSingletonModel.vpoClassification);
    request.setCityId(formOneSingletonModel.cityId);
    request.setRouteId(formOneSingletonModel.routeId);
    request.setOutletTypeId(formOneSingletonModel.outletTypeId);
    request.setMarketeTypeId(formOneSingletonModel.marketTypeId);
    request.setDonotValidatePhoneNumbers(doNotDisturb);
    request
        .setTradeClassificationId(formOneSingletonModel.tradeClassificationId);
    request.setOutletClassificationId(
        formOneSingletonModel.outletClassificationId);
    request.setChannelId(formOneSingletonModel.channelId);
    request.setCompetitorExist(formOneSingletonModel.competitorsCooler);
    request.setIsPJPFixed(formOneSingletonModel.journeyPlan);
    request.setPjPs(formOneSingletonModel.pjpModels);
    request.setLatitude(formOneSingletonModel.lat);
    request.setLongitude(formOneSingletonModel.lng);

    request.setComments(formOneSingletonModel.comments);

    request.setOwnerFatherName(formTwoModel.ownerFatherName);
    request.setOwnerCNIC(formTwoModel.cnic);
    request.setPhoneNumber(formTwoModel.cellNo);

    request.setContactPerson1(formTwoModel.contactPerson1);
    request.setContactPerson1CellNumber(formTwoModel.contactPerson1CellNum);

    request.setContactPerson2(formTwoModel.contactPerson2);
    request.setContactPerson2CellNumber(formTwoModel.contactPerson2CellNum);

    request.setContactPerson3(formTwoModel.contactPerson3);
    request.setContactPerson3CellNumber(formTwoModel.contactPerson3CellNum);

    request.setCnicFrontImageFilePath(formTwoModel.frontImage);
    request.setCnicBackImageFilePath(formTwoModel.backImage);
    request.setESignatureFilePath(formTwoModel.signature);

    if (outletRequestForm == null) {
      controller.newOutletRequest(request, null);
    } else {
      controller.newOutletRequest(request, outletRequestForm);
    }
  }

  void setObservers() {
    debounce(controller.getRoutesLiveData(), (routesModel) {
      if (bool.parse(routesModel.success ?? "true")) {
        controller.deleteTables(true);
        controller.addDocuments(routesModel.documents);
        controller.addOutlets(routesModel.outlets);

//                if (syncCallback != null) {
//                    if (progressDialog != null)
//                        progressDialog.dismiss();
//                    syncCallback.onSync();
//                }

//                if (progressDialog != null)
//                    progressDialog.dismiss();
      } else {
        showToastMessage(routesModel.errorMessage.toString());
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.isOutletRequestSaved(), (aBoolean) {
      if (aBoolean) {
        showToastMessage("Request saved");
        Get.until((route) => Get.currentRoute == Routes.outletRequest);
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getHashMapLiveData(), (hashMap) {
      RequestForm? requestForm = hashMap["requestForm"] as RequestForm?;
      Request? requestBody = hashMap["data"] as Request?;
      bool success = bool.parse(hashMap["success"]);

      if (success) {
        if (requestForm != null) controller.deleteReq(requestForm);

        RequestFormSingleton.setRequest(null);
        getRouteApi();
        Get.until((route) => Get.currentRoute == Routes.outletRequest);
      } else {
        if (requestBody != null && requestBody.getErrorCode() == 2) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Warning"),
              content: const Text(
                  "You have entered same contact number multiple times, do you want to continue?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      syncFunction(true);
                    },
                    child: const Text("Ok")),
              ],
            ),
          );
        } else {
          if (requestBody != null) {
            showToastMessage(requestBody.getErrorMessage().toString());
          }
        }
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getMessage(), (event) {
      showToastMessage(event.peekContent());
    }, time: const Duration(milliseconds: 200));
  }

  void getRouteApi() {
    NetworkManager.getInstance().isConnectedToInternet().then((connected) {
      if (connected) {
        controller.getRouteInformation();
      } else {
        showToastMessage(Constants.NETWORK_ERROR);
      }
    });
  }
}
