import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Wavebackground extends StatelessWidget {
  final double percentage;

  const Wavebackground({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      waveFrequency:2.0,
      config: CustomConfig(
          colors: [
            Color(0xAE86CEFF),
            Color(0xAE86CEFF),
          ],
          durations: [
            5000,
            8000
          ],
          heightPercentages: [
            .65 * (1.0 - (percentage /100)),
            .635 * (1.0 - (percentage /100)),
          ]
      ), size: Size(double.infinity, double.infinity),
      waveAmplitude: 2.0,
    );
  }
}
