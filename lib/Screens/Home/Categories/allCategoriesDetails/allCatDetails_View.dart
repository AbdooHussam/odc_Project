import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../Categories_Model.dart';

class AllCatDetails extends StatefulWidget {
  const AllCatDetails({Key? key}) : super(key: key);

  @override
  State<AllCatDetails> createState() => _AllCatDetailsState();
}

class _AllCatDetailsState extends State<AllCatDetails> {
  bool showSpinner = false;

  late Future _future;

  Future<void> prepareData() async {
    var get_Courses = Provider.of<CategoriesModel>(context, listen: false);
    (get_Courses.catDetails.isEmpty)
        ? await get_Courses.getCategoriesDetails()
        : null;
  }

  @override
  void initState() {
    _future = prepareData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getCat = Provider.of<CategoriesModel>(context);
    return WillPopScope(
      onWillPop: () async {
        getCat.catDetails.clear();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("${getCat.category_name}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  getCat.catDetails.clear();
                  Navigator.pop(context);
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
          ),
          body: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 25,
                        color: Color(0xFFD0D0D0),
                      ),
                      labelText: "Search",
                      labelStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD0D0D0)),
                      fillColor: const Color(0xFFF8F8F8),
                      filled: true),
                  style:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.name,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.07),
              (getCat.catDetails.isEmpty)
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          // padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                          itemCount: getCat.catDetails.length,
                          itemBuilder: (context, index) {
                            return getCat.catDetails[index];
                          }),
                    )
            ],
          )),
    );
  }
}
