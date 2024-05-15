import 'package:json_annotation/json_annotation.dart';

import 'PJPModel.dart';

part 'Request.g.dart';

@JsonSerializable()
class Request {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'workflowId')
  int? workflowId;
  @JsonKey(name: 'outletId')
  int? outletId;
  @JsonKey(name: 'outletName')
  String? outletName;
  @JsonKey(name: 'outletStatus')
  dynamic outletStatus;
  @JsonKey(name: 'outletAddress')
  String? outletAddress;
  @JsonKey(name: 'contactPerson')
  dynamic contactPerson;
  @JsonKey(name: 'contactPersonPhone')
  String? contactPersonPhone;
  @JsonKey(name: 'routeName')
  dynamic routeName;
  @JsonKey(name: 'routeId')
  int? routeId;
  @JsonKey(name: 'organizationId')
  int? organizationId;
  @JsonKey(name: 'distributionId')
  int? distributionId;
  @JsonKey(name: 'actionId')
  int? actionId;
  @JsonKey(name: 'requestedById')
  dynamic requestedById;
  @JsonKey(name: 'competitorExist')
  bool? competitorExist;
  @JsonKey(name: 'refferedBy')
  String? refferedBy;
  int? retrievalTypeId;
  @JsonKey(name: 'vpoClassificationId')
  int? vpoClassificationId;
  @JsonKey(name: 'donotValidatePhoneNumbers')
  bool? donotValidatePhoneNumbers;
  @JsonKey(name: 'ytdSalesVolume')
  int? ytdSalesVolume;
  @JsonKey(name: 'agreedYTDSalesVolume')
  int? agreedYTDSalesVolume;
  @JsonKey(name: 'cnicFrontImageFilePath')
  String? cnicFrontImageFilePath;
  @JsonKey(name: 'cnicBackImageFilePath')
  String? cnicBackImageFilePath;
  @JsonKey(name: 'outletImagePath')
  String? outletImagePath;
  @JsonKey(name: 'eSignatureFilePath')
  String? eSignatureFilePath;
  @JsonKey(name: 'mdeSignature')
  String? mdeSignature;
  @JsonKey(name: 'distributionName')
  String? distributionName;
  @JsonKey(name: 'longitude')
  double? longitude;
  @JsonKey(name: 'lattitude')
  double? lattitude;
  @JsonKey(name: 'comments')
  String? comments;
  @JsonKey(name: 'assignedToId')
  int? assignedToId;
  @JsonKey(name: 'assignedTo')
  dynamic assignedTo;
  @JsonKey(name: 'success')
  String? success;
  @JsonKey(name: 'errorMessage')
  dynamic errorMessage;
  @JsonKey(name: 'errorCode')
  int? errorCode;
  @JsonKey(name: 'requestedBy')
  dynamic requestedBy;
  @JsonKey(name: 'requesTypeId')
  int? requesTypeId;
  @JsonKey(name: 'vpoClassification')
  String? vpoClassification;
  @JsonKey(name: 'location')
  dynamic location;
  @JsonKey(name: 'ownerName')
  String? ownerName;
  @JsonKey(name: 'ownerFatherName')
  String? ownerFatherName;
  @JsonKey(name: 'ownerCNIC')
  String? ownerCNIC;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'cityId')
  int? cityId;
  @JsonKey(name: 'outletTypeId')
  int? outletTypeId;
  @JsonKey(name: 'marketeTypeId')
  int? marketeTypeId;
  @JsonKey(name: 'tradeClassificationId')
  int? tradeClassificationId;
  @JsonKey(name: 'outletClassificationId')
  int? outletClassificationId;
  @JsonKey(name: 'channelId')
  int? channelId;
  @JsonKey(name: 'isCompetitorExist')
  bool? isCompetitorExist;
  @JsonKey(name: 'radius')
  double? radius;
  @JsonKey(name: 'contactPerson1')
  String? contactPerson1;
  @JsonKey(name: 'contactPerson1CellNumber')
  String? contactPerson1CellNumber;
  @JsonKey(name: 'contactPerson2')
  String? contactPerson2;
  @JsonKey(name: 'contactPerson2CellNumber')
  String? contactPerson2CellNumber;
  @JsonKey(name: 'contactPerson3')
  String? contactPerson3;
  @JsonKey(name: 'contactPerson3CellNumber')
  String? contactPerson3CellNumber;
  @JsonKey(name: 'pjPs')
  List<PJPModel>? pjPs;
  @JsonKey(name: 'isPJPFixed')
  bool? isPJPFixed;
  @JsonKey(name: 'colorCode')
  dynamic colorCode;
  @JsonKey(name: 'issuanceCategoryId')
  int? issuanceCategoryId;
  @JsonKey(name: 'workflowStateId')
  int? workflowStateId;
  @JsonKey(name: 'workflowState')
  String? workflowState;
  @JsonKey(name: 'reason')
  String? reason;
  @JsonKey(name: 'requestDate')
  String? requestDate;
  @JsonKey(name: 'createdDate')
  String? createdDate;
  @JsonKey(name: 'transferReasonId')
  int? transferReasonId;

  Request({
    this.id,
    this.code,
    this.workflowId,
    this.outletId,
    this.outletName,
    this.outletStatus,
    this.outletAddress,
    this.contactPerson,
    this.contactPersonPhone,
    this.routeName,
    this.routeId,
    this.organizationId,
    this.distributionId,
    this.actionId,
    this.requestedById,
    this.competitorExist,
    this.refferedBy,
    this.retrievalTypeId,
    this.vpoClassificationId,
    this.donotValidatePhoneNumbers,
    this.ytdSalesVolume,
    this.agreedYTDSalesVolume,
    this.cnicFrontImageFilePath,
    this.cnicBackImageFilePath,
    this.outletImagePath,
    this.eSignatureFilePath,
    this.mdeSignature,
    this.distributionName,
    this.longitude,
    this.lattitude,
    this.comments,
    this.assignedToId,
    this.assignedTo,
    this.success,
    this.errorMessage,
    this.errorCode,
    this.requestedBy,
    this.requesTypeId,
    this.vpoClassification,
    this.location,
    this.ownerName,
    this.ownerFatherName,
    this.ownerCNIC,
    this.phoneNumber,
    this.cityId,
    this.outletTypeId,
    this.marketeTypeId,
    this.tradeClassificationId,
    this.outletClassificationId,
    this.channelId,
    this.isCompetitorExist,
    this.radius,
    this.contactPerson1,
    this.contactPerson1CellNumber,
    this.contactPerson2,
    this.contactPerson2CellNumber,
    this.contactPerson3,
    this.contactPerson3CellNumber,
    this.pjPs,
    this.isPJPFixed,
    this.colorCode,
    this.issuanceCategoryId,
    this.workflowStateId,
    this.workflowState,
    this.reason,
    this.requestDate,
    this.createdDate,
    this.transferReasonId,
  });

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  void setId(int? value) {
    id = value;
  }

  int? getId() {
    return id;
  }

  void setCode(String? value) {
    code = value;
  }

  String? getCode() {
    return code;
  }

  void setWorkflowId(int? value) {
    workflowId = value;
  }

  int? getWorkflowId() {
    return workflowId;
  }

  void setOutletId(int? value) {
    outletId = value;
  }

  int? getOutletId() {
    return outletId;
  }

  void setOutletName(String? value) {
    outletName = value;
  }

  String? getOutletName() {
    return outletName;
  }

  void setOutletStatus(String? value) {
    outletStatus = value;
  }

  String? getOutletStatus() {
    return outletStatus;
  }

  void setOutletAddress(String? value) {
    outletAddress = value;
  }

  String? getOutletAddress() {
    return outletAddress;
  }

  void setContactPerson(String? value) {
    contactPerson = value;
  }

  String? getContactPerson() {
    return contactPerson;
  }

  void setContactPersonPhone(String? value) {
    contactPersonPhone = value;
  }

  String? getContactPersonPhone() {
    return contactPersonPhone;
  }

  void setRouteName(String? value) {
    routeName = value;
  }

  String? getRouteName() {
    return routeName;
  }

  void setRouteId(int? value) {
    routeId = value;
  }

  int? getRouteId() {
    return routeId;
  }

  void setOrganizationId(int? value) {
    organizationId = value;
  }

  int? getOrganizationId() {
    return organizationId;
  }

  void setDistributionId(int? value) {
    distributionId = value;
  }

  int? getDistributionId() {
    return distributionId;
  }

  void setActionId(int? value) {
    actionId = value;
  }

  int? getActionId() {
    return actionId;
  }

  void setRequestedById(int? value) {
    requestedById = value;
  }

  int? getRequestedById() {
    return requestedById;
  }

  void setCompetitorExist(bool? value) {
    competitorExist = value;
  }

  bool? getCompetitorExist() {
    return competitorExist;
  }

  void setRefferedBy(String? value) {
    refferedBy = value;
  }

  String? getRefferedBy() {
    return refferedBy;
  }

  void setRequestDate(String? value) {
    requestDate = value;
  }

  String? getRequestDate() {
    return requestDate;
  }

  void setCreatedDate(String? value) {
    createdDate = value;
  }

  String? getCreatedDate() {
    return createdDate;
  }

  void setYtdSalesVolume(int? value) {
    ytdSalesVolume = value;
  }

  int? getYtdSalesVolume() {
    return ytdSalesVolume;
  }

  void setAgreedYTDSalesVolume(int? value) {
    agreedYTDSalesVolume = value;
  }

  int? getAgreedYTDSalesVolume() {
    return agreedYTDSalesVolume;
  }

  void setCnicFrontImageFilePath(String? value) {
    cnicFrontImageFilePath = value;
  }

  String? getCnicFrontImageFilePath() {
    return cnicFrontImageFilePath;
  }

  void setCnicBackImageFilePath(String? value) {
    cnicBackImageFilePath = value;
  }

  String? getCnicBackImageFilePath() {
    return cnicBackImageFilePath;
  }

  void setOutletImage(String? value) {
    outletImagePath = value;
  }

  String? getOutletImage() {
    return outletImagePath;
  }

  void setOutletImagePath(String? value) {
    outletImagePath = value;
  }

  String? getOutletImagePath() {
    return outletImagePath;
  }

  void setESignatureFilePath(String? value) {
    eSignatureFilePath = value;
  }

  String? getESignatureFilePath() {
    return eSignatureFilePath;
  }

  void setMdeSignature(String? value) {
    mdeSignature = value;
  }

  String? getMdeSignature() {
    return mdeSignature;
  }

  void setDistributionName(String? value) {
    distributionName = value;
  }

  String? getDistributionName() {
    return distributionName;
  }

  void setLongitude(double? value) {
    longitude = value;
  }

  double? getLongitude() {
    return longitude;
  }

  void setLatitude(double? value) {
    lattitude = value;
  }

  double? getLatitude() {
    return lattitude;
  }

  void setComments(String? value) {
    comments = value;
  }

  String? getComments() {
    return comments;
  }

  void setAssignedToId(int? value) {
    assignedToId = value;
  }

  int? getAssignedToId() {
    return assignedToId;
  }

  void setAssignedTo(String? value) {
    assignedTo = value;
  }

  String? getAssignedTo() {
    return assignedTo;
  }

  void setSuccess(String? value) {
    success = value;
  }

  String? getSuccess() {
    return success;
  }

  void setErrorMessage(String? value) {
    errorMessage = value;
  }

  String? getErrorMessage() {
    return errorMessage;
  }

  void setErrorCode(int? value) {
    errorCode = value;
  }

  int? getErrorCode() {
    return errorCode;
  }

  void setRequestedBy(int? value) {
    requestedBy = value;
  }

  int? getRequestedBy() {
    return requestedBy;
  }

  void setRequesTypeId(int? value) {
    requesTypeId = value;
  }

  int? getRequesTypeId() {
    return requesTypeId;
  }

  void setVpoClassification(String? value) {
    vpoClassification = value;
  }

  String? getVpoClassification() {
    return vpoClassification;
  }

  void setLocation(String? value) {
    location = value;
  }

  String? getLocation() {
    return location;
  }

  void setOwnerName(String? value) {
    ownerName = value;
  }

  String? getOwnerName() {
    return ownerName;
  }

  void setOwnerFatherName(String? value) {
    ownerFatherName = value;
  }

  String? getOwnerFatherName() {
    return ownerFatherName;
  }

  void setOwnerCNIC(String? value) {
    ownerCNIC = value;
  }

  String? getOwnerCNIC() {
    return ownerCNIC;
  }

  void setPhoneNumber(String? value) {
    phoneNumber = value;
  }

  String? getPhoneNumber() {
    return phoneNumber;
  }

  void setCityId(int? value) {
    cityId = value;
  }

  int? getCityId() {
    return cityId;
  }

  void setOutletTypeId(int? value) {
    outletTypeId = value;
  }

  int? getOutletTypeId() {
    return outletTypeId;
  }

  void setMarketeTypeId(int? value) {
    marketeTypeId = value;
  }

  int? getMarketeTypeId() {
    return marketeTypeId;
  }

  void setTradeClassificationId(int? value) {
    tradeClassificationId = value;
  }

  int? getTradeClassificationId() {
    return tradeClassificationId;
  }

  void setOutletClassificationId(int? value) {
    outletClassificationId = value;
  }

  int? getOutletClassificationId() {
    return outletClassificationId;
  }

  void setChannelId(int? value) {
    channelId = value;
  }

  int? getChannelId() {
    return channelId;
  }

  void setIsCompetitorExist(bool? value) {
    isCompetitorExist = value;
  }

  bool? getIsCompetitorExist() {
    return isCompetitorExist;
  }

  void setRadius(double? value) {
    radius = value;
  }

  double? getRadius() {
    return radius;
  }

  void setContactPerson1(String? value) {
    contactPerson1 = value;
  }

  String? getContactPerson1() {
    return contactPerson1;
  }

  void setContactPerson1CellNumber(String? value) {
    contactPerson1CellNumber = value;
  }

  String? getContactPerson1CellNumber() {
    return contactPerson1CellNumber;
  }

  void setContactPerson2(String? value) {
    contactPerson2 = value;
  }

  String? getContactPerson2() {
    return contactPerson2;
  }

  void setContactPerson2CellNumber(String? value) {
    contactPerson2CellNumber = value;
  }

  String? getContactPerson2CellNumber() {
    return contactPerson2CellNumber;
  }

  void setContactPerson3(String? value) {
    contactPerson3 = value;
  }

  String? getContactPerson3() {
    return contactPerson3;
  }

  void setContactPerson3CellNumber(String? value) {
    contactPerson3CellNumber = value;
  }

  String? getContactPerson3CellNumber() {
    return contactPerson3CellNumber;
  }

  void setPjPs(List<PJPModel>? value) {
    pjPs = value;
  }

  List<PJPModel>? getPjPs() {
    return pjPs;
  }

  void setIsPJPFixed(bool? value) {
    isPJPFixed = value;
  }

  bool? getIsPJPFixed() {
    return isPJPFixed;
  }

  void setColorCode(int? value) {
    colorCode = value;
  }

  int? getColorCode() {
    return colorCode;
  }

  void setIssuanceCategoryId(int? value) {
    issuanceCategoryId = value;
  }

  int? getIssuanceCategoryId() {
    return issuanceCategoryId;
  }

  void setWorkflowStateId(int? value) {
    workflowStateId = value;
  }

  int? getWorkflowStateId() {
    return workflowStateId;
  }

  void setWorkflowState(String? value) {
    workflowState = value;
  }

  String? getWorkflowState() {
    return workflowState;
  }

  void setReason(String? value) {
    reason = value;
  }

  String? getReason() {
    return reason;
  }


  void setVpoClassificationId(int? value) {
    vpoClassificationId = value;
  }

  int? getVpoClassificationId() {
    return vpoClassificationId;
  }

  bool? getDonotValidatePhoneNumbers() {
    return donotValidatePhoneNumbers;
  }

  void setDonotValidatePhoneNumbers(bool? donotValidatePhoneNumbers) {
    this.donotValidatePhoneNumbers = donotValidatePhoneNumbers;
  }
}
