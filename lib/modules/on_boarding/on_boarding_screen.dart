import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/boarding_model.dart';
import '../../shared/network/local/cache_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/1.png',
        title: "On Board 1 Title",
        body: "On Board 1 Body"),
    BoardingModel(
        image: 'assets/images/2.png',
        title: "On Board 2 Title",
        body: "On Board 2 Body"),
    BoardingModel(
        image: 'assets/images/3.png',
        title: "On Board 3 Title",
        body: "On Board 3 Body"),
  ];

  bool isLast = false;
  var boardController = PageController();

  void submit(){
    CacheHelper.putData(key: "isFirstTime", value: false).then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                "Skip",
                style: TextStyle(fontSize: 20,color: defaultColor),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 30, 25, 30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => boardingBuilder(index),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 6,
                    expansionFactor: 4,
                  ),
                  // effect:  CustomizableEffect(
                  //     activeDotDecoration: DotDecoration(
                  //   color: defaultColor,
                  //       width: 32,
                  //       height: 12,
                  //       rotationAngle: 180,
                  //       borderRadius: BorderRadius.circular(24),
                  //       verticalOffset: -1,
                  //     ),
                  //     dotDecoration:DotDecoration(
                  //       width: 24,
                  //       height: 12,
                  //       color: Colors.grey,
                  //       borderRadius: BorderRadius.circular(16),
                  //       verticalOffset: 0,
                  //     ),
                  //   spacing: 6.0,
                  // ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boardingBuilder(int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(boarding[index].image))),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              boarding[index].title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              boarding[index].body,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
}
