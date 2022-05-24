import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'Categories/Categories_Model.dart';
import 'Categories/Categories_View.dart';
import 'Home_Model.dart';
import 'New_Courses/Courses_View.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<FormState>();
  String courseCode = "";

  late Future _future;

  Future<void> prepareData() async {
    var cours = Provider.of<HomeModel>(context, listen: false);
    var categ = Provider.of<CategoriesModel>(context, listen: false);
    (categ.categList.isEmpty) ? await categ.getCategories() : null;
    (cours.coursList.isEmpty) ? await cours.getCourses() : null;
  }

  @override
  void initState() {
    _future = prepareData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cours = Provider.of<HomeModel>(context);
    var categ = Provider.of<CategoriesModel>(context);
    return Scaffold(
      appBar: AppBar(
          title: Image.asset("images/homeLogo.png"),
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: MediaQuery.of(context).size.height * .245,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.red,
                    width: 8,
                  ),
                ),
                color: Color(0xFF1B1816),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _key,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Enter the code to\n Get your course",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Flexible(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * .04),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                onChanged: (val) {
                                  courseCode = val;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Feild is Required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    prefixIcon: const SizedBox(),
                                    labelText: "Enter code",
                                    labelStyle: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF636363)),
                                    fillColor: const Color(0xFF2B2B2B),
                                    filled: true),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .05),
                            CircleAvatar(
                              backgroundColor: const Color(0xFFFF6600),
                              child: IconButton(
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {}
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Top Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              TextButton(
                  onPressed: () {
                    categ.categList.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoriesScreen()));
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                        color: Color(0xFF1B1816),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  )),
            ],
          ),
          (categ.categList.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: categ.categList,
                ),
          SizedBox(height: MediaQuery.of(context).size.height * .03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("New Courses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewCoursesScreen()));
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                        color: Color(0xFFFF6600),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  )),
            ],
          ),
          (cours.coursList.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cours.coursList,
                  ),
                ),
          SizedBox(height: 30),
        ]),
      ),
    );
  }
}
