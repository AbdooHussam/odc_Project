import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'ForgetPassword_Model.dart';
import 'otp/otp_screen.dart';

class ForgesPassScreen extends StatefulWidget {
  const ForgesPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgesPassScreen> createState() => _ForgesPassScreenState();
}

String email = "", pass = "";

bool showSpinner = false;
final _key = GlobalKey<FormState>();

class _ForgesPassScreenState extends State<ForgesPassScreen> {
  @override
  Widget build(BuildContext context) {
    var forget = Provider.of<ForgetPassModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFCFCFC),
          elevation: 0,
          title: const Text("Froget Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              )),
          centerTitle: true,
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  SvgPicture.asset("images/forgetPass1.svg",
                      height: MediaQuery.of(context).size.height * .335),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  const AutoSizeText(
                    "Please enter your email address to recieve vervication code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B1816)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  TextFormField(
                    onChanged: (val) {
                      email = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Feild is Required";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                        return "Email not Valid";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const SizedBox(),
                        labelText: "Email",
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB7B7B7)),
                        hintText: "*****@***.com",
                        hintStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD0D0D0)),
                        fillColor: const Color(0xFFEDEDED),
                        filled: true),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        forget.email = email;
                        await forget.forgetPass();
                        if (forget.status == true) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen()));
                        }
                      }
                    },
                    child: const Text(
                      "Send",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
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
            ),
          ),
        ));
    ;
  }
}
