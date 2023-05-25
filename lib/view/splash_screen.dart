
import 'package:covid_app19/view/world_states.dart';
import 'package:flutter/material.dart';


import 'dart:async';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(duration: const Duration(seconds: 4), vsync: this)
    ..repeat();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorldStateScreen())));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: SizedBox(
                  height: height/2,
                  width: width/2,
                  child: const Image(
                    image: AssetImage('assets/images/virus.png'),

                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,);
                }),
            SizedBox(
              height:height/100,
            ),
            const  Align(
                alignment: Alignment.center,
                child:  Text('Covid-19 \nTracker App',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),


          ],
        ),
      ),
    );
  }
}
