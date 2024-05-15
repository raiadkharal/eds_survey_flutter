// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
  id: json['id'] as int?,
  code: json['code'] as String?,
  workflowId: json['workflowId'] as int?,
  outletId: json['outletId'] as int?,
  outletName: json['outletName'] as String?,
  outletStatus: json['outletStatus'],
  outletAddress: json['outletAddress'] as String?,
  contactPerson: json['contactPerson'],
  contactPersonPhone: json['contactPersonPhone'] as String?,
  routeName: json['routeName'],
  routeId: json['routeId'] as int?,
  organizationId: json['organizationId'] as int?,
  distributionId: json['distributionId'] as int?,
  actionId: json['actionId'] as int?,
  requestedById: json['requestedById'],
  competitorExist: json['competitorExist'] as bool?,
  refferedBy: json['refferedBy'] as String?,
  retrievalTypeId: json['retrievalTypeId'] as int?,
  vpoClassificationId: json['vpoClassificationId'] as int?,
  donotValidatePhoneNumbers: json['donotValidatePhoneNumbers'] as bool?,
  ytdSalesVolume: json['ytdSalesVolume'] as int?,
  agreedYTDSalesVolume: json['agreedYTDSalesVolume'] as int?,
  cnicFrontImageFilePath: json['cnicFrontImageFilePath'] as String?,
  cnicBackImageFilePath: json['cnicBackImageFilePath'] as String?,
  outletImagePath: json['outletImagePath'] as String?,
  eSignatureFilePath: json['eSignatureFilePath'] as String?,
  mdeSignature: json['mdeSignature'] as String?,
  distributionName: json['distributionName'] as String?,
  longitude: (json['longitude'] as num?)?.toDouble(),
  lattitude: (json['lattitude'] as num?)?.toDouble(),
  comments: json['comments'] as String?,
  assignedToId: json['assignedToId'] as int?,
  assignedTo: json['assignedTo'],
  success: json['success'] as String?,
  errorMessage: json['errorMessage'],
  errorCode: json['errorCode'] as int?,
  requestedBy: json['requestedBy'],
  requesTypeId: json['requesTypeId'] as int?,
  vpoClassification: json['vpoClassification'] as String?,
  location: json['location'],
  ownerName: json['ownerName'] as String?,
  ownerFatherName: json['ownerFatherName'] as String?,
  ownerCNIC: json['ownerCNIC'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  cityId: json['cityId'] as int?,
  outletTypeId: json['outletTypeId'] as int?,
  marketeTypeId: json['marketeTypeId'] as int?,
  tradeClassificationId: json['tradeClassificationId'] as int?,
  outletClassificationId: json['outletClassificationId'] as int?,
  channelId: json['channelId'] as int?,
  isCompetitorExist: json['isCompetitorExist'] as bool?,
  radius: (json['radius'] as num?)?.toDouble(),
  contactPerson1: json['contactPerson1'] as String?,
  contactPerson1CellNumber: json['contactPerson1CellNumber'] as String?,
  contactPerson2: json['contactPerson2'] as String?,
  contactPerson2CellNumber: json['contactPerson2CellNumber'] as String?,
  contactPerson3: json['contactPerson3'] as String?,
  contactPerson3CellNumber: json['contactPerson3CellNumber'] as String?,
  pjPs: (json['pjPs'] as List<dynamic>?)
      ?.map((e) => PJPModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  isPJPFixed: json['isPJPFixed'] as bool?,
  colorCode: json['colorCode'],
  issuanceCategoryId: json['issuanceCategoryId'] as int?,
  workflowStateId: json['workflowStateId'] as int?,
  workflowState: json['workflowState'] as String?,
  reason: json['reason'] as String?,
  requestDate: json['requestDate'] as String?,
  createdDate: json['createdDate'] as String?,
  transferReasonId: json['transferReasonId'] as int?,
);

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'workflowId': instance.workflowId,
  'outletId': instance.outletId,
  'outletName': instance.outletName,
  'outletStatus': instance.outletStatus,
  'outletAddress': instance.outletAddress,
  'contactPerson': instance.contactPerson,
  'contactPersonPhone': instance.contactPersonPhone,
  'routeName': instance.routeName,
  'routeId': instance.routeId,
  'organizationId': instance.organizationId,
  'distributionId': instance.distributionId,
  'actionId': instance.actionId,
  'requestedById': instance.requestedById,
  'competitorExist': instance.competitorExist,
  'refferedBy': instance.refferedBy,
  'retrievalTypeId': instance.retrievalTypeId,
  'vpoClassificationId': instance.vpoClassificationId,
  'donotValidatePhoneNumbers': instance.donotValidatePhoneNumbers,
  'ytdSalesVolume': instance.ytdSalesVolume,
  'agreedYTDSalesVolume': instance.agreedYTDSalesVolume,
  'cnicFrontImageFilePath': instance.cnicFrontImageFilePath,
  'cnicBackImageFilePath': instance.cnicBackImageFilePath,
  'outletImagePath': instance.outletImagePath,
  'eSignatureFilePath': instance.eSignatureFilePath,
  'mdeSignature': instance.mdeSignature,
  'distributionName': instance.distributionName,
  'longitude': instance.longitude,
  'lattitude': instance.lattitude,
  'comments': instance.comments,
  'assignedToId': instance.assignedToId,
  'assignedTo': instance.assignedTo,
  'success': instance.success,
  'errorMessage': instance.errorMessage,
  'errorCode': instance.errorCode,
  'requestedBy': instance.requestedBy,
  'requesTypeId': instance.requesTypeId,
  'vpoClassification': instance.vpoClassification,
  'location': instance.location,
  'ownerName': instance.ownerName,
  'ownerFatherName': instance.ownerFatherName,
  'ownerCNIC': instance.ownerCNIC,
  'phoneNumber': instance.phoneNumber,
  'cityId': instance.cityId,
  'outletTypeId': instance.outletTypeId,
  'marketeTypeId': instance.marketeTypeId,
  'tradeClassificationId': instance.tradeClassificationId,
  'outletClassificationId': instance.outletClassificationId,
  'channelId': instance.channelId,
  'isCompetitorExist': instance.isCompetitorExist,
  'radius': instance.radius,
  'contactPerson1': instance.contactPerson1,
  'contactPerson1CellNumber': instance.contactPerson1CellNumber,
  'contactPerson2': instance.contactPerson2,
  'contactPerson2CellNumber': instance.contactPerson2CellNumber,
  'contactPerson3': instance.contactPerson3,
  'contactPerson3CellNumber': instance.contactPerson3CellNumber,
  'pjPs': instance.pjPs?.map((e) => e.toJson()).toList(),
  'isPJPFixed': instance.isPJPFixed,
  'colorCode': instance.colorCode,
  'issuanceCategoryId': instance.issuanceCategoryId,
  'workflowStateId': instance.workflowStateId,
  'workflowState': instance.workflowState,
  'reason': instance.reason,
  'requestDate': instance.requestDate,
  'createdDate': instance.createdDate,
  'transferReasonId': instance.transferReasonId,
};