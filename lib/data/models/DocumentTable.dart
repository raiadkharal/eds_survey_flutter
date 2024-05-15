import 'dart:convert';

import 'package:eds_survey/utils/Utils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'PJPModel.dart';

part 'DocumentTable.g.dart';

@JsonSerializable()
class DocumentTable {
  @JsonKey(name: 'document_id')
  int? documentId;

  int? id;
  int? code;
  int? workflowId;
  int? outletId;
  String? outletCode;
  String? outletName;
  String? outletStatus;
  String? outletAddress;
  String? contactPerson;
  String? contactPersonPhone;
  String? routeName;
  int? routeId;
  int? destinationOutletId;
  int? organizationId;
  int? distributionId;
  int? actionId;
  int? requestedById;
  bool? competitorExist;
  String? refferedBy;
  String? requestDate;
  String? createdDate;
  int? ytdSalesVolume;
  int? agreedYTDSalesVolume;
  String? cnicFrontImageFilePath;
  String? cnicBackImageFilePath;
  String? outletImage;
  String? outletImagePath;
  String? eSignatureFilePath;
  String? mdeSignature;
  String? distributionName;
  double? longitude;
  double? latitude;
  String? comments;
  int? assignedToId;
  String? assignedTo;
  String? success;
  String? errorMessage;
  int? errorCode;
  int? requestedBy;
  int? requesTypeId;
  int? retrievalTypeId;
  String? vpoClassification;
  int? vpoClassificationId;
  String? location;
  String? ownerName;
  String? ownerFatherName;
  String? ownerCNIC;
  String? phoneNumber;
  int? cityId;
  int? outletTypeId;
  int? marketeTypeId;
  int? tradeClassificationId;
  int? outletClassificationId;
  int? channelId;
  bool? isCompetitorExist;
  double? radius;
  String? contactPerson1;
  String? contactPerson1CellNumber;
  String? contactPerson2;
  String? contactPerson2CellNumber;
  String? contactPerson3;
  String? contactPerson3CellNumber;
  List<PJPModel>? pjPs;
  bool? isPJPFixed;
  int? colorCode;
  int? issuanceCategoryId;
  int? workflowStateId;
  String? workflowState;
  String? unit;
  String? reason;
  int? reasonId;
  String? issuanceCategory;
  int? requestStatus;

  DocumentTable();

  factory DocumentTable.fromJson(Map<String, dynamic> json) =>
      _$DocumentTableFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentTableToJson(this);

  // Setters and Getters

  void setFormId(int? value) {
    documentId = value;
  }

  int? getFormId() {
    return documentId;
  }

  void setId(int? value) {
    id = value;
  }

  int? getId() {
    return id;
  }

  void setCode(int? value) {
    code = value;
  }

  int? getCode() {
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

  void setOutletCode(String? value) {
    outletCode = value;
  }

  String? getOutletCode() {
    return outletCode;
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
    outletImage = value;
  }

  String? getOutletImage() {
    return outletImage;
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
    latitude = value;
  }

  double? getLatitude() {
    return latitude;
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

  void setUnit(String? value) {
    unit = value;
  }

  String? getUnit() {
    return unit;
  }

  void setReason(String? value) {
    reason = value;
  }

  String? getReason() {
    return reason;
  }

  void setReasonId(int? value) {
    reasonId = value;
  }

  int? getReasonId() {
    return reasonId;
  }

  void setIssuanceCategory(String? value) {
    issuanceCategory = value;
  }

  String? getIssuanceCategory() {
    return issuanceCategory;
  }

  void setVpoClassificationId(int? value) {
    vpoClassificationId = value;
  }

  int? getVpoClassificationId() {
    return vpoClassificationId;
  }

  void setRequestStatus(int? value) {
    requestStatus = value;
  }

  int? getRequestStatus() {
    return requestStatus;
  }
}

