import 'dart:io';

import 'package:eds_survey/data/db/entities/merchandise.dart';
import 'package:eds_survey/data/models/Configuration.dart';
import 'package:eds_survey/data/models/MerchandisingImage.dart';
import 'package:eds_survey/ui/home/HomeRepository.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MerchandisingViewModel extends GetxController {
  final Repository _repository;

  Rx<List<MerchandisingImage>> beforeImages = Rx<List<MerchandisingImage>>([]);
  Rx<List<MerchandisingImage>> afterImages = Rx<List<MerchandisingImage>>([]);
  Rx<Merchandise> merchandiseData = Merchandise().obs;
  List<MerchandisingImage> listImages = [];
  Rx<List<MerchandisingImage>> imagesLiveData =
      Rx<List<MerchandisingImage>>([]);

  RxBool isLoading = false.obs;
  RxBool enableAfterMerchandiseButton = false.obs;
  RxBool enableNextButton = false.obs;
  RxBool isSaved = false.obs;
  RxBool lessImages = false.obs;
  int imagesCount = 0;

  MerchandisingViewModel(this._repository);

  saveImages(String? imagePath, int type) {
    imagesCount++;
    MerchandisingImage item = MerchandisingImage();
    item.id = imagesCount;
    //item.setBase64Image(base64Image);
    item.path = imagePath;
    item.type = type;

    listImages.add(item);
    debugPrint("imagePath:: $imagePath");
    setEnableNextButton(type);
  }

  removeMerchandiseImage(MerchandisingImage image) {
    listImages.remove(image);
    setImageLiveData();
  }

  void setLoading(bool value) {
    isLoading.value = value;
    isLoading.refresh();
  }

  Rx<Merchandise> loadMerchandise(int outletId) {
    try {
      _repository.findMerchandise(outletId).then((merchandise) {
        listImages.clear();
        if (merchandise.merchandiseImages != null) {
          listImages.addAll(merchandise.merchandiseImages!);
        }
        imagesCount = listImages.length;
        merchandiseData.value = merchandise;
        if (imagesCount > 1) {
          setEnableNextButton(1);
        }
      });
    } catch (e) {
      showToastMessage(e.toString());
    }

    return merchandiseData;
  }

  void setEnableNextButton(int type) {
    enableAfterMerchandiseButton.value = false;
    enableAfterMerchandiseButton.refresh();
    if (listImages.length > 1 && type == 1) {
      enableNextButton.value = true;
      enableNextButton.refresh();
    }
    setImageLiveData();
  }

  void setImageLiveData() {
    imagesLiveData.value = listImages;
    imagesLiveData.refresh();
  }

  void populateMerchandise(
      bool beforeMerchandise, List<MerchandisingImage> merchandiseImages) {
    if (beforeMerchandise) {
      beforeImages.value = merchandiseImages;
      beforeImages.refresh();
    } else {
      afterImages.value = merchandiseImages;
      afterImages.refresh();
    }
  }

  bool validateImageCount() {
    int type0Count = getImageCountByType(0);
    int type1Count = getImageCountByType(1);

    if (type1Count < 1 || type0Count < 1) {
      setLessImages(true);
      return false;
    }
    return true;
  }

  int getImageCountByType(int type) {
    int count = 0;
    for (MerchandisingImage img in listImages) {
      if (img.type == type) {
        count++;
      }
    }
    return count;
  }

  void setLessImages(bool value) {
    lessImages.value = value;
    lessImages.refresh();
  }

  void insertMerchandiseIntoDB(int outletId) {
    if (listImages.length >= 2) {
      saveMerchandise(outletId, imagesLiveData.value);
    } else {
      setLessImages(true);
    }
  }

  void saveMerchandise(
      int outletId, List<MerchandisingImage> merchandiseImages) {
    Merchandise merchandise = Merchandise();
    merchandise.outletId = outletId;
    merchandise.merchandiseImages = merchandiseImages;

    _repository.insertIntoDB(merchandise).whenComplete(() {
      setIsSaved(true);
    }).onError((error, stackTrace) {
     setIsSaved(true);
    });
  }

  void setIsSaved(bool value){
    isSaved.value = value;
    isSaved.refresh();
  }
  Configuration getConfiguration()=> _repository.getConfiguration();
}
