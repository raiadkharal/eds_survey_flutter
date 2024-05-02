import 'package:eds_survey/data/db/entities/look_up_data.dart';
import 'package:eds_survey/data/db/entities/merchandise.dart';
import 'package:eds_survey/data/db/entities/workwith/Psr.dart';
import 'package:eds_survey/data/db/entities/workwith/WDistribution.dart';
import 'package:eds_survey/data/db/entities/workwith/WRoute.dart';
import 'package:eds_survey/data/db/entities/workwith/WTask.dart';
import 'package:eds_survey/data/db/entities/workwith/WTaskType.dart';
import 'package:eds_survey/data/db/entities/workwith/WorkWithPost.dart';
import 'package:eds_survey/data/db/entities/workwith/WorkWithPre.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:eds_survey/data/models/WOutletModel.dart';

import '../entities/asset_entity.dart';
import '../entities/asset_missing_reason.dart';
import '../entities/designation.dart';
import '../entities/distribution.dart';
import '../entities/market_visit.dart';
import '../entities/outlet.dart';
import '../entities/pack_mapping.dart';
import '../entities/route.dart';
import '../entities/task.dart';
import '../entities/task_type.dart';
import '../entities/workwith/WOutlet.dart';

abstract class MainDao {
  Future<List<MRoute>> findAllRoutes(int distributionId);

  Future<List<WRoute>> findWRoutes(int distributionId);

  Future<List<MRoute>> getRoutes();

  Future<List<Designation>> findAllDesignation();

  Future<List<Distribution>> findAllDistributions();

  // Stream<List<Distribution>> findMarketVisitDistributions();
  //
  // Stream<List<TaskType>> findAllTaskType();
  //
  // Stream<List<Task>> findAllTask(int outletId);
  //
  // Stream<List<AssetEntity>> findAllAssets();
  //
  // Stream<List<AssetEntity>> findOutletsAssets(int outletId);
  //
  // Stream<List<MarketVisit>> dayEndQuery();
  //
  // Future<List<Route>> getAllRoutes();
  //
  // Stream<Route?> findRouteById(int id);
  //
  // Stream<List<Outlet>> findAllOutlets();
  //
  // Stream<List<Outlet>> findAllOutletsForRoute(int routeId, int distributionId);
  //
  //
  // Future<Outlet?> findOutletById(int id);
  //
  // Stream<List<PackMapping>> findAllPacks();
  //
  // Future<List<PackMapping>> findPackById(int id);
  //
  //
  // Future<int> insertRoute(Route route);
  //
  Future<void> insertRoutes(List<MRoute> routes);

  Future<void> deleteAllMarketSurveys();

  Future<void> deleteAllPreWorkWith();

  Future<void> deleteAllPostWorkWith();

  Future<void> deleteAllMerchandise();

  Future<void> deletePackagesAndBrands();

  Future<void> insertDesignations(List<Designation> list);

  Future<void> insertDistribution(List<Distribution> distributions);

  Future<void> insertTaskTypes(List<TaskType> taskTypes);

  Future<void> insertTasks(List<Task> tasks);

  Future<void> insertPackages(List<PackMapping> packMappings);

  Future<void> insertAssetMissingReason(
      List<AssetMissingReason> missingReasons);

  Future<void> insertAssets(List<AssetEntity> outletAssets);

  Future<void> insertPackagesAndBrands(LookUpData lookUpData);

  Future<void> deleteAllRoutes();

  Future<void> deleteAllOutlets();

  Future<void> deleteAllAsset();

  Future<void> deleteAllAssetReason();

  Future<void> deleteAllDesignation();

  Future<void> deleteAllDistribution();

  Future<void> deleteMarketVisiDistribution();

  Future<void> deleteAllPackMapping();

  Future<void> deleteAllTask();

  Future<void> deleteAllTaskType();

  Future<void> deleteAllPsr();

  Future<void> deleteAllWWDistribution();

  Future<void> deleteAllWWRoutes();

  Future<void> deleteAllWWOutlets();

  Future<void> deleteAllWWTask();

  Future<void> deleteAllWWTaskType();

  Future<void> insertWWRoutes(List<WRoute> routes);
  Future<void> insertWWOutlets(List<WOutlet> outlets);
  Future<void> insertWWTaskTypes(List<WTaskType> taskTypes);
  Future<void> insertWWDistribution(List<WDistribution> distributions);
  Future<void> insertWWTasks(List<WTask> tasks);
  Future<void> insertPsr(List<Psr> psrs);

  Future<List<Distribution>> findMarketVisitDistributions();

  Future<List<WDistribution>> findWorkWithDistributions();

  Future<int> marketVisitOutlets(int routeId);

  Future<void> insertOutlets(List<Outlet>? outlets);

  Future<List<Outlet>> findAllOutletsForRoute(int routeId,int distributionId);
  Future<List<WOutlet>> findWOutletsForRoute(int routeId);

  Future<Outlet> findOutletById(int selectedOutletId);
  Future<WOutlet> findWOutletById(int selectedOutletId);

  Future<Merchandise> findMerchandiseByOutletId(int outletId);

  Future<void> insertMerchandise(Merchandise merchandise);

  Future<List<TaskType>> getAllMVTaskType();

  Future<List<WTaskType>> getWWTaskTypes();

  Future<int> workWithOutletCount(int routeId);

  Future<void> insertPreWorkWithData(WorkWithPre workWith);

  Future<WorkWithPost> findWorkWithByOutletId(int outletId);

  Future<void> updateWorkWith(WorkWithPost workWith);

  Future<void> deleteAllMerchandiseByOutlet(int outletId);

  Future<void> updateWOutlet(WOutlet outlet);

  Future<List<Psr>> getAllPSrs();

  Future<List<MarketVisit>> dayEndQuery();

  void insertMarketVisitData(MarketVisit marketVisit);

  void updateOutlet(Outlet outlet);

  void updateMarketSurvey(MarketVisit marketVisit);
  void updatePreWorkWith(WorkWithPre workWithPre);

  Future<MarketVisit> findMarketVisitById(int outletId);

  Future<List<Product>?> getAllSkus();

  Future<LookUpData> getBrandsAndPackages();

  Future<List<MarketVisit>> getMarketSurveys();
  Future<List<WorkWithPre>> getAllPreWork();
  Future<List<WorkWithPost>> getAllPostWork();

  Future<List<MarketVisit>> getUnSyncedSurveys();

  Future<List<WorkWithPre>> getAllUnSyncedPreWork();

  Future<List<WorkWithPost>> getAllUnSyncedPostWork();

// Future<void> insertDesignations(List<Designation> designations);
//
// Future<void> insertDistribution(List<Distribution> distributions);
//
// Future<void> insertTaskTypes(List<TaskType> taskTypes);
//
// Future<void> insertTasks(List<Task> tasks);
//
// Future<void> insertAssetMissingReason(List<AssetMissingReason> reasons);
//
// Future<void> insertAssets(List<AssetEntity> assetEntities);
//
// Future<void> insertPackages(List<PackMapping> packMappings);
}
