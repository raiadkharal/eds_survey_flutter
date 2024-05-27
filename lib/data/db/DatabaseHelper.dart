import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseVersion = 3;
  static const _databaseName = "eds_survey";

  DatabaseHelper._privateConstructor();

  // this opens the database (and creates it if it doesn't exist)
  static Future<Database> getDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await upgradeTables(db);
      },
      onDowngrade: (db, oldVersion, newVersion) async =>
          await upgradeTables(db),
    );
  }

  static Future<void> createTables(Database database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Route` (`routeId` INTEGER, `routeName` TEXT, `distributionId` INTEGER, PRIMARY KEY (`routeId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `LookUpData` (`id` INTEGER NOT NULL, `packages` TEXT, `brands` TEXT, `products` TEXT, `vpo_classification` TEXT, `trade_classification` TEXT, `outlet_classification` TEXT, `channels` TEXT, `market_types` TEXT, `cities` TEXT, `outletTypes` TEXT,PRIMARY KEY (`id`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Merchandise` (`outletId` INTEGER, `merchandiseImages` TEXT, PRIMARY KEY (`outletId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Outlet` (`outletId` INTEGER, `routeId` INTEGER, `outletCode` TEXT, `outletName` TEXT, `outletChannel` TEXT, `status` INTEGER, `city` TEXT, `address` TEXT, `location` TEXT, `distributionId` INTEGER, `distributionName` TEXT, `lattitude` REAL, `longitude` REAL, `totalCoolers` INTEGER, `routeName` TEXT, `lastVisit` TEXT, `isZeroSaleOutlet` INTEGER, `isPJP` INTEGER, `mvLastVisitSameMonth` INTEGER, `mtdSale` REAL, `visitTimeLat` REAL, `visitTimeLng` REAL, `synced` INTEGER, `surveyTaken` INTEGER, PRIMARY KEY (`outletId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Distribution` (`distributionId` INTEGER, `distributionName` TEXT, PRIMARY KEY (`distributionId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Designation` (`designationId` INTEGER, `designationValue` TEXT, PRIMARY KEY (`designationId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `TaskType` (`taskTypeId` INTEGER, `taskType` TEXT, PRIMARY KEY (`taskTypeId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Task` (`taskId` INTEGER, `taskName` TEXT, `taskDate` TEXT, `outletId` INTEGER, `completedDate` TEXT, `status` TEXT, PRIMARY KEY (`taskId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `PackMapping` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `packId` INTEGER, `packName` TEXT, `companyId` INTEGER, `companyName` TEXT, `skuId` TEXT, `skuName` TEXT, `isCold` INTEGER, `isWarm` INTEGER, `isLowStock` INTEGER)');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `AssetMissingReason` (`reasonId` INTEGER, `reasonText` TEXT, PRIMARY KEY (`reasonId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `AssetEntity` (`assetId` INTEGER, `outletId` INTEGER, `assetNumber` TEXT, `assetType` TEXT, `status` TEXT, `serialNumber` TEXT, PRIMARY KEY (`assetId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `Psr` (`psrId` INTEGER NOT NULL, `psrName` TEXT, `psrCode` TEXT, PRIMARY KEY (`psrId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WRoute` (`routeId` INTEGER NOT NULL, `psrId` INTEGER, `routeName` TEXT, `distributionId` INTEGER, PRIMARY KEY (`routeId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WTask` (`taskId` INTEGER NOT NULL, `taskName` TEXT, `taskDate` TEXT, `completedDate` TEXT, `status` TEXT, `outletId` INTEGER, PRIMARY KEY (`taskId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WDistribution` (`distributionId` INTEGER NOT NULL, `distributionName` TEXT, PRIMARY KEY (`distributionId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WTaskType` (`taskTypeId` INTEGER NOT NULL, `taskType` TEXT, PRIMARY KEY (`taskTypeId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WOutlet` (`outletId` INTEGER NOT NULL, `routeId` INTEGER, `outletCode` TEXT, `outletName` TEXT, `outletChannel` TEXT, `status` INTEGER, `city` TEXT, `address` TEXT, `location` TEXT, `distributionId` INTEGER, `distributionName` TEXT, `longitude` REAL, `lattitude` REAL, `routeName` TEXT, `visitTimeLat` REAL, `visitTimeLng` REAL, `surveyTaken` INTEGER, `lastVisit` TEXT, `totalCoolers` INTEGER, `isZeroSaleOutlet` INTEGER, `wwLastVisitSameMonth` INTEGER, `mtdSale` REAL, `isPJP` INTEGER, PRIMARY KEY (`outletId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WorkWithPre` (`routeId` INTEGER NOT NULL, `psrId` INTEGER NOT NULL, `outletId` INTEGER, `synced` INTEGER, `data` TEXT, PRIMARY KEY (`routeId`, `psrId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `WorkWithPost` (`outletId` INTEGER NOT NULL, `synced` INTEGER, `data` TEXT, PRIMARY KEY (`outletId`))');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS `MarketVisit` (`outletId` INTEGER NOT NULL, `synced` INTEGER, `data` TEXT, PRIMARY KEY (`outletId`))');
    await database.execute('''
CREATE TABLE IF NOT EXISTS 'RequestForm' ('form_id' INTEGER PRIMARY KEY AUTOINCREMENT,
    'id' INTEGER,
    'code' INTEGER,
    'workflowId' INTEGER,
    'outletId' INTEGER,
    'outletCode' TEXT,
    'outletName' TEXT,
    'outletStatus' TEXT,
    'outletAddress' TEXT,
    'contactPerson' TEXT,
    'contactPersonPhone' TEXT,
    'routeName' TEXT,
    'routeId' INTEGER,
    'destinationOutletId' INTEGER,
    'organizationId' INTEGER,
    'distributionId' INTEGER,
    'actionId' INTEGER,
    'requestedById' INTEGER,
    'competitorExist' INTEGER,
    'refferedBy' TEXT,
    'requestDate' TEXT,
    'createdDate' TEXT,
    'ytdSalesVolume' INTEGER,
    'agreedYTDSalesVolume' INTEGER,
    'cnicFrontImageFilePath' TEXT,
    'cnicBackImageFilePath' TEXT,
    'outletImage' TEXT,
    'outletImagePath' TEXT,
    'eSignatureFilePath' TEXT,
    'mdeSignature' TEXT,
    'distributionName' TEXT,
    'longitude' REAL,
    'latitude' REAL,
    'comments' TEXT,
    'assignedToId' INTEGER,
    'assignedTo' TEXT,
    'assets' TEXT,
    'success' TEXT,
    'errorMessage' TEXT,
    'errorCode' INTEGER,
    'requestedBy' INTEGER,
    'requesTypeId' INTEGER,
    'retrievalTypeId' INTEGER,
    'vpoClassification' TEXT,
    'vpoClassificationId' INTEGER,
    'location' TEXT,
    'ownerName' TEXT,
    'ownerFatherName' TEXT,
    'ownerCNIC' TEXT,
    'phoneNumber' TEXT,
    'cityId' INTEGER,
    'outletTypeId' INTEGER,
    'marketeTypeId' INTEGER,
    'tradeClassificationId' INTEGER,
    'outletClassificationId' INTEGER,
    'channelId' INTEGER,
    'isCompetitorExist' INTEGER,
    'radius' REAL,
    'contactPerson1' TEXT,
    'contactPerson1CellNumber' TEXT,
    'contactPerson2' TEXT,
    'contactPerson2CellNumber' TEXT,
    'contactPerson3' TEXT,
    'contactPerson3CellNumber' TEXT,
    'pjPs' TEXT,
    'isPJPFixed' INTEGER,
    'colorCode' INTEGER,
    'issuanceCategoryId' INTEGER,
    'workflowStateId' INTEGER,
    'workflowState' TEXT,
    'unit' TEXT,
    'reason' TEXT,
    'reasonId' INTEGER,
    'issuanceCategory' TEXT,
    'scanningAssets' TEXT,
    'requestStatus' INTEGER
);
''');

    await database.execute('''
CREATE TABLE IF NOT EXISTS 'DocumentTable' ('document_id' INTEGER PRIMARY KEY AUTOINCREMENT,
    'id' INTEGER,
    'code' INTEGER,
    'workflowId' INTEGER,
    'outletId' INTEGER,
    'outletCode' TEXT,
    'outletName' TEXT,
    'outletStatus' TEXT,
    'outletAddress' TEXT,
    'contactPerson' TEXT,
    'contactPersonPhone' TEXT,
    'routeName' TEXT,
    'routeId' INTEGER,
    'destinationOutletId' INTEGER,
    'organizationId' INTEGER,
    'distributionId' INTEGER,
    'actionId' INTEGER,
    'requestedById' INTEGER,
    'competitorExist' INTEGER,
    'refferedBy' TEXT,
    'requestDate' TEXT,
    'createdDate' TEXT,
    'ytdSalesVolume' INTEGER,
    'agreedYTDSalesVolume' INTEGER,
    'cnicFrontImageFilePath' TEXT,
    'cnicBackImageFilePath' TEXT,
    'outletImage' TEXT,
    'outletImagePath' TEXT,
    'eSignatureFilePath' TEXT,
    'mdeSignature' TEXT,
    'distributionName' TEXT,
    'longitude' REAL,
    'latitude' REAL,
    'comments' TEXT,
    'assignedToId' INTEGER,
    'assignedTo' TEXT,
    'assets' TEXT,
    'success' TEXT,
    'errorMessage' TEXT,
    'errorCode' INTEGER,
    'requestedBy' INTEGER,
    'requesTypeId' INTEGER,
    'retrievalTypeId' INTEGER,
    'vpoClassification' TEXT,
    'vpoClassificationId' INTEGER,
    'location' TEXT,
    'ownerName' TEXT,
    'ownerFatherName' TEXT,
    'ownerCNIC' TEXT,
    'phoneNumber' TEXT,
    'cityId' INTEGER,
    'outletTypeId' INTEGER,
    'marketeTypeId' INTEGER,
    'tradeClassificationId' INTEGER,
    'outletClassificationId' INTEGER,
    'channelId' INTEGER,
    'isCompetitorExist' INTEGER,
    'radius' REAL,
    'contactPerson1' TEXT,
    'contactPerson1CellNumber' TEXT,
    'contactPerson2' TEXT,
    'contactPerson2CellNumber' TEXT,
    'contactPerson3' TEXT,
    'contactPerson3CellNumber' TEXT,
    'pjPs' TEXT,
    'isPJPFixed' INTEGER,
    'colorCode' INTEGER,
    'issuanceCategoryId' INTEGER,
    'workflowStateId' INTEGER,
    'workflowState' TEXT,
    'unit' TEXT,
    'reason' TEXT,
    'reasonId' INTEGER,
    'issuanceCategory' TEXT,
    'scanningAssets' TEXT,
    'requestStatus' INTEGER
);
''');

    await database.execute('''CREATE TABLE IF NOT EXISTS `OutletTable` (
    `outlet_id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `routeId` INTEGER,
    `routeName` TEXT,
    `outletId` INTEGER,
    `outletCode` TEXT,
    `outletName` TEXT,
    `location` TEXT,
    `address` TEXT,
    `lastScaniningDate` TEXT,
    `ownerFatherName` TEXT,
    `contactPerson1` TEXT,
    `contactPerson1CellNumber` TEXT,
    `contactNumber` TEXT,
    `cnic` TEXT,
    `ownerName` TEXT,
    `distributionId` INTEGER,
    `distributionName` TEXT,
    `organizationId` INTEGER,
    `organizationName` TEXT,
    `unitId` INTEGER,
    `unitName` TEXT,
    `agreedYTDSalesVolume` INTEGER,
    `ytdSalesVolume` TEXT,
    `longitude` REAL,
    `lattitude` REAL
);
''');
  }

  static upgradeTables(Database database) async {
    //drop existing tables
    await database.execute('DROP TABLE IF EXISTS `Route`');
    await database.execute('DROP TABLE IF EXISTS `LookUpData`');
    await database.execute('DROP TABLE IF EXISTS `Merchandise`');
    await database.execute('DROP TABLE IF EXISTS `Outlet`');
    await database.execute('DROP TABLE IF EXISTS `Distribution`');
    await database.execute('DROP TABLE IF EXISTS `Designation`');
    await database.execute('DROP TABLE IF EXISTS `TaskType`');
    await database.execute('DROP TABLE IF EXISTS `Task`');
    await database.execute('DROP TABLE IF EXISTS `PackMapping`');
    await database.execute('DROP TABLE IF EXISTS `AssetMissingReason`');
    await database.execute('DROP TABLE IF EXISTS `AssetEntity`');
    await database.execute('DROP TABLE IF EXISTS `Psr`');
    await database.execute('DROP TABLE IF EXISTS `WRoute`');
    await database.execute('DROP TABLE IF EXISTS `WTask`');
    await database.execute('DROP TABLE IF EXISTS `WDistribution`');
    await database.execute('DROP TABLE IF EXISTS `WTaskType`');
    await database.execute('DROP TABLE IF EXISTS `WOutlet`');
    await database.execute('DROP TABLE IF EXISTS `WorkWithPre`');
    await database.execute('DROP TABLE IF EXISTS `WorkWithPost`');
    await database.execute('DROP TABLE IF EXISTS `MarketVisit`');
    await database.execute('DROP TABLE IF EXISTS `RequestForm`');
    await database.execute('DROP TABLE IF EXISTS `DocumentTable`');
    await database.execute('DROP TABLE IF EXISTS `OutletTable`');

    //create new tables
    await createTables(database);
  }
}
