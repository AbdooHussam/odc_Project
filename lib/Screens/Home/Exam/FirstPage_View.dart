import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:odc/Screens/Home/Exam/Exam_View.dart';
import 'package:odc/Screens/Home/Home/NavBar_Screen.dart';
import 'package:provider/provider.dart';

class FirstExamScreen extends StatelessWidget {
  FirstExamScreen({Key? key}) : super(key: key);

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var getExam = Provider.of<ExamModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Nav_Home()),
                      ModalRoute.withName('/'));
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            backgroundColor: const Color(0xFFFCFCFC),
            elevation: 0,
            title: const Text("Course Exam",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column( crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset("images/Process.svg"),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                const AutoSizeText(
                  "Learn UI/UX for Beginners", textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1816)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                SvgPicture.asset("images/fExamPage.svg"),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                const AutoSizeText(
                  "Start your exam", textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1816)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                const AutoSizeText(
                  "Make Sure to Achieve More Than 60% ", textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1B1816)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Exam Time",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3A3A3A)),
                    ),
                    const Text(
                      "1 Hr",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3A3A3A)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const ExamScreen()));
                  },
                  child: const Text(
                    "Start",
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
