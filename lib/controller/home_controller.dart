import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_tracker/model/water_per_day.dart';

class Homecontroller extends GetxController{
  var switchCheck = false.obs;
  late Rx<double> currentWaterUsed = 0.0.obs;
  late Rx<double> totalWaterAllowed = 5000.0.obs;
  late Rx<double> totalWaterUsed = 0.0.obs;
  late var remainingWaterAllowed = totalWaterAllowed.value.obs;
  RxList data = [].obs;
  var waterController = TextEditingController().obs;
  var deleteWaterController = TextEditingController().obs;
  var addWaterController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    if(GetStorage().hasData('listData')){
      data = GetStorage().read('listData');
    }
    else{
      data.value = [];
    }
    if(GetStorage().hasData('waterAllowed') == false && GetStorage().hasData('measureUnit') == false){
      GetStorage().write('measureUnit', "Oz");
      currentWaterUsed.value = 0.0;
      totalWaterAllowed.value = 5000.0;
    }
    else{
      if(GetStorage().read('measureUnit') == "Oz"){
        switchCheck.value = false;
        totalWaterAllowed.value = GetStorage().read('waterAllowed');
      }
      else{
        switchCheck.value = true;
        totalWaterAllowed.value = GetStorage().read('waterAllowed');
      }
    }
  }

  reduce_Amount(double mlValue, double OzValue) {
    if(switchCheck.isTrue){
      if(remainingWaterAllowed.value < OzValue){
        return null;
      }
      else{
        return () {
          currentWaterUsed.value += OzValue;
          remainingWaterAllowed.value -= OzValue;
          update();
        };
      }
    }
    else{
      if(remainingWaterAllowed.value < mlValue){
        return null;
      }
      else{
        return () {
          currentWaterUsed.value += mlValue;
          remainingWaterAllowed.value -= mlValue;
          update();
        };
      }
    }
  }

  checkIfAddableML() {
    if(addWaterController.value.text.isNotEmpty){
      if(currentWaterUsed.value + double.parse(addWaterController.value.text) > totalWaterAllowed.value){
        return null;
      }
      return () {
        currentWaterUsed.value = currentWaterUsed.value + double.parse(addWaterController.value.text);
        remainingWaterAllowed.value = remainingWaterAllowed.value - double.parse(addWaterController.value.text);
        update();
      };
    }
    else{
      return null;
    }
  }
  checkIfAddableOz() {
   
    if(addWaterController.value.text.isNotEmpty){
      if(currentWaterUsed.value + double.parse(addWaterController.value.text) > totalWaterAllowed.value){
        return null;
      }
      return () {
        currentWaterUsed.value = currentWaterUsed.value + double.parse(addWaterController.value.text);
        remainingWaterAllowed.value = remainingWaterAllowed.value - double.parse(addWaterController.value.text);
        update();
      };
    }
    else{
      return null;
    }
  }

  checkIfReducableML() {
   
    if(deleteWaterController.value.text.isNotEmpty){
      if(currentWaterUsed.value - double.parse(deleteWaterController.value.text) < 0){
        return null;
      }
      return () {
        currentWaterUsed.value = currentWaterUsed.value - double.parse(deleteWaterController.value.text);
        remainingWaterAllowed.value = remainingWaterAllowed.value + double.parse(deleteWaterController.value.text);
        update();
      };
    }
    else{
      return null;
    }
  }
  checkIfReducableOz() {
   
    if(deleteWaterController.value.text.isNotEmpty){
      if(currentWaterUsed.value - double.parse(deleteWaterController.value.text) < 0){
        return null;
      }
      return () {
        currentWaterUsed.value = currentWaterUsed.value - double.parse(deleteWaterController.value.text);
        remainingWaterAllowed.value = remainingWaterAllowed.value + double.parse(deleteWaterController.value.text);
        update();
      };
    }
    else{
      return null;
    }
  }

  addIntakeRecord() {
    if(switchCheck.isTrue){
      data.value.add(WaterPerDay(waterConsumption: currentWaterUsed.value,measureUnit: "Oz",timeCreated: DateTime.now()));
    }
    else{
      data.value.add(WaterPerDay(waterConsumption: currentWaterUsed.value,measureUnit: "ML",timeCreated: DateTime.now()));
    }
    totalWaterUsed.value += currentWaterUsed.value;
    currentWaterUsed.value = 0.0;
    remainingWaterAllowed.value = totalWaterAllowed.value;
    GetStorage().write('listData', data);
    update();
    Get.back();
  }
}