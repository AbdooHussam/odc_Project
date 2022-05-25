import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  bool showSpinner = false;

  late Future _future;

  Future<void> prepareData() async {
    var getExam = Provider.of<ExamModel>(context, listen: false);
    (getExam.examCard.isEmpty) ? await getExam.getExam() : null;
  }

  @override
  void initState() {
    _future = prepareData();
    super.initState();
  }

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
            title: const Text("Course Exam",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const AutoSizeText(
                          "Question",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF3A3A3A)),
                        ),
                        const SizedBox(width: 5),
                        AutoSizeText(
                          "${getExam.currentQuestion + 1}",
                          style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFF6600)),
                        ),
                        AutoSizeText(
                          "/${getExam.examCard.length}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFCCCCCC)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .06),
                      child: TweenAnimationBuilder(
                        tween: Tween(begin: 60, end: 0.0),
                        duration: const Duration(minutes: 60),
                        builder: (_, dynamic value, child) => Text(
                          "${value.toInt()} m",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                getExam.nextQ
                    ? (getExam.examCard.isEmpty)
                        ? const Center(child: CircularProgressIndicator())
                        : getExam.examCard[getExam.currentQuestion]
                    : const Center(child: const Text("data")),
              ],
            ),
          )),
    );
  }
}
