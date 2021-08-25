import 'dart:async';

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:tasker/shared/theme/app_text_styles.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.of(context).pushReplacementNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: AppColors.primary,
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: AnimatedCard(
                direction: AnimatedCardDirection.top,
                duration: Duration(milliseconds: 400),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Tasker",
                    style: AppTextStyles.titleSplash,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            WaveWidget(
              config: CustomConfig(
                gradients: [
                  [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.4)
                  ],
                  [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.4)
                  ],
                  [Colors.white.withOpacity(0.7), Colors.white.withOpacity(0.7)]
                ],
                durations: [19440, 10800, 6000],
                heightPercentages: [0.23, 0.25, 0.30],
                blur: MaskFilter.blur(BlurStyle.solid, 10),
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
              waveAmplitude: 0,
              backgroundColor: Colors.transparent,
              size: Size(
                size.width,
                size.height * 0.53,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
