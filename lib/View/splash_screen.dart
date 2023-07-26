import 'dart:async';
import 'dart:math' as math;

import 'package:covid_tracker/View/world_status.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => WordState())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                  animation: animationController,
                  child: const SizedBox(
                    width: 200,
                    height: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('images/virus.png'),
                      ),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) =>
                      Transform.rotate(
                          angle: animationController.value * 2.0 * math.pi,
                          child: child)),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                'Covid-19\nTracker App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
