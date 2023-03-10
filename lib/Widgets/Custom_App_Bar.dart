import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:water_tracker/export.dart';

class CustomAppBar extends GetView<HomeController> implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        buildSettingsButton(),
      ],
    );
  }

  Widget buildSettingsButton() {
    return IconButton(
      icon: Icon(
        Icons.settings,
        color: Colors.black,
      ),
      onPressed: () {
        buildAlertDialog();
      },
    );
  }

  Future buildAlertDialog() {
    return Get.dialog(
      AlertDialog(
        content: Container(
          width: 150.w,
          height: 150.h,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Settings"),
              buildUnitSwitchRow(),
              buildDailyWaterIntakeRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUnitSwitchRow() {
    return Row(
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
                controller.Switch_Units(value);
              }),
        )
      ],
    );
  }

  Widget buildDailyWaterIntakeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Enter Value"),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: TextField(
              controller: controller.waterController,
              onSubmitted: (value) {
                controller.Update_Daily_Water_Intake_Amount();
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 80.h);
}
