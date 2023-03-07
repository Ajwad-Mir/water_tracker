import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tracker/export.dart';

class WaterControls extends GetView<Homecontroller> {
  const WaterControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white.withOpacity(0.55),
                        elevation: 0
                    ),
                    onPressed: controller.reduce_Amount(100,8),
                    child: Text(
                      (controller.switchCheck.isFalse)
                          ? "+100 mL"
                          : "+8 Oz",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white.withOpacity(0.55),
                        elevation: 0
                    ),
                    onPressed: controller.reduce_Amount(200,16),
                    child: Text(
                      (controller.switchCheck.isFalse)
                          ? "+200 mL"
                          : "+16 Oz",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white.withOpacity(0.55),
                        elevation: 0
                    ),
                    onPressed: controller.reduce_Amount(500,32),
                    child: Text(
                      (controller.switchCheck.isFalse)
                          ? "+500 mL"
                          : "+32 Oz",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white.withOpacity(0.55),
                        elevation: 0
                    ),
                    onPressed: controller.reduce_Amount(1000,64),
                    child: Text(
                      (controller.switchCheck.isFalse)
                          ? "+1000 mL"
                          : "+64 Oz",
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.restart_alt, color: Colors.white),
          onPressed: () {
            controller.currentWaterUsed.value = 0;
            controller.remainingWaterAllowed.value = controller.totalWaterAllowed.value;
            controller.deleteWaterController.value.clear();
            controller.addWaterController.value.clear();
            controller.update();
          },
        )
      ],
    );
  }
}
