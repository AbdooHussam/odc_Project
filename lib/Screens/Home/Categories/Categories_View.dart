import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:odc/Screens/Home/Home_View.dart';
import 'package:provider/provider.dart';

import '../NavBar_Screen.dart';
import 'Categories_Model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool showSpinner = false;

  bool pizza = true,
      burger = false,
      pasta = false,
      kids_meals = false,
      snacks = false;

  Future<void> prepareData() async {
    var categ = Provider.of<CategoriesModel>(context, listen: false);
    (categ.categList.isEmpty) ? await categ.getCategories(allCat: true) : null;
  }

  @override
  void initState() {
    super.initState();
    prepareData();
  }

  @override
  Widget build(BuildContext context) {
    var categ = Provider.of<CategoriesModel>(context);
    return WillPopScope(
      onWillPop: () async {
        categ.categList.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Nav_Home()),
            ModalRoute.withName('/'));
        return true ;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Categories",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              )),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                categ.categList.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Nav_Home()),
                    ModalRoute.withName('/'));
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
        ),
        body: ModalProgressHUD(
          inAsyncCall: categ.categList.isEmpty ? true : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: (pizza)
                ? GridView.builder(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .05),
                    itemCount: categ.categList.length,
                    itemBuilder: (context, index) {
                      return categ.categList[index];
                    },
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio:
                          MediaQuery.of(context).size.height * 0.0016,
                    ))
                : const Center(
                    child: Text(
                    "Empty Page",
                    style: TextStyle(fontSize: 30),
                  )),
          ),
        ),
      ),
    );
  }
}
