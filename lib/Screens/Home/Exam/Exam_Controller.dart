import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:provider/provider.dart';

import '../Home/NavBar_Screen.dart';

class questionCard extends StatefulWidget {
  const questionCard(
      {Key? key,
      this.question_id,
      this.question,
      this.question_mark,
      this.answer_1,
      this.answer_2,
      this.answer_3,
      this.answer_4,
      this.correct_answer,
      this.exam_id})
      : super(key: key);
  final String? question_id,
      question,
      question_mark,
      answer_1,
      answer_2,
      answer_3,
      answer_4,
      correct_answer,
      exam_id;

  @override
  State<questionCard> createState() => _questionCardState();
}

class _questionCardState extends State<questionCard> {
  @override
  Widget build(BuildContext context) {
    var getExam = Provider.of<ExamModel>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height*.7,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height *.075,
            child: AutoSizeText(widget.question!,maxLines: 3,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFF6600), width: 2),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .008,
                  horizontal: MediaQuery.of(context).size.width * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: AutoSizeText(widget.answer_1!,maxLines: 3,
                          style: TextStyle(fontSize: 15))),
                  Radio(
                    value: 1,
                    activeColor: Color(0xFFFF6600),
                    groupValue: getExam.radioValue,
                    onChanged: (value) {
                      setState(() {
                        getExam.radioValue = value;
                      });
                    },
                  ), //
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFF6600), width: 2),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .008,
                  horizontal: MediaQuery.of(context).size.width * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: AutoSizeText(widget.answer_2!,maxLines: 3,
                          style: TextStyle(fontSize: 15))),
                  Radio(
                    value: 2,
                    activeColor: Color(0xFFFF6600),
                    groupValue: getExam.radioValue,
                    onChanged: (value) {
                      setState(() {
                        getExam.radioValue = value;
                      });
                    },
                  ), //
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFF6600), width: 2),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .008,
                  horizontal: MediaQuery.of(context).size.width * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: AutoSizeText(widget.answer_3!,maxLines: 3,
                        style: TextStyle(fontSize: 15)),
                  ),
                  Radio(
                    value: 3,
                    activeColor: Color(0xFFFF6600),
                    groupValue: getExam.radioValue,
                    onChanged: (value) {
                      setState(() {
                        getExam.radioValue = value;
                      });
                    },
                  ), //
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFFF6600), width: 2),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .008,
                  horizontal: MediaQuery.of(context).size.width * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: AutoSizeText(widget.answer_4!,maxLines: 3,
                          style: TextStyle(fontSize: 15))),
                  Radio(
                    value: 4,
                    activeColor: Color(0xFFFF6600),
                    groupValue: getExam.radioValue,
                    onChanged: (value) {
                      setState(() {
                        getExam.radioValue = value;
                      });
                    },
                  ), //
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () async {
                if (getExam.radioValue != 0) {
                  if (getExam.radioValue == 1) {
                    getExam.userAnswer.add("answer_1");
                  }
                  if (getExam.radioValue == 2) {
                    getExam.userAnswer.add("answer_2");
                  }
                  if (getExam.radioValue == 3) {
                    getExam.userAnswer.add("answer_3");
                  }
                  if (getExam.radioValue == 4) {
                    getExam.userAnswer.add("answer_4");
                  }
                  await getExam.nextQuestion();
                } else {
                  Fluttertoast.showToast(
                    msg: "Please choose an answer first",
                    fontSize: 15,
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 10,
                  );
                }

                if (getExam.currentQuestion == getExam.examCard.length) {
                   await getExam.submitExam();
                   Future.delayed(const Duration(seconds: 1), () {
                     Navigator.pushAndRemoveUntil(
                         context,
                         MaterialPageRoute(
                             builder: (BuildContext context) => Nav_Home()),
                         ModalRoute.withName('/'));
                   });

                }
              },
              child: Text(
                (getExam.currentQuestion +1 == getExam.examCard.length)
                    ? "Finish"
                    : "Next",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: getExam.radioValue == 0
                        ? Color(0xFF7D7D7D)
                        : Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 15,
                  primary: getExam.radioValue == 0
                      ? Color(0xFFB7B7B7)
                      : Color(0xFFFF6600),
                  minimumSize: Size(150, 43),
                  // onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }
}
