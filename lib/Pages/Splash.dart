import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'MusicList.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MusicList()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/logo.png")
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                padding: EdgeInsets.only(top: 700),

                child: const Text(
                  "CopyRight Concerto Buddy Inc -Emma Wang",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}