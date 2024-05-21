import 'package:eds_survey/Route.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/outlet_request/OutletRequestViewModel.dart';
import 'package:eds_survey/ui/outlet_request/draft/DraftScreen.dart';
import 'package:eds_survey/ui/outlet_request/reverted/RevertedScreen.dart';
import 'package:eds_survey/ui/outlet_request/synced/SyncedScreen.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/NetworkManager.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/progress_dialog/PregressDialog.dart';
import '../../data/db/entities/outlet_request/RequestForm.dart';
import '../../data/models/Request.dart';

class OutletRequestScreen extends StatefulWidget {
  const OutletRequestScreen({super.key});

  @override
  State<OutletRequestScreen> createState() => _OutletRequestScreenState();
}

class _OutletRequestScreenState extends State<OutletRequestScreen> with SingleTickerProviderStateMixin {
  final OutletRequestViewModel controller = Get.put<OutletRequestViewModel>(
      OutletRequestViewModel(Get.find<Repository>()));

  late TabController _tabController;


  int counterMultipleApi = 0;

  int clickCode = Constants.NEW_OUTLET_REQUEST;

  List<RequestForm> requestFormsList = [];

  final List<Widget> pages = [
    const DraftScreen(),
    const SyncedScreen(),
    const RevertedScreen(),
  ];

  @override
  void initState() {
    setObservers();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    super.initState();
  }

  void _handleTabChange() {
      _tabController.animateTo(_tabController.index);
     switch(_tabController.index){
       case 0:
         clickCode=Constants.NEW_OUTLET_REQUEST;
         break;
       case 1:
         clickCode=Constants.SYNC_OUTLET_REQ;
         break;
       case 2:
         clickCode=Constants.SYNC_OUTLET_REQ;
         break;
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                getALlReqBackgroundTasks(
                    Constants.NEW_OUTLET_REQUEST_TYPE_ID, clickCode);
              },
              icon: const Icon(Icons.sync)),
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.outletRequestFormOne);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )),
        ],
        bottom: TabBar(
            labelColor: primaryColor,
            indicatorColor: primaryColor,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: controller.tabTitles
                .map((title) => Tab(
                      text: title,
                    ))
                .toList()),
        title: Text(
          "OUTLET REQUEST",
          style: GoogleFonts.roboto(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: pages,
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

  void getALlReqBackgroundTasks(int requestId, int clickCode) async {
    controller
        .getAllUnSyncedRequestForms(requestId)
        .then((requestFormsListBackground) {
      if (requestFormsListBackground.isNotEmpty) {
        counterMultipleApi = 0;
        controller.setLoading(true);
        requestFormsList.clear();
        requestFormsList.addAll(requestFormsListBackground);
        Request request = getRequest(requestFormsList[counterMultipleApi]);
        if (clickCode == Constants.SYNC_OUTLET_REQ ||
            clickCode == Constants.NEW_OUTLET_REQUEST) {
          if (clickCode == Constants.NEW_OUTLET_REQUEST) {
            if (request.getRequesTypeId() ==
                Constants.NEW_OUTLET_REQUEST_TYPE_ID) {
              int total = 0;
              int readyToPost = 0;
              int inCompleteCount = 0;
              for (RequestForm requestForm in requestFormsList) {
                if (requestForm.getRequesTypeId() == 4) {
                  if (requestForm.getRequestStatus() == 1) {
                    if (controller.validateRequestForm(requestForm) == "") {
                      readyToPost++;
                    }
                  }
                  total++;
                }
              }
              inCompleteCount = total - readyToPost;
              if (readyToPost > 0) {
                for (RequestForm requestForm in requestFormsList) {
                  if (requestForm.getRequesTypeId() == 4) {
                    String message =
                        controller.validateRequestForm(requestForm);
                    if (requestForm.getRequestStatus() == 1 &&
                        message.isEmpty) {
                      apiNewOutletReq(request, requestForm);
                    }
                  }
                }
              } else {
                if (total == 0) {
                  controller.setLoading(false);
                  showToastMessage(
                      "There is nothing to Sync!\nPlease Fill the Request Forms.");
                } else {
                  controller.setLoading(false);
                  showToastMessage(
                      "There ${(total > 1) ? "are" : "is"} $total incomplete request(s)");
                }
              }
            }
          }
          else if (clickCode == Constants.SYNC_OUTLET_REQ) {
            int total = 0;
            int readyToPost = 0;
            int inCompleteCount = 0;
            controller.setLoading(false);
            List<RequestForm> readyToPostList = [];
            for (RequestForm requestForm in requestFormsList) {
              if (requestForm.getRequesTypeId() == 4) {
                if (requestForm.getRequestStatus() == 1) {
                  if (controller.validateRequestForm(requestForm) == "") {
                    readyToPost++;
                    readyToPostList.add(requestForm);
                  }
                }
                total++;
              }
            }
            inCompleteCount = total - readyToPost;
            if (inCompleteCount > 0) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Request Forms"),
                        content: Text(
                            "You have $inCompleteCount  request(s) pending in Draft with incomplete information."),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (readyToPostList.isNotEmpty) {
                                  for (RequestForm requestForm
                                      in readyToPostList) {
                                    if (requestForm.getRequesTypeId() == 4) {
                                      String message = controller
                                          .validateRequestForm(requestForm);
                                      if ((requestForm.getRequestStatus() ==
                                              1 &&
                                          message.isEmpty)) {
                                        apiNewOutletReq(request, requestForm);
                                      } else {
                                        getRouteApi();
                                        //  progressDialog.dismiss();
                                      }
                                    }
                                  }
                                } else {
                                  getRouteApi();
                                }
                              },
                              child: const Text("Ok"))
                        ],
                      ));
            } else {
              if (readyToPost > 0) {
                for (RequestForm requestForm in requestFormsList) {
                  if (requestForm.getRequesTypeId() == 4) {
                    String message =
                        controller.validateRequestForm(requestForm);
                    if (requestForm.getRequestStatus() == 1 &&
                        message.isEmpty) {
                      apiNewOutletReq(request, requestForm);
                    } else {
                      controller.setLoading(false);
                    }
                  }
                }
              } else {
                if (total == 0) {
                  controller.setLoading(false);
                  showToastMessage("There is nothing to Sync!.");
                } else {
                  controller.setLoading(false);
                  showToastMessage(
                      "There ${((total > 1) ? "are" : "is")}  $total incomplete request(s)");
                }
              }
            }
          }
        }
      } else {
        getRouteApi();
      }
    });
  }

  Request getRequest(RequestForm requestForm) {
    Request request = Request();
    request.setId(requestForm.getId());
    request.setCode(requestForm.getOutletCode());
    request.setOutletName(requestForm.getOutletName());
    request.setOutletAddress(requestForm.getOutletAddress());
    request.setOwnerName(requestForm.getOwnerName());
    request.setOwnerFatherName(requestForm.getOwnerFatherName());
    request.setOwnerCNIC(requestForm.getOwnerCNIC());
    request.setVpoClassificationId(requestForm.getVpoClassificationId());
    request.setPhoneNumber(requestForm.getPhoneNumber());
    request.setContactPerson(requestForm.getContactPerson());
    request.setContactPersonPhone(requestForm.getContactPersonPhone());
    request
        .setContactPerson1CellNumber(requestForm.getContactPerson1CellNumber());
    request.setYtdSalesVolume(requestForm.getYtdSalesVolume());
    request.setAgreedYTDSalesVolume(requestForm.getAgreedYTDSalesVolume());
    request.setVpoClassification(requestForm.getVpoClassification());
    request.setCompetitorExist(requestForm.getCompetitorExist());
    request.setRefferedBy(requestForm.getRefferedBy());
    request.setComments(requestForm.getComments());
    request.setLatitude(requestForm.getLatitude());
    request.setLongitude(requestForm.getLongitude());
    request.setOutletImagePath(requestForm.getOutletImagePath());
    request.setCnicFrontImageFilePath(requestForm.getCnicFrontImageFilePath());
    request.setCnicBackImageFilePath(requestForm.getCnicBackImageFilePath());
    request.setESignatureFilePath(requestForm.getESignatureFilePath());
    request.setContactPerson1(requestForm.getContactPerson1());
    request
        .setContactPerson1CellNumber(requestForm.getContactPerson1CellNumber());
    request.setContactPerson2(requestForm.getContactPerson2());
    request
        .setContactPerson2CellNumber(requestForm.getContactPerson2CellNumber());
    request.setContactPerson3(requestForm.getContactPerson3());
    request
        .setContactPerson3CellNumber(requestForm.getContactPerson3CellNumber());
    request.setPjPs(requestForm.getPjPs());
    request.setIsPJPFixed(requestForm.getIsPJPFixed());
    request.setLocation(requestForm.getLocation());
    request.setWorkflowState(requestForm.getWorkflowState());
    request.setWorkflowStateId(requestForm.getWorkflowStateId());
    request.setCompetitorExist(requestForm.getCompetitorExist());
    request.setLocation(requestForm.getLocation());
    request.setRadius(requestForm.getRadius());
    request.setRouteId(requestForm.getRouteId());
    request.setRouteName(requestForm.getRouteName());
    request.setTradeClassificationId(requestForm.getTradeClassificationId());
    request.setOutletClassificationId(requestForm.getOutletClassificationId());
    request.setChannelId(requestForm.getChannelId());
    request.setCityId(requestForm.getCityId());
    request.setRequesTypeId(requestForm.getRequesTypeId());
    request.setOutletId(requestForm.getOutletId());
    request.setOutletTypeId(requestForm.getOutletTypeId());
    request.setDistributionId(requestForm.getDistributionId());
    request.setDistributionName(requestForm.getDistributionName());
    request.setOrganizationId(requestForm.getOrganizationId());
    request.setIssuanceCategoryId(requestForm.getIssuanceCategoryId());
    request.setMarketeTypeId(requestForm.getMarketeTypeId());
    request.setReason(requestForm.getReason());
    request.setMdeSignature(requestForm.getMdeSignature());

    return request;
  }

  void apiNewOutletReq(Request request, RequestForm requestForm) {
    NetworkManager.getInstance().isConnectedToInternet().then((connected) {
      if (connected) {
        controller.setLoading(false);
        controller.newOutletRequest(request, requestForm);
      } else {
        controller.setLoading(false);
        showToastMessage(Constants.NETWORK_ERROR);
      }
    });
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

  void setObservers() {
    debounce(controller.getMessage(), (event) {
      showToastMessage(event.peekContent());
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getHashMapLiveData(), (objectHashMap) {
      RequestForm? requestForm = objectHashMap["requestForm"] as RequestForm?;
//            Request requestBody = new Request();
      bool success = bool.parse(objectHashMap["success"]);
      String errorMessage = objectHashMap["errorMessage"].toString();

      if (success) {
        if (requestForm != null) {
          controller.deleteReq(requestForm);
        }
      } else {
        showToastMessage(errorMessage);
        counterMultipleApi++;
        //  progressDialog.dismiss();
        multipleSyncWithCallBack(counterMultipleApi, clickCode);
      }
    },
        time: const Duration(milliseconds: 200));

  }

  void multipleSyncWithCallBack(int incrementedId, int status) {
    if (status == Constants.SYNC_OUTLET_REQ || status == Constants.NEW_OUTLET_REQUEST) {
      if (counterMultipleApi == requestFormsList.length) {
        controller.setLoading(false);
        counterMultipleApi = 0;
        getRouteApi();
      } else {
        RequestForm requestForm = requestFormsList[incrementedId];
        Request request = getRequest(requestForm);
        if (request.getRequesTypeId() == Constants.NEW_OUTLET_REQUEST_TYPE_ID) {
          if (status == Constants.NEW_OUTLET_REQUEST) {
            int total = 0;
            int readyToPost = 0;
            int inComplete = 0;
            for (RequestForm requestForm1 in requestFormsList) {
              if (requestForm1.getRequesTypeId() == 4) {
                if (requestForm1.getRequestStatus() == 1) {
                  if (controller.validateRequestForm(requestForm1)=="") {
                    readyToPost++;
                  }
                }
              }
              total++;
            }
            inComplete = total - readyToPost;
            if (readyToPost > 0) {
              for (RequestForm requestForm2 in requestFormsList) {
                if (requestForm2.getRequesTypeId() == 4) {
                  String message = controller.validateRequestForm(requestForm2);
                  if (requestForm2.getRequestStatus() == 1) {
                    apiNewOutletReq(request, requestForm2);
                  } else {
                    controller.setLoading(false);
                  }
                }
              }
            } else {
              if (total == 0) {
                controller.setLoading(false);
                showToastMessage("There is nothing to Sync");
              } else {
                controller.setLoading(false);
                showToastMessage("There ${((total > 1) ? "are" : "is")} $total incomplete items(s)");
              }
            }
          } else if (clickCode == Constants.SYNC_OUTLET_REQ) {
            getRouteApi();
          }
        }
      }
    }
  }
}
