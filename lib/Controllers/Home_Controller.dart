import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/export.dart';

class HomeController extends GetxController {

  //variables and list for data storage
  final RxList data = [].obs;
  final RxBool switchCheck = false.obs;
  final RxDouble currentWaterUsed = 0.0.obs;
  final RxDouble totalWaterAllowed = 5000.0.obs;
  final RxDouble totalWaterUsed = 0.0.obs;
  final RxDouble remainingWaterAllowed = 0.0.obs;

  //TextEditingController for textfields
  final TextEditingController waterController = TextEditingController();
  final TextEditingController deleteWaterController = TextEditingController();
  final TextEditingController addWaterController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    if(GetStorage().hasData('listData')) {
      data.value = GetStorage().read('listData');
    }
    else{
      data.value = [];
    }
    if(GetStorage().hasData('totalWaterAllowed')){
      totalWaterAllowed.value = GetStorage().read('totalWaterAllowed');
      remainingWaterAllowed.value = totalWaterAllowed.value - currentWaterUsed.value;
    }
    else{
      GetStorage().write('totalWaterAllowed', 5000.0);
      totalWaterAllowed.value = 5000;
      remainingWaterAllowed.value = totalWaterAllowed.value - currentWaterUsed.value;
    }
    if(GetStorage().read('measureUnit') == 'Oz'){
      switchCheck.value = true;
    }
    else{
      switchCheck.value = false;
    }
    data.forEach((values) {
      totalWaterUsed.value += values['waterConsumption'];
    });
    update();
  }

  VoidCallback? Reduce_Custom_Water_Intake_Amount(double mlValue, double OzValue) {
    if (switchCheck.isTrue) {
      if (remainingWaterAllowed.value < OzValue) {
        return null;
      } else {
        return () {
          currentWaterUsed.value += OzValue;
          remainingWaterAllowed.value -= OzValue;
          update();
        };
      }
    } else {
      if (remainingWaterAllowed.value < mlValue) {
        return null;
      } else {
        return () {
          currentWaterUsed.value += mlValue;
          remainingWaterAllowed.value -= mlValue;
          update();
        };
      }
    }
  }

  VoidCallback? Check_If_Addable_ML() {
    if (addWaterController.value.text.isNotEmpty) {
      if (currentWaterUsed.value + double.parse(addWaterController.value.text) > totalWaterAllowed.value) {
        return null;
      }
      return () {
        currentWaterUsed.value += double.parse(addWaterController.value.text);
        remainingWaterAllowed.value -= double.parse(addWaterController.value.text);
        update();
      };
    } else {
      return null;
    }
  }

  VoidCallback? Check_If_Addable_Oz() {
    if (addWaterController.value.text.isNotEmpty) {
      if (currentWaterUsed.value + double.parse(addWaterController.value.text) > totalWaterAllowed.value) {
        return null;
      }
      return () {
        currentWaterUsed.value += double.parse(addWaterController.value.text);
        remainingWaterAllowed.value -= double.parse(addWaterController.value.text);
        update();
      };
    } else {
      return null;
    }
  }

  VoidCallback? Check_If_Reducable_ML() {
    if (deleteWaterController.value.text.isNotEmpty) {
      if (currentWaterUsed.value - double.parse(deleteWaterController.value.text) < 0) {
        return null;
      }
      return () {
        currentWaterUsed.value -= double.parse(deleteWaterController.value.text);
        remainingWaterAllowed.value += double.parse(deleteWaterController.value.text);
        update();
      };
    } else {
      return null;
    }
  }

  VoidCallback? Check_If_Reducable_Oz() {
    if (deleteWaterController.value.text.isNotEmpty) {
      if (currentWaterUsed.value - double.parse(deleteWaterController.value.text) < 0) {
        return null;
      }
      return () {
        currentWaterUsed.value -= double.parse(deleteWaterController.value.text);
        remainingWaterAllowed.value += double.parse(deleteWaterController.value.text);
        update();
      };
    } else {
      return null;
    }
  }

  void Add_Intake_Record() {
    if(currentWaterUsed.value == 0.0){
      Get.snackbar('Error', "Please add water");
    }
    else {
      if (switchCheck.isTrue) {
        data.add(WaterPerDay(
            waterConsumption: currentWaterUsed.value,
            measureUnit: 'Oz',
            timeCreated: DateTime.now().toLocal().toString()
        ).toJson());
      } else {
        data.add(WaterPerDay(
            waterConsumption: currentWaterUsed.value,
            measureUnit: 'ML',
            timeCreated: DateTime.now().toLocal().toString()
        ).toJson());
      }
      totalWaterUsed.value += currentWaterUsed.value;
      currentWaterUsed.value = 0.0;
      remainingWaterAllowed.value = totalWaterAllowed.value;
      GetStorage().write('listData', data);
      update();
      Get.back();
    }
  }

  void Switch_Units(bool value) {
    switchCheck.value = value;
    if (!value) {
      GetStorage().write('measureUnit', "Oz");
      currentWaterUsed.value = (currentWaterUsed.value * 29.547);
      remainingWaterAllowed.value = (remainingWaterAllowed.value * 29.547);
      totalWaterAllowed.value = (totalWaterAllowed.value * 29.547);
    } else {
      GetStorage().write('measureUnit', "mL");
      currentWaterUsed.value = (currentWaterUsed.value / 29.547);
      remainingWaterAllowed.value = (remainingWaterAllowed.value / 29.547);
      totalWaterAllowed.value = (totalWaterAllowed.value / 29.547);
    }
    GetStorage().write('totalWaterAllowed', totalWaterAllowed.value);
    update();
  }

  void Update_Daily_Water_Intake_Amount() {
    if (double.parse(waterController.text) != 0.0) {
      totalWaterAllowed.value = double.parse(waterController.text);
      remainingWaterAllowed.value = totalWaterAllowed.value - currentWaterUsed.value;
    }
    GetStorage().write('totalWaterAllowed',totalWaterAllowed.value);
    update();
  }

  void Clear_Data() {
    currentWaterUsed.value = 0;
    remainingWaterAllowed.value = totalWaterAllowed.value;
    deleteWaterController.clear();
    addWaterController.clear();
    update();
  }

  String buildDayText(int index) {
    return DateFormat.yMMMd().add_Hms().format(DateTime.parse(data[index]['timeCreated']));
  }
}
