import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:water_tracker/export.dart';

class NewWaterItem extends GetView<HomeController> {
  const NewWaterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            Wavebackground(percentage: 45.sp),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildWaterGauge(),
                SizedBox(height: 10.h),
                buildRemainingWaterText(),
                SizedBox(height: 50.h),
                Expanded(child: SizedBox()),
                buildAddWaterControls(),
                SizedBox(height: 20.h),
                buildRemoveWaterControls(),
                SizedBox(height: 20.h),
                WaterControls(),
                SizedBox(height: 20.h),
                buildSaveIntakeRecord(),
                SizedBox(height: 50.h)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWaterGauge() {
    return Container(
      width: 200.w,
      height: 200.h,
      child: Obx(
        () => SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                showLabels: false,
                showTicks: false,
                canScaleToFit: true,
                radiusFactor: 1.r,
                minimum: 0,
                maximum: controller.totalWaterAllowed.value,
                axisLineStyle: AxisLineStyle(
                    cornerStyle: CornerStyle.bothCurve,
                    thicknessUnit: GaugeSizeUnit.factor,
                    thickness: 0.15.w),
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      angle: 360.r,
                      widget: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            (controller.switchCheck.isFalse)
                                ? '${controller.currentWaterUsed.value.toStringAsFixed(2)} mL'
                                : '${controller.currentWaterUsed.value.toStringAsFixed(2)} Oz',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )),
                ],
                pointers: [
                  RangePointer(
                      value: controller.currentWaterUsed.value,
                      cornerStyle: CornerStyle.bothCurve,
                      enableAnimation: true,
                      animationDuration: 1000,
                      sizeUnit: GaugeSizeUnit.factor,
                      gradient: SweepGradient(colors: [
                        Color(0xAE86CEFF),
                        Color(0xAE26CEFF),
                      ], stops: <double>[
                        0.25,
                        0.75
                      ]),
                      color: Color(0xFF176BD9),
                      width: 0.15.w),
                ]),
          ],
        ),
      ),
    );
  }

  Widget buildRemainingWaterText() {
    return Text(
      (controller.switchCheck.isFalse)
          ? 'Remaining: ${(controller.remainingWaterAllowed.value).toStringAsFixed(2)} mL'
          : 'Remaining: ${(controller.remainingWaterAllowed.value).toStringAsFixed(2)} Oz',
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    );
  }

  Widget buildAddWaterControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: (controller.switchCheck.isTrue)
              ? controller.Check_If_Addable_Oz()
              : controller.Check_If_Addable_ML(),
          child: Icon(Icons.add_outlined, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            backgroundColor: Colors.white.withOpacity(0.55),
            elevation: 0,
          ),
        ),
        Container(
          width: 300.w,
          child: TextField(
            controller: controller.addWaterController,
            keyboardType: TextInputType.numberWithOptions(),
            onSubmitted: (_) {
              controller.update();
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(.50),
                hintText:
                    (controller.switchCheck.isTrue) ? "Enter Amount in Oz" : "Enter Amount in Ml",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0.r),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildRemoveWaterControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: (controller.switchCheck.isTrue)
              ? controller.Check_If_Reducable_Oz()
              : controller.Check_If_Reducable_ML(),
          child: Icon(Icons.delete_outline, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            backgroundColor: Colors.white.withOpacity(0.55),
            elevation: 0,
          ),
        ),
        Container(
          width: 300.w,
          child: TextField(
            controller: controller.deleteWaterController,
            keyboardType: TextInputType.numberWithOptions(),
            onSubmitted: (_) {
              controller.update();
            },
            decoration: InputDecoration(
                hintText:
                    (controller.switchCheck.isTrue) ? "Enter Amount in Oz" : "Enter Amount in Ml",
                filled: true,
                fillColor: Colors.white.withOpacity(.50),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0.r),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildSaveIntakeRecord() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          backgroundColor: Colors.white.withOpacity(0.55),
          elevation: 0),
      onPressed: () {
        controller.Add_Intake_Record();
      },
      child: Text(
        "Save Intake Record",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
