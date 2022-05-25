import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:odc/Screens/Home/Exam/Exam_View.dart';
import 'package:odc/Screens/Home/Home/NavBar_Screen.dart';
import 'package:provider/provider.dart';

import 'WaitingResult_View.dart';

class HrInterView extends StatelessWidget {
  const HrInterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var getExam = Provider.of<ExamModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFCFCFC),
            elevation: 0,
            title: const Text("HR interview",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset("images/Process2.svg"),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SvgPicture.asset("images/HrPage2.svg",
                    height: MediaQuery.of(context).size.height * .335),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                const AutoSizeText(
                  "Wait for the Call",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1816)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                const AutoSizeText(
                  "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit, sed do ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1B1816)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WaitingResult()));
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      primary: const Color(0xFFFF6600),
                      minimumSize: const Size(0, 50),
                      // onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          )),
    );
  }
}
