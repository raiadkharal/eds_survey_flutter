import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/market_visit/expired_stock/ExpiredStockScreen.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:get/get.dart';

import '../../../data/db/entities/look_up_data.dart';
import '../../../data/models/LookUpObject.dart';

class ExpiredStockViewModel extends GetxController {

  final Repository _repository;

  List<LookUpObject> packages = [];

  List<LookUpObject> brands = [];

  Rx<ExpiredStock> expiredStock = ExpiredStock.defaultValue.obs;
  RxList<LookUpObject> brandsByPackage1 = RxList<LookUpObject>();
  RxList<LookUpObject> brandsByPackage2 = RxList<LookUpObject>();
  RxList<LookUpObject> brandsByPackage3 = RxList<LookUpObject>();


  ExpiredStockViewModel(this._repository);

  void setExpiredStock(ExpiredStock value) {
    expiredStock.value = value;
  }

  void getBrandsAndPackages() async{
    _repository.getLookUpData().then((lookUpData) {
      packages.addAll(lookUpData.packages??[]);
      brands.addAll(lookUpData.brands??[]);
    });
  }

  void filterBrandsByPackage1(int? packageId) {
    brandsByPackage1.clear();
    if (packageId != null) {
      brandsByPackage1.addAll(brands
          .where((element) => element.firstIntExtraField == packageId));
    }
  }

  void filterBrandsByPackage2(int? packageId) {
    brandsByPackage2.clear();
    if (packageId != null) {
      brandsByPackage2.addAll(brands
          .where((element) => element.firstIntExtraField == packageId));
    }
  }

  void filterBrandsByPackage3(int? packageId) {
    brandsByPackage3.clear();
    if (packageId != null) {
      brandsByPackage3.addAll(brands
          .where((element) => element.firstIntExtraField == packageId));
    }
  }
}
