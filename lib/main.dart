import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 't2ipage_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animations/animations.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:math';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MaterialApp(
      home: AnimatedSplashScreen(
        duration: 1500,
        backgroundColor: Colors.black,
        splash: Stack(children: [
          Lottie.asset('assets/logo.json'),
          Positioned(
            top: 110,
            left: 40,
            child: Text(
              'Voice AI',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'Dance',
              ),
            ),
          )
        ]),
        nextScreen: MyApp(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  List<String> imgs = [
    'assets/webai1.jpg',
    'assets/webai5.jpg',
    'assets/webai3.jpg',
    'assets/webai4.jpg',
  ];
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    Timer mytime = Timer.periodic(Duration(seconds: 6), (timer) {
      setState(() {
        Random random = new Random();
        int randomNumber = random.nextInt(4);
        img1 = img;
        img = imgs[randomNumber];
      });
    });
  }

  var _controller;
  var _animation;
  var img = 'assets/webai3.jpg';
  var img1 = 'assets/webai3.jpg';

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              height: 2000,
              width: 2000,
              child: FadeInImage.assetNetwork(
                placeholder: img1,
                image: img,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: height * 0.15,
                left: wid * 0.4,
                child: GradientText(
                  'Voice AI',
                  style: TextStyle(fontSize: 100, fontFamily: 'Dance'),
                  colors: [Colors.green, Colors.blue],
                )),
            Positioned(
                top: height * 0.5,
                left: wid * 0.3,
                child: OpenContainer(
                  closedColor: Colors.transparent,
                  closedBuilder: (context, action) {
                    return Container(
                        width: wid * 0.45,
                        height: height * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black54),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 20,
                                left: 10,
                                child: GradientText(
                                  'Text To Image',
                                  style: TextStyle(fontSize: 30),
                                  colors: [Colors.blue, Colors.green],
                                )),
                            Positioned(
                                top: 70,
                                left: 10,
                                right: 200,
                                child: GradientText(
                                  'This is an AI Image Generator. It creates an image from scratch from a text description.Yes, this is the one youve been waiting for. Text-to-image uses AI to understand your words and convert them to a unique image each time. Like magic.',
                                  style: TextStyle(fontSize: 10),
                                  colors: [Colors.green, Colors.blue],
                                )),
                            Positioned(
                                top: 50,
                                left: 400,
                                right: 5,
                                child: Image.asset('assets/web3.png'))
                          ],
                        ));
                  },
                  openBuilder: (context, action) {
                    return t2ipage();
                  },
                )),
          ]),
        ));
  }
}
