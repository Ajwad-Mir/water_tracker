import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:water_tracker/export.dart';

class WaterControls extends GetView<HomeController> {
  const WaterControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildAddWaterControls(),
        buildResetButton(),
      ],
    );
  }

  Widget buildAddWaterControls() {
    return SizedBox(
      width: 200.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildAddWaterLevelOne(),
              buildAddWaterLevelTwo(),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildAddWaterLevelThree(),
              buildAddWaterLevelFour(),
            ],
          )
        ],
      ),
    );
  }

  Widget buildAddWaterLevelOne() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          backgroundColor: Colors.white.withOpacity(0.55),
          elevation: 0),
      onPressed: controller.Reduce_Custom_Water_Intake_Amount(100, 8),
      child: Text(
        (controller.switchCheck.isFalse) ? "+100 mL" : "+8 Oz",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildAddWaterLevelTwo() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          backgroundColor: Colors.white.withOpacity(0.55),
          elevation: 0),
      onPressed: controller.Reduce_Custom_Water_Intake_Amount(200, 16),
      child: Text(
        (controller.switchCheck.isFalse) ? "+200 mL" : "+16 Oz",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildAddWaterLevelThree() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          backgroundColor: Colors.white.withOpacity(0.55),
          elevation: 0),
      onPressed: controller.Reduce_Custom_Water_Intake_Amount(500, 32),
      child: Text(
        (controller.switchCheck.isFalse) ? "+500 mL" : "+32 Oz",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildAddWaterLevelFour() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          backgroundColor: Colors.white.withOpacity(0.55),
          elevation: 0),
      onPressed: controller.Reduce_Custom_Water_Intake_Amount(1000, 64),
      child: Text(
        (controller.switchCheck.isFalse) ? "+1000 mL" : "+64 Oz",
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildResetButton() {
    return ElevatedButton(
      onPressed: () => controller.Clear_Data(),
      child: Icon(Icons.restart_alt, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        backgroundColor: Colors.white.withOpacity(0.25),
        elevation: 0,
      ),
    );
  }
}
