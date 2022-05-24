import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../Authentication/Login/Login_View.dart';
import '../Authentication/SignUp/signUp_View.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (i == 0)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        i = 1;
                      });
                    },
                    child: Image.asset(
                      "images/on_boarding1.png",
                      height: 280,
                      width: 260,
                    ),
                  ),
                  const SizedBox(
                    width: 230,
                    height: 49,
                    child: AutoSizeText(
                      'Learn a lot of courses in Orange Education',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 40,
                    width: 240,
                    child: AutoSizeText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
                      'incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8F8F8F),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                ],
              ),
            if (i == 1)
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        i = 2;
                      });
                    },
                    child: Image.asset(
                      "images/on_boarding2.png",
                      height: 280,
                      width: 260,
                    ),
                  ),
                  const SizedBox(
                    width: 230,
                    height: 49,
                    child: AutoSizeText(
                      'Learn a lot of courses in Orange Education',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 40,
                    width: 240,
                    child: AutoSizeText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
                      'incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8F8F8F),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                ],
              ),
            if (i == 2)
              Column(
                children: [
                  Image.asset(
                    "images/on_boarding3.png",
                    height: 280,
                    width: 260,
                  ),
                  const SizedBox(
                    width: 230,
                    height: 49,
                    child: AutoSizeText(
                      'Learn a lot of courses in Orange Education',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 40,
                    width: 240,
                    child: AutoSizeText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
                      'incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8F8F8F),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 55,
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                    color: i == 0
                        ? const Color(0xFFFF6600)
                        : const Color(0xFFB7B7B7),
                  ),
                  onPressed: () {
                    setState(() {
                      i = 0;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                    color: i == 1
                        ? const Color(0xFFFF6600)
                        : const Color(0xFFB7B7B7),
                  ),
                  onPressed: () {
                    setState(() {
                      i = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                    color: i == 2
                        ? const Color(0xFFFF6600)
                        : const Color(0xFFB7B7B7),
                  ),
                  onPressed: () {
                    setState(() {
                      i = 2;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: (23 / 375.0) * MediaQuery.of(context).size.height,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: const AutoSizeText("Join Now"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(154, 50),
                          primary: const Color(0xFFFF6600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                  color: Color(0xFFFF6600), width: 2))),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * .08),
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                        },
                        child: const AutoSizeText("Log in",
                            style: TextStyle(color: Color(0xFFFF6600))),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            minimumSize:
                                MaterialStateProperty.all(const Size(154, 50)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: Color(0xFFFF6600), width: 2))))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
