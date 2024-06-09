import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transform & Animated Builder',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//SingleTickerProviderStateMixin is a must for animations and it provides this variable
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //Variable for controlling the animation
  late AnimationController _controller;
  //Variable of animation
  late Animation<double> _animation;
  /*
  0.0 = 0 degrees
  0.5 = 180 degrees
  1.0 = 360 degrees
  */
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      //Duration determines the speed
      duration: const Duration(seconds: 2),
      //..repeat() function provides the animation loop
      // )..repeat();
    );
    //Tween is not an animation and for making this right after of tween you animate that
    //with controller what stays above
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    //you must dispose animation controllers
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //This widget runs the animations
        body: AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center(
          child: Transform(
            origin: const Offset(100, 100),
            alignment: Alignment.topLeft,
            //determines the rotation angle
            //_animation.value is not fixed number and it always runs
            transform: Matrix4.identity()..rotateY(_animation.value),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red[900],
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: const Offset(0, 0.5),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
