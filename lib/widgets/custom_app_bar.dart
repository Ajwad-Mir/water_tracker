import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water_tracker/export.dart';

class CustomAppBar extends GetView<Homecontroller> implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          onPressed: () {
            Get.dialog(
              AlertDialog(
                content: Container(
                  width: 150,
                  height: 150,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Settings"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Select Unit"),
                          Obx(
                            () => FlutterSwitch(
                              value: controller.switchCheck.value,
                              activeText: "Oz",
                              activeColor: Color(0xFF4F86CE),
                              inactiveColor: Color(0xFF4F86CE),
                              inactiveText: "mL",
                              showOnOff: true,
                              onToggle: (value) {
                                controller.switchCheck.value = value;
                                if (value == false) {
                                  GetStorage().write('measureUnit', "Oz");
                                  controller.currentWaterUsed.value = (controller.currentWaterUsed.value * 29.547);
                                  controller.remainingWaterAllowed.value = (controller.remainingWaterAllowed.value * 29.547);
                                  controller.totalWaterAllowed.value = (controller.totalWaterAllowed.value * 29.547);
                                  GetStorage().write('waterAllowed', controller.totalWaterAllowed.value);
                                  controller.update();
                                } else {
                                  GetStorage().write('measureUnit', "mL");
                                  controller.currentWaterUsed.value = (controller.currentWaterUsed.value / 29.547);
                                  controller.remainingWaterAllowed.value = (controller.remainingWaterAllowed.value / 29.547);
                                  controller.totalWaterAllowed.value = (controller.totalWaterAllowed.value / 29.547);
                                  GetStorage().write('waterAllowed', controller.totalWaterAllowed.value);
                                  controller.update();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Enter Value"),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextField(
                                controller: controller.waterController.value,
                                onSubmitted: (value) {
                                  if (double.parse(value) != 0.0) {
                                    controller.totalWaterAllowed.value =
                                        double.parse(controller.waterController.value.text);
                                    controller.remainingWaterAllowed.value = controller.totalWaterAllowed.value - controller.currentWaterUsed.value;
                                  }
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 80);
}
