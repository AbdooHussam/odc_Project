import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:odc/Screens/Home/Exam/Exam_View.dart';
import 'package:odc/Screens/Home/Home/NavBar_Screen.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getExam = Provider.of<ExamModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFCFCFC),
            elevation: 0,
            title: const Text("Process Completed",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //SizedBox(height: MediaQuery.of(context).size.height * .02),
                AutoSizeText(
                  "${getExam.message_subExam}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1816)),
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * .06),
                Text(
                  "Your Mark=  ${getExam.subMark}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3A3A3A)),
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * .06),
                Text(
                  "Status=  ${getExam.subStatus}",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3A3A3A)),
                ),
                //  SizedBox(height: MediaQuery.of(context).size.height * .25),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Nav_Home()),
                        ModalRoute.withName('/'));
                  },
                  child: const Text(
                    "Back to Home",
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
