import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:water_tracker/export.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

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
                buildTotalConsumptionHeader(),
                SizedBox(height: 40.h),
                buildTotalConsumption(),
                SizedBox(height: 40.h),
                buildWaterIntakeList(),
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

  Widget buildTotalConsumptionHeader() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Total Consumption",
        style: TextStyle(fontSize: 36.sp),
      ),
    );
  }

  Widget buildTotalConsumption() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        (controller.switchCheck.isFalse)
            ? "${controller.totalWaterUsed.value.toStringAsFixed(2)} ml"
            : "${(controller.totalWaterUsed.value / 29.574).toStringAsFixed(2)} Oz",
        style: TextStyle(fontSize: 32.sp),
      ),
    );
  }

  Widget buildWaterIntakeList() {
    if (controller.data.isEmpty) {
      return Expanded(child: Center(child: buildEmptyList()));
    }
    return Expanded(
      child: Obx(
        () => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1.5.w,
              crossAxisSpacing: 1.5.h,
            ),
            shrinkWrap: true,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              return (controller.data.length == 0) ? buildEmptyList() : buildWaterIntakeItem(index);
            }),
      ),
    );
  }

  Widget buildEmptyList() {
    return Text(
      "The List is Empty",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24.sp,
        color: Colors.black,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget buildWaterIntakeItem(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20.0.r),
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1.w),
              borderRadius: BorderRadius.circular(20.0.r),
              color: Colors.white.withOpacity(.55),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildWaterIntakeItemIconAndName(),
                buildWaterIntakeItemData(index)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWaterIntakeItemIconAndName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.water_drop_outlined,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Water",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget buildWaterIntakeItemData(int index) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                (controller.switchCheck.isTrue)
                    ? "${(controller.data[index]['waterConsumption'] / 29.574).toStringAsFixed(2)} Oz"
                    : "${(controller.data[index]['waterConsumption']).toStringAsFixed(2)} Ml",
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                )
            ),
            Text(
                controller.buildDayText(index),
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                )
            ),
          ],
        ),
      ),
    );
  }
}
