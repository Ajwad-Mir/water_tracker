import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tracker/export.dart';
import 'package:water_tracker/widgets/wave_background.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class NewWaterItem extends GetView<Homecontroller> {
  const NewWaterItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
      builder: (_) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: Stack(
          children: [
            Wavebackground(percentage: 45),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Obx(
                    () => SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            showLabels: false,
                            showTicks: false,
                            canScaleToFit: true,
                            radiusFactor: 1,
                            minimum: 0,
                            maximum: controller.totalWaterAllowed.value,
                            axisLineStyle: const AxisLineStyle(
                                cornerStyle: CornerStyle.bothCurve,
                                thicknessUnit: GaugeSizeUnit.factor,
                                thickness: 0.15),
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  angle: 360,
                                  widget: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        (controller.switchCheck.isFalse)
                                            ? '${controller.currentWaterUsed.value.toStringAsFixed(2)} mL'
                                            : '${controller.currentWaterUsed.value.toStringAsFixed(2)} Oz',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
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
                                  width: 0.15),
                            ]),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  (controller.switchCheck.isFalse)
                      ? 'Remaining: ${(controller.remainingWaterAllowed.value).toStringAsFixed(2)} mL'
                      : 'Remaining: ${(controller.remainingWaterAllowed.value).toStringAsFixed(2)} Oz',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      child: Icon(Icons.add_outlined, color: Colors.white),
                      onPressed: (controller.switchCheck.isTrue)
                          ? controller.checkIfAddableML()
                          : controller.checkIfAddableOz(),
                    ),
                    Container(
                      width: 300,
                      child: TextField(
                        controller: controller.addWaterController.value,
                        keyboardType: TextInputType.numberWithOptions(),
                        onSubmitted: (_) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(.50),
                            hintText: (controller.switchCheck.isTrue)
                                ? "Enter Amount in Oz"
                                : "Enter Amount in Ml",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      child: Icon(Icons.delete_outline, color: Colors.white),
                      onPressed: (controller.switchCheck.isTrue)
                          ? controller.checkIfReducableOz()
                          : controller.checkIfReducableML(),
                    ),
                    Container(
                      width: 300,
                      child: TextField(
                        controller: controller.deleteWaterController.value,
                        keyboardType: TextInputType.numberWithOptions(),
                        onSubmitted: (_) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                            hintText: (controller.switchCheck.isTrue)
                                ? "Enter Amount in Oz"
                                : "Enter Amount in Ml",
                            filled: true,
                            fillColor: Colors.white.withOpacity(.50),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                WaterControls(),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.55),
                      elevation: 0),
                  onPressed: () {
                    controller.addIntakeRecord();
                  },
                  child: Text(
                    "Save Intake Record",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
