import 'package:eds_survey/data/db/dao/MainDao.dart';
import 'package:eds_survey/data/db/entities/asset_entity.dart';
import 'package:eds_survey/data/db/entities/asset_missing_reason.dart';
import 'package:eds_survey/data/db/entities/designation.dart';
import 'package:eds_survey/data/db/entities/distribution.dart';
import 'package:eds_survey/data/db/entities/look_up_data.dart';
import 'package:eds_survey/data/db/entities/merchandise.dart';
import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/data/db/entities/pack_mapping.dart';
import 'package:eds_survey/data/db/entities/route.dart';
import 'package:eds_survey/data/db/entities/task.dart';
import 'package:eds_survey/data/db/entities/task_type.dart';
import 'package:eds_survey/data/db/entities/workwith/Psr.dart';
import 'package:eds_survey/data/db/entities/workwith/WDistribution.dart';
import 'package:eds_survey/data/db/entities/workwith/WOutlet.dart';
import 'package:eds_survey/data/db/entities/workwith/WRoute.dart';
import 'package:eds_survey/data/db/entities/workwith/WTask.dart';
import 'package:eds_survey/data/db/entities/workwith/WTaskType.dart';
import 'package:eds_survey/data/db/entities/workwith/WorkWithPost.dart';
import 'package:eds_survey/data/db/entities/workwith/WorkWithPre.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/DocumentTable.dart';
import '../entities/market_visit.dart';
import '../entities/outlet_request/OutletTable.dart';
import '../entities/outlet_request/RequestForm.dart';

class MainDaoImpl extends MainDao {
  final Database _database;

  MainDaoImpl(this._database);

  @override
  Future<List<Designation>> findAllDesignation() async {
    final result = await _database.rawQuery("SELECT * FROM Designation");

    return result.map((row) => Designation.fromJson(row)).toList();
  }

  @override
  Future<List<Distribution>> findAllDistributions() async {
    final result = await _database.rawQuery("SELECT * FROM WDistribution");

    return result.map((row) => Distribution.fromJson(row)).toList();
  }

  @override
  Future<List<MRoute>> findAllRoutes(int distributionId) async {
    final result = await _database.query("Route",
        where: 'distributionId = ?', whereArgs: [distributionId]);

    return result.map((row) => MRoute.fromJson(row)).toList();
  }

  @override
  Future<List<WRoute>> findWRoutes(int distributionId) async {
    final result = await _database.query("WRoute",
        where: 'distributionId = ?', whereArgs: [distributionId]);

    return result.map((row) => WRoute.fromJson(row)).toList();
  }

  @override
  Future<List<MRoute>> getRoutes() async {
    final result = await _database.rawQuery("SELECT * FROM Route");

    return result.map((row) => MRoute.fromJson(row)).toList();
  }

  @override
  Future<void> insertRoutes(List<MRoute> routes) async {
    for (MRoute route in routes) {
      _database.insert("Route", route.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertAssetMissingReason(
      List<AssetMissingReason> missingReasons) async {
    for (AssetMissingReason assetMissingReason in missingReasons) {
      _database.insert("AssetMissingReason", assetMissingReason.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertAssets(List<AssetEntity> outletAssets) async {
    for (AssetEntity assetEntity in outletAssets) {
      _database.insert("AssetEntity", assetEntity.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertDesignations(List<Designation> list) async {
    for (Designation designation in list) {
      _database.insert("Designation", designation.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertDistribution(List<Distribution> distributions) async {
    try {
      for (Distribution distribution in distributions) {
        _database.insert("Distribution", distribution.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Future<void> insertPackages(List<PackMapping> packMappings) async {
    for (PackMapping packMapping in packMappings) {
      _database.insert("PackMapping", packMapping.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertPackagesAndBrands(LookUpData lookUpData) async {
    try {
      _database.insert("LookUpData", lookUpData.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Future<void> insertTaskTypes(List<TaskType> taskTypes) async {
    for (TaskType taskType in taskTypes) {
      _database.insert("TaskType", taskType.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertTasks(List<Task> tasks) async {
    for (Task task in tasks) {
      _database.insert("Task", task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> deleteAllMarketSurveys() async {
    _database.delete("MarketVisit");
  }

  @override
  Future<void> deleteAllMerchandise() async {
    _database.delete("Merchandise");
  }

  @override
  Future<void> deleteAllPostWorkWith() async {
    _database.delete("WorkWithPost");
  }

  @override
  Future<void> deleteAllPreWorkWith() async {
    _database.delete("WorkWithPre");
  }

  @override
  Future<void> deletePackagesAndBrands() async {
    _database.delete("LookUpData");
  }

  @override
  Future<void> deleteAllAsset() async {
    _database.delete("AssetEntity");
  }

  @override
  Future<void> deleteAllAssetReason() async {
    _database.delete("AssetMissingReason");
  }

  @override
  Future<void> deleteAllDesignation() async {
    _database.delete("Designation");
  }

  @override
  Future<void> deleteAllDistribution() async {
    _database.delete("WDistribution");
  }

  @override
  Future<void> deleteAllOutlets() async {
    _database.delete("Outlet");
  }

  @override
  Future<void> deleteAllPackMapping() async {
    _database.delete("PackMapping");
  }

  @override
  Future<void> deleteAllRoutes() async {
    _database.delete("Route");
  }

  @override
  Future<void> deleteAllTask() async {
    _database.delete("Task");
  }

  @override
  Future<void> deleteAllTaskType() async {
    _database.delete("TaskType");
  }

  @override
  Future<void> deleteMarketVisiDistribution() async {
    _database.delete("Distribution");
  }

  @override
  Future<void> deleteAllPsr() async {
    _database.delete("Psr");
  }

  @override
  Future<void> deleteAllWWDistribution() async {
    _database.delete("WDistribution");
  }

  @override
  Future<void> deleteAllWWOutlets() async {
    _database.delete("WOutlet");
  }

  @override
  Future<void> deleteAllWWRoutes() async {
    _database.delete("WRoute");
  }

  @override
  Future<void> deleteAllWWTask() async {
    _database.delete("WTask");
  }

  @override
  Future<void> deleteAllWWTaskType() async {
    _database.delete("WTaskType");
  }

  @override
  Future<void> insertWWRoutes(List<WRoute> routes) async {
    for (WRoute route in routes) {
      _database.insert("WRoute", route.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertPsr(List<Psr> psrs) async {
    for (Psr psr in psrs) {
      _database.insert("Psr", psr.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertWWDistribution(List<WDistribution> distributions) async {
    for (WDistribution distribution in distributions) {
      _database.insert("WDistribution", distribution.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertWWOutlets(List<WOutlet> outlets) async {
    for (WOutlet outlet in outlets) {
      _database.insert("WOutlet", outlet.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertWWTaskTypes(List<WTaskType> taskTypes) async {
    for (WTaskType taskType in taskTypes) {
      _database.insert("WTaskType", taskType.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertWWTasks(List<WTask> tasks) async {
    for (WTask task in tasks) {
      _database.insert("WTask", task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<Distribution>> findMarketVisitDistributions() async {
    final result = await _database.rawQuery("SELECT * FROM Distribution");

    return result.map((json) => Distribution.fromJson(json)).toList();
  }

  @override
  Future<List<WDistribution>> findWorkWithDistributions() async {
    final result = await _database.rawQuery("SELECT * FROM WDistribution");

    return result.map((json) => WDistribution.fromJson(json)).toList();
  }

  @override
  Future<int> marketVisitOutlets(int routeId) async {
    final List<Map<String, dynamic>> result = await _database
        .rawQuery('SELECT COUNT(*) FROM Outlet WHERE routeId = ?', [routeId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
  Future<void> insertOutlets(List<Outlet>? outlets) async {
    if (outlets != null) {
      for (Outlet outlet in outlets) {
        _database.insert("Outlet", outlet.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<List<Outlet>> findAllOutletsForRoute(
      int routeId, int distributionId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM Outlet WHERE routeId = ? AND distributionId= ?",
        [routeId, distributionId]);

    return result.map((json) => Outlet.fromJson(json)).toList();
  }

  @override
  Future<List<WOutlet>> findWOutletsForRoute(int routeId) async {
    final result = await _database
        .rawQuery("SELECT * FROM WOutlet WHERE routeId = ?", [routeId]);

    return result.map((json) => WOutlet.fromJson(json)).toList();
  }

  @override
  Future<Outlet> findOutletById(int selectedOutletId) async {
    final List<Map<String, dynamic>> results = await _database.query(
      'Outlet',
      where: 'outletId = ?',
      whereArgs: [selectedOutletId],
    );

    if (results.isNotEmpty) {
      // Convert the first result to an Outlet object and return it
      return Outlet.fromJson(results.first);
    } else {
      // If no result found, you may throw an exception or return null based on your preference
      throw Exception('Outlet not found for id: $selectedOutletId');
      // Alternatively, you could return null if no outlet is found
      // return null;
    }
  }

  @override
  Future<WOutlet> findWOutletById(int selectedOutletId) async {
    final List<Map<String, dynamic>> results = await _database.query(
      'WOutlet',
      where: 'outletId = ?',
      whereArgs: [selectedOutletId],
    );

    if (results.isNotEmpty) {
      // Convert the first result to an Outlet object and return it
      return WOutlet.fromJson(results.first);
    } else {
      // If no result found, you may throw an exception or return null based on your preference
      throw Exception('Outlet not found for id: $selectedOutletId');
      // Alternatively, you could return null if no outlet is found
      // return null;
    }
  }

  @override
  Future<Merchandise> findMerchandiseByOutletId(int outletId) async {
    final List<Map<String, dynamic>> results = await _database.query(
      'Merchandise',
      where: 'outletId = ?',
      whereArgs: [outletId],
    );

    if (results.isNotEmpty) {
      // Convert the first result to an Outlet object and return it
      return Merchandise.fromJson(results.first);
    } else {
      // If no result found, you may throw an exception or return null based on your preference
      throw Exception('Outlet not found for id: $outletId');
      // Alternatively, you could return null if no outlet is found
      // return null;
    }
  }

  @override
  Future<WorkWithPost> findWorkWithByOutletId(int outletId) async {
    final List<Map<String, dynamic>> results = await _database.query(
      'WorkWithPost',
      where: 'outletId = ?',
      whereArgs: [outletId],
    );

    if (results.isNotEmpty) {
      // Convert the first result to an Outlet object and return it
      return WorkWithPost.fromJson(results.first);
    } else {
      // If no result found,throw an exception
      throw Exception('WorkWith not found for id: $outletId');
    }
  }

  @override
  Future<void> insertMerchandise(Merchandise merchandise) async {
    try {
      _database.insert("Merchandise", merchandise.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<List<TaskType>> getAllMVTaskType() async {
    final result = await _database.rawQuery("SELECT * FROM TaskType");

    return result.map((json) => TaskType.fromJson(json)).toList();
  }

  @override
  Future<List<WTaskType>> getWWTaskTypes() async {
    final result = await _database.rawQuery("SELECT * FROM WTaskType");

    return result.map((json) => WTaskType.fromJson(json)).toList();
  }

  @override
  Future<int> workWithOutletCount(int routeId) async {
    final List<Map<String, dynamic>> result = await _database
        .rawQuery('SELECT COUNT(*) FROM WOutlet WHERE routeId = ?', [routeId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
  Future<void> insertWOutlets(List<WOutlet>? outlets) async {
    // TODO: implement insertWOutlets
    throw UnimplementedError();
  }

  @override
  Future<void> insertPreWorkWithData(WorkWithPre workWith) async {
    _database.insert("WorkWithPre", workWith.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteAllMerchandiseByOutlet(int outletId) async {
    _database.delete(
      "Merchandise",
      where: 'outletId = ?',
      whereArgs: [outletId],
    );
  }

  @override
  Future<void> updateWorkWith(WorkWithPost workWith) async {
    _database.update(
      "WorkWithPost",
      workWith.toJson(),
      where: 'outletId = ?',
      whereArgs: [workWith.outletId],
    );
  }

  @override
  Future<void> updateWOutlet(WOutlet outlet) async {
    _database.update(
      "WOutlet",
      outlet.toJson(),
      where: 'outletId = ?',
      whereArgs: [outlet.outletId],
    );
  }

  @override
  Future<List<Psr>> getAllPSrs() async {
    final result = await _database.rawQuery("SELECT *  FROM Psr");

    return result.map((e) => Psr.fromJson(e)).toList();
  }

  @override
  Future<List<MarketVisit>> dayEndQuery() async {
    final result = await _database.rawQuery(
        "Select * from MarketVisit  where MarketVisit.synced = 0 UNION Select * from WorkWithPost where WorkWithPost.synced = 0");

    return result.map((e) => MarketVisit.fromJson(e)).toList();
  }

  @override
  void insertMarketVisitData(MarketVisit marketVisit) async {
    _database.insert("MarketVisit", marketVisit.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateOutlet(Outlet outlet) async {
    _database.update(
      "Outlet",
      outlet.toJson(),
      where: 'outletId = ?',
      whereArgs: [outlet.outletId],
    );
  }

  @override
  void updateMarketSurvey(MarketVisit marketVisit) async {
    _database.update(
      "MarketVisit",
      marketVisit.toJson(),
      where: 'outletId = ?',
      whereArgs: [marketVisit.outletId],
    );
  }

  @override
  void updatePreWorkWith(WorkWithPre workWithPre) {
    _database.update(
      "WorkWithPre",
      workWithPre.toJson(),
      where: 'outletId = ?',
      whereArgs: [workWithPre.outletId],
    );
  }

  @override
  Future<MarketVisit> findMarketVisitById(int outletId) async {
    final List<Map<String, dynamic>> results = await _database.query(
      'MarketVisit',
      where: 'outletId = ?',
      whereArgs: [outletId],
    );

    if (results.isNotEmpty) {
      // Convert the first result to an Outlet object and return it
      return MarketVisit.fromJson(results.first);
    } else {
      // If no result found,throw an exception
      throw Exception('MarketVisit not found for id: $outletId');
    }
  }

  @override
  Future<List<Product>?> getAllSkus() async {
    final result = await _database.rawQuery("Select * from LookUpData");
    LookUpData lookUpData = LookUpData.fromJson(result.first);
    return lookUpData.products;
  }

  @override
  Future<LookUpData> getLookUpData() async {
    final result = await _database.rawQuery("Select * from LookUpData");
    LookUpData lookUpData = LookUpData.fromJson(result.first);
    return lookUpData;
  }

  @override
  Future<List<WorkWithPost>> getAllPostWork() async {
    final result = await _database.query("WorkWithPost");

    return result.map((e) => WorkWithPost.fromJson(e)).toList();
  }

  @override
  Future<List<WorkWithPre>> getAllPreWork() async {
    final result = await _database.query("WorkWithPre");

    return result.map((e) => WorkWithPre.fromJson(e)).toList();
  }

  @override
  Future<List<MarketVisit>> getMarketSurveys() async {
    final result = await _database.query("MarketVisit");

    return result.map((e) => MarketVisit.fromJson(e)).toList();
  }

  @override
  Future<List<MarketVisit>> getUnSyncedSurveys() async {
    final result =
        await _database.rawQuery("SELECT * FROM MarketVisit WHERE synced==0");

    return result.map((e) => MarketVisit.fromJson(e)).toList();
  }

  @override
  Future<List<WorkWithPre>> getAllUnSyncedPreWork() async {
    final result =
        await _database.rawQuery("SELECT * FROM WorkWithPre WHERE synced==0");

    return result.map((e) => WorkWithPre.fromJson(e)).toList();
  }

  @override
  Future<List<WorkWithPost>> getAllUnSyncedPostWork() async {
    final result =
        await _database.rawQuery("SELECT * FROM WorkWithPost WHERE synced==0");

    return result.map((e) => WorkWithPost.fromJson(e)).toList();
  }

  @override
  Future<void> updateRequest(RequestForm outletRequestForm) async {
    try {
      _database.update(
        "RequestForm",
        outletRequestForm.toJson(),
        where: 'formId = ?',
        whereArgs: [outletRequestForm.formId],
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> addRequest(RequestForm outletRequestForm) async {
    try {
      _database.insert("RequestForm", outletRequestForm.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<List<RequestForm>> getDraftForm(int formId) async {
    final result = await _database
        .query("RequestForm", where: 'requesTypeId = ?', whereArgs: [formId]);

    return result.map((e) => RequestForm.fromJson(e)).toList();
  }

  @override
  Future<List<RequestForm>> getRevertedForms(int formId, int revertedId) async {
    final result = await _database.query("DocumentTable",
        where: 'requesTypeId = ? and workflowStateId = ?',
        whereArgs: [formId, revertedId]);

    return result.map((e) => RequestForm.fromJson(e)).toList();
  }

  @override
  Future<List<RequestForm>> getSyncedForms(revertedId, int formId) async {
    final result = await _database.query("DocumentTable",
        where: 'requesTypeId = ? and workflowStateId != ?',
        whereArgs: [formId, revertedId]);

    return result.map((e) => RequestForm.fromJson(e)).toList();
  }

  @override
  Future<void> insertDocuments(List<DocumentTable>? documentTableList) async {
    if (documentTableList != null && documentTableList.isNotEmpty) {
      for (DocumentTable document in documentTableList) {
        _database.insert("DocumentTable", document.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertOutletTable(List<OutletTable>? outlets) async {
    if (outlets != null) {
      for (OutletTable outlet in outlets) {
        _database.insert("OutletTable", outlet.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> deleteOutlets() async {
    _database.delete("DocumentTable");
  }

  @override
  Future<void> deleteDocuments() async {
    _database.delete("OutletTable");
  }

  @override
  Future<void> deleteRequestForm(RequestForm requestForm) async {
    try {
      _database.delete("RequestForm",
          where: "formId = ?", whereArgs: [requestForm.formId]);
    }catch(e){
      showToastMessage(e.toString());
    }
  }

  @override
  Future<List<RequestForm>> getAllUnSyncedRequestForms(int requestId) async{
      final result = await _database.query(
          "RequestForm", where: "requesTypeId = ?", whereArgs: [requestId]);

      return result.map((e) => RequestForm.fromJson(e)).toList();
  }
}
