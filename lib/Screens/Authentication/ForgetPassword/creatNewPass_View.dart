import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Login/Login_View.dart';
import 'ForgetPassword_Model.dart';
import 'otp/otp_screen.dart';

class CreatNewPassScreen extends StatefulWidget {
  const CreatNewPassScreen({Key? key}) : super(key: key);

  @override
  State<CreatNewPassScreen> createState() => _CreatNewPassScreenState();
}

String email = "", pass = "",pass2="";
bool securePass = true;
bool showSpinner = false;
final _key = GlobalKey<FormState>();

class _CreatNewPassScreenState extends State<CreatNewPassScreen> {
  @override
  Widget build(BuildContext context) {
    var forget = Provider.of<ForgetPassModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFCFCFC),
          elevation: 0,
          title: const Text("Create New Password",
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

                  SvgPicture.asset("images/forgetPass3.svg",
                      height: MediaQuery.of(context).size.height * .2),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  const AutoSizeText(
                    "Enter your new password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B1816)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .06),
                  TextFormField(
                    onChanged: (val) {
                      pass = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Feild is Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 25,
                          color: Color(0xFFD0D0D0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              securePass = !securePass;
                            });
                          },
                          icon: securePass
                              ? const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 20,
                            color: Color(0xFFD0D0D0),
                          )
                              : const FaIcon(
                            FontAwesomeIcons.eyeSlash,
                            size: 15,
                            color: Color(0xFFD0D0D0),
                          ),
                        ),
                        labelText: "New Password",
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD0D0D0)),

                        fillColor: const Color(0xFFF8F8F8),
                        filled: true),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: securePass,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  TextFormField(
                    onChanged: (val) {
                      pass2 = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Feild is Required";
                      } else if(pass2 != pass){
                        return "The password must be the same";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 25,
                          color: Color(0xFFD0D0D0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              securePass = !securePass;
                            });
                          },
                          icon: securePass
                              ? const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 20,
                            color: Color(0xFFD0D0D0),
                          )
                              : const FaIcon(
                            FontAwesomeIcons.eyeSlash,
                            size: 15,
                            color: Color(0xFFD0D0D0),
                          ),
                        ),
                        labelText: "Confirm Password",
                        labelStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD0D0D0)),
                        fillColor: const Color(0xFFF8F8F8),
                        filled: true),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: securePass,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .07),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        forget.pass = pass;
                        await forget.resetPass();
                        if (forget.rest_status) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
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
