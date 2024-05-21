import 'package:eds_survey/components/dialog/sku_avalability/sku_availability_dialog_controller.dart';
import 'package:eds_survey/components/dropdown/SimpleDropdownExpiredStock.dart';
import 'package:eds_survey/components/dropdown/customer_service_dropdown.dart';
import 'package:eds_survey/components/progress_dialog/PregressDialog.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SkuAvailabilityDialog extends StatefulWidget {
  final Function(String) onSave;

  const SkuAvailabilityDialog({super.key, required this.onSave});

  @override
  State<SkuAvailabilityDialog> createState() => _SkuAvailabilityDialogState();
}

class _SkuAvailabilityDialogState extends State<SkuAvailabilityDialog> {
  final SkuAvailabilityDialogController controller =
      Get.put<SkuAvailabilityDialogController>(
          SkuAvailabilityDialogController(Get.find<Repository>()));

  @override
  void initState() {
    controller.resetSelectedProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.loadPackagesAndProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(flex: 2, child: Text("Package Name: ")),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SimpleDropdownExpiredStock(
                              options: controller.getPackages().value,
                              underLined: false,
                              isExpanded: true,
                              onChanged: (package) {
                                controller
                                    .filterProductsByPackage(package.key ?? 0);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "SKU-Availability Checklist",
                  style: GoogleFonts.roboto(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.getProducts().value.length,
                    itemBuilder: (BuildContext context, int sectionIndex) {
                      Product item =
                          controller.getProducts().value[sectionIndex];
                      return Row(
                        children: [
                          Obx(
                            () => Checkbox(
                                value: controller.selectedProducts.value
                                    .contains(item),
                                onChanged: (value) {
                                  controller.toggleItem(item, value ?? false);
                                }),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.productName ?? "",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.roboto(
                                color: Colors.blue, fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {

                            if(controller.selectedProducts.value.isEmpty){
                              showToastMessage("Please select missing SKUs");
                              return;
                            }

                            Navigator.of(context).pop();
                            String selectedProductNamesStr =
                                widget.onSave(controller.selectedProducts.value
                                    .map(
                                      (product) => product.productName,
                                    )
                                    .join(", "));
                            widget.onSave(selectedProductNamesStr);
                          },
                          child: Text(
                            "Save",
                            style: GoogleFonts.roboto(
                                color: Colors.blue, fontSize: 18),
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return const SimpleProgressDialog();
        }
      },
    );
  }
}
