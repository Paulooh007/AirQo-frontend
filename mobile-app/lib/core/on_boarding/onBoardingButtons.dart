import 'package:app/constants/app_constants.dart';
import 'package:app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingButtons extends StatelessWidget {
  OnBoardingButtons(
      {Key? key,
      required this.currentIndex,
      required this.dataLength,
      required this.controller})
      : super(key: key);

  final int currentIndex;
  final int dataLength;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: currentIndex == dataLength - 1
          ? [
              Expanded(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 70.0,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          updateFirstUse();

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.1,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // add this
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide.none),
                        child: Container(
                            child: const Text(
                          'Get started',
                          style: TextStyle(
                              fontSize: 18,
                              color: appColor,
                              fontWeight: FontWeight.w700),
                        )))),
              )
            ]
          : [
              TextButton(
                onPressed: () {
                  updateFirstUse();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut);
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
    );
  }

  Future<void> updateFirstUse() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(firstUse, false);
  }
}