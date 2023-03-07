import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_tracker/export.dart';

class Home extends GetView<Homecontroller> {
  const Home({Key? key}) : super(key: key);

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
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Total Consumption",
                    style: TextStyle(fontSize: 36.0),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    (controller.switchCheck.isFalse)
                        ? "${controller.totalWaterUsed.value.toStringAsFixed(2)} ml"
                        : "${(controller.totalWaterUsed.value / 29.574).toStringAsFixed(2)} Oz",
                    style: TextStyle(fontSize: 32.0),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1.5,
                        crossAxisSpacing: 1.5,
                      ),
                      itemCount: controller.data.value.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20.0),
                            child: Material(
                              type: MaterialType.transparency,
                              child: Ink(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white.withOpacity(.55),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (controller.switchCheck.isTrue)
                                        ? "${(controller.data.value[index].waterConsumption / 29.574).toStringAsFixed(2)} Oz"
                                        : "${(controller.data.value[index].waterConsumption).toStringAsFixed(2)} Ml"
                                    ),
                                    Text(
                                      controller.data.value[index].timeCreated.toString(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => NewWaterItem());
          },
          child: Icon(
            Icons.add_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
