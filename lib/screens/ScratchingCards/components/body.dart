import 'dart:developer';

import 'package:clean_services_app/provider/gift.dart';
import 'package:clean_services_app/screens/Home/home_screen.dart';
import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/widgets.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Body> {
  ConfettiController? _controller;
  bool isFinished = false;
  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final gift = Provider.of<GiftProvider>(context, listen: false).gift;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Scratcher(
                brushSize: 50,
                threshold: 75,
                color: Colors.red,
                image: Image.asset(
                  "assets/images/outerimage.png",
                  fit: BoxFit.fill,
                ),
                onChange: (value) => log("Scratch progress: $value%"),
                onThreshold: () {
                  _controller!.play();
                  CachedHelper.putBool("isTakeGift", true);
                  log("Finishhhhhhhhhhhhhhhhhhhhhhhhhhhhed");
                  setState(() {
                    isFinished = true;
                  });
                },
                child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/newimage.png",
                        fit: BoxFit.contain,
                        width: 150,
                        height: 150,
                      ),
                      Column(
                        children: [
                          ConfettiWidget(
                            blastDirectionality: BlastDirectionality.explosive,
                            confettiController: _controller!,
                            particleDrag: 0.05,
                            emissionFrequency: 0.05,
                            numberOfParticles: 100,
                            gravity: 0.05,
                            shouldLoop: false,
                            colors: const [
                              Colors.green,
                              Colors.red,
                              Colors.yellow,
                              Colors.blue,
                            ],
                          ),
                          const Text(
                            "You won",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            gift.name == "discount"
                                ? "${gift.name} : ${gift.discount} USD"
                                : "${gift.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.030,
              ),
              if (isFinished)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      right: width * 0.165,
                      left: width * 0.165,
                      top: height * 0.015,
                      bottom: height * 0.1,
                    ),
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text(
                        'continue',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
