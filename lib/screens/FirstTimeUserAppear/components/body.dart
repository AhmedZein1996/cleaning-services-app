import 'package:clean_services_app/provider/gift.dart';
import 'package:clean_services_app/screens/ScratchingCards/scratching_screen.dart';
import 'package:clean_services_app/server/databases/gift_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    Provider.of<GiftProvider>(context, listen: false).fetchGifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final giftProvider = Provider.of<GiftProvider>(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            // width: size.width * 0.9,
            // height: size.height * 0.65,//
            width: size.width * 1,
            height: size.height * 1,
            child: Image.asset(
              "assets/images/first_time_screen_image.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              bottom: 150,
              right: 0,
              left: 0,
              child: giftProvider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                          ScratchingScreen.routeName,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: size.width * 0.15,
                          left: size.width * 0.15,
                          top: size.height * 0.015,
                          bottom: size.height * 0.1,
                        ),
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Text(
                            'Order cleaning',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ))
        ],
      ),
    );
  }
}
/*GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(
            right: size.width * 0.035,
            left: size.width * 0.035,
            top: size.height * 0.015,
            bottom: size.height * 0.1,
          ),
          height: size.height * 0.07,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(30)),
          child: const Center(
            child: Text(
              'Order cleaning',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      )*/
/*child: Text(
          "WELCOME",
          style: TextStyle(
              color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
        ),*/
