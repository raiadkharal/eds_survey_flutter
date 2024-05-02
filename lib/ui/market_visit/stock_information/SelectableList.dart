import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> section1 = ['Item 1', 'Item 2', 'Item 3'];
  final List<String> section2 = ['Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: ListView.separated(
        itemCount: 2,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return GetBuilder<MyController>(
            init: MyController(),
            builder: (controller) {
              List<String> currentSection = index == 0 ? section1 : section2;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "${index+1}.SKUS-Availability CheckList-${index+1}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: currentSection.length,
                    itemBuilder: (BuildContext context, int sectionIndex) {
                      String item = currentSection[sectionIndex];
                      return CheckboxListTile(
                        title: Text(item),
                        value: controller.selectedItems.contains(item),
                        onChanged: (value) {
                          controller.toggleItem(item);
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<MyController>().printSelectedItems();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class MyController extends GetxController {
  List<String> selectedItems = [];

  void toggleItem(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    update(); // Notify GetX that the state has changed
  }

  void printSelectedItems() {
    print(selectedItems);
  }
}