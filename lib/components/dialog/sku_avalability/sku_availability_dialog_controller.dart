import 'package:eds_survey/data/db/entities/look_up_data.dart';
import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:get/get.dart';

class SkuAvailabilityDialogController extends GetxController {
  final Repository _repository;

  // List<String> checkList1 = [
  //   "Olper's Cheddar Cheese Block 200gm-1x60",
  //   "Olper's Cheddar Cheese Slice 200gm-1x60",
  //   "Olper's Mozzarella Cheese Block 200gm-1x60"
  // ];

  final Rx<List<Product>> _products = Rx<List<Product>>([]);

  final Rx<List<LookUpObject>> _packages = Rx<List<LookUpObject>>([]);

  late Rx<List<String>> selectedProducts=Rx<List<String>>([]);

  SkuAvailabilityDialogController(this._repository);


  Rx<List<Product>> getProducts() => _products;

  // List<LookUpObject> getPackages() => [
  //       LookUpObject(key: 1, value: "250 ML RB 250 ML RB 250 ML RB250 ML RB"),
  //       LookUpObject(key: 2, value: "253 ML RB"),
  //       LookUpObject(key: 3, value: "255 ML RB")
  //     ];

  Rx<List<LookUpObject>> getPackages()=>_packages;

  void toggleItem(String? item,bool checked) {
    if(item!=null) {
      if (checked) {
        selectedProducts.value.add(item);
      } else {
        selectedProducts.value.remove(item);
      }
    }
    // if (selectedProducts.value.contains(item)) {
    //   selectedProducts.value.remove(item);
    // } else {
    //   selectedProducts.value.add(item);
    // }
    selectedProducts.refresh();
  }

  void resetSelectedProducts(){
    selectedProducts.value=[];
  }
  Future<void> loadPackagesAndProducts() async {
    LookUpData lookUpData = await _repository.getLookUpData();

    _packages.value = lookUpData.packages ?? [];
    _products.value = lookUpData.products ?? [];
  }

  void setSelectedProducts(List<String> products){
    selectedProducts(products);
    selectedProducts.refresh();
  }

  void filterProductsByPackage(int packageId) {
    List<Product> filteredList = [];

    for (Product product in _products.value) {
      if (product.productPackageId == packageId) {
        filteredList.add(product);
      }
    }
    _products.value = filteredList;
    _products.refresh();
  }
}
