// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DocumentTable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentTable _$DocumentTableFromJson(Map<String, dynamic> json) {
  return DocumentTable()
    ..documentId = json['document_id'] as int?
    ..id = json['id'] as int?
    ..code = json['code'] as int?
    ..workflowId = json['workflowId'] as int?
    ..outletId = json['outletId'] as int?
    ..outletCode = json['outletCode'] as String?
    ..outletName = json['outletName'] as String?
    ..outletStatus = json['outletStatus'] as String?
    ..outletAddress = json['outletAddress'] as String?
    ..contactPerson = json['contactPerson'] as String?
    ..contactPersonPhone = json['contactPersonPhone'] as String?
    ..routeName = json['routeName'] as String?
    ..routeId = json['routeId'] as int?
    ..destinationOutletId = json['destinationOutletId'] as int?
    ..organizationId = json['organizationId'] as int?
    ..distributionId = json['distributionId'] as int?
    ..actionId = json['actionId'] as int?
    ..requestedById = json['requestedById'] as int?
    ..competitorExist = boolFromInt(json['competitorExist'] as int?)
    ..refferedBy = json['refferedBy'] as String?
    ..requestDate = json['requestDate'] as String?
    ..createdDate = json['createdDate'] as String?
    ..ytdSalesVolume = json['ytdSalesVolume'] as int?
    ..agreedYTDSalesVolume = json['agreedYTDSalesVolume'] as int?
    ..cnicFrontImageFilePath = json['cnicFrontImageFilePath'] as String?
    ..cnicBackImageFilePath = json['cnicBackImageFilePath'] as String?
    ..outletImage = json['outletImage'] as String?
    ..outletImagePath = json['outletImagePath'] as String?
    ..eSignatureFilePath = json['eSignatureFilePath'] as String?
    ..mdeSignature = json['mdeSignature'] as String?
    ..distributionName = json['distributionName'] as String?
    ..longitude = (json['longitude'] as num?)?.toDouble()
    ..latitude = (json['latitude'] as num?)?.toDouble()
    ..comments = json['comments'] as String?
    ..assignedToId = json['assignedToId'] as int?
    ..assignedTo = json['assignedTo'] as String?
    ..success = json['success'] as String?
    ..errorMessage = json['errorMessage'] as String?
    ..errorCode = json['errorCode'] as int?
    ..requestedBy = json['requestedBy'] as int?
    ..requesTypeId = json['requesTypeId'] as int?
    ..retrievalTypeId = json['retrievalTypeId'] as int?
    ..vpoClassification = json['vpoClassification'] as String?
    ..vpoClassificationId = json['vpoClassificationId'] as int?
    ..location = json['location'] as String?
    ..ownerName = json['ownerName'] as String?
    ..ownerFatherName = json['ownerFatherName'] as String?
    ..ownerCNIC = json['ownerCNIC'] as String?
    ..phoneNumber = json['phoneNumber'] as String?
    ..cityId = json['cityId'] as int?
    ..outletTypeId = json['outletTypeId'] as int?
    ..marketeTypeId = json['marketeTypeId'] as int?
    ..tradeClassificationId = json['tradeClassificationId'] as int?
    ..outletClassificationId = json['outletClassificationId'] as int?
    ..channelId = json['channelId'] as int?
    ..isCompetitorExist = boolFromInt(json['isCompetitorExist'] as int?)
    ..radius = (json['radius'] as num?)?.toDouble()
    ..contactPerson1 = json['contactPerson1'] as String?
    ..contactPerson1CellNumber = json['contactPerson1CellNumber'] as String?
    ..contactPerson2 = json['contactPerson2'] as String?
    ..contactPerson2CellNumber = json['contactPerson2CellNumber'] as String?
    ..contactPerson3 = json['contactPerson3'] as String?
    ..contactPerson3CellNumber = json['contactPerson3CellNumber'] as String?
    ..pjPs = (jsonDecode(json['pjPs']) as List<dynamic>?)
        ?.map((e) => PJPModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..isPJPFixed = json['isPJPFixed'] as bool?
    ..colorCode = json['colorCode'] as int?
    ..issuanceCategoryId = json['issuanceCategoryId'] as int?
    ..workflowStateId = json['workflowStateId'] as int?
    ..workflowState = json['workflowState'] as String?
    ..unit = json['unit'] as String?
    ..reason = json['reason'] as String?
    ..reasonId = json['reasonId'] as int?
    ..issuanceCategory = json['issuanceCategory'] as String?
    ..requestStatus = json['requestStatus'] as int?;
}

Map<String, dynamic> _$DocumentTableToJson(DocumentTable instance) =>
    <String, dynamic>{
      'document_id': instance.documentId,
      'id': instance.id,
      'code': instance.code,
      'workflowId': instance.workflowId,
      'outletId': instance.outletId,
      'outletCode': instance.outletCode,
      'outletName': instance.outletName,
      'outletStatus': instance.outletStatus,
      'outletAddress': instance.outletAddress,
      'contactPerson': instance.contactPerson,
      'contactPersonPhone': instance.contactPersonPhone,
      'routeName': instance.routeName,
      'routeId': instance.routeId,
      'destinationOutletId': instance.destinationOutletId,
      'organizationId': instance.organizationId,
      'distributionId': instance.distributionId,
      'actionId': instance.actionId,
      'requestedById': instance.requestedById,
      'competitorExist': boolToInt(instance.competitorExist),
      'refferedBy': instance.refferedBy,
      'requestDate': instance.requestDate,
      'createdDate': instance.createdDate,
      'ytdSalesVolume': instance.ytdSalesVolume,
      'agreedYTDSalesVolume': instance.agreedYTDSalesVolume,
      'cnicFrontImageFilePath': instance.cnicFrontImageFilePath,
      'cnicBackImageFilePath': instance.cnicBackImageFilePath,
      'outletImage': instance.outletImage,
      'outletImagePath': instance.outletImagePath,
      'eSignatureFilePath': instance.eSignatureFilePath,
      'mdeSignature': instance.mdeSignature,
      'distributionName': instance.distributionName,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'comments': instance.comments,
      'assignedToId': instance.assignedToId,
      'assignedTo': instance.assignedTo,
      'success': instance.success,
      'errorMessage': instance.errorMessage,
      'errorCode': instance.errorCode,
      'requestedBy': instance.requestedBy,
      'requesTypeId': instance.requesTypeId,
      'retrievalTypeId': instance.retrievalTypeId,
      'vpoClassification': instance.vpoClassification,
      'vpoClassificationId': instance.vpoClassificationId,
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
      'isCompetitorExist': boolToInt(instance.isCompetitorExist),
      'radius': instance.radius,
      'contactPerson1': instance.contactPerson1,
      'contactPerson1CellNumber': instance.contactPerson1CellNumber,
      'contactPerson2': instance.contactPerson2,
      'contactPerson2CellNumber': instance.contactPerson2CellNumber,
      'contactPerson3': instance.contactPerson3,
      'contactPerson3CellNumber': instance.contactPerson3CellNumber,
      'pjPs': jsonEncode(instance.pjPs),
      'isPJPFixed': instance.isPJPFixed,
      'colorCode': instance.colorCode,
      'issuanceCategoryId': instance.issuanceCategoryId,
      'workflowStateId': instance.workflowStateId,
      'workflowState': instance.workflowState,
      'unit': instance.unit,
      'reason': instance.reason,
      'reasonId': instance.reasonId,
      'issuanceCategory': instance.issuanceCategory,
      'requestStatus': instance.requestStatus,
    };
