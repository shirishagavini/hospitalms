import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalms/screens/LabHomeScreen.dart';
import 'package:hospitalms/screens/authentication/UserRegistrationScreen.dart';
import 'package:hospitalms/screens/DoctorHomeScreen.dart';
import 'package:hospitalms/screens/PatientHomeScreen.dart';
import 'package:hospitalms/screens/medicalHomeScreen.dart';
import 'package:hospitalms/services/AuthenticationServices.dart';

import '../../helper/HelperFunction.dart';
import '../../services/DatabaseService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String loginerror = "";

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  bool obscerText = true;
  late String email;
  late String password;
  late String role;
  late QuerySnapshot snapshotUserInfo;

  void validation() async {
    final FormState? _form = _formKey.currentState;

    if (_form!.validate()) {
      try {
        setState(
          () {
            isLoading = true;
          },
        );
        // Get UserData
        databaseMethods.getUserByUserEmail(email).then(
          (value) {
            snapshotUserInfo = value;
            // role = snapshotUserInfo.docs.elementAt(0).get("role");
            print(snapshotUserInfo.docs.elementAt(0).get("name"));
            HelperFunctions.saveUserFNameSharedPreference(
              snapshotUserInfo.docs.elementAt(0).get("name"),
            );
          },
        );

        // print("Yes");
        // print(email);
        // print(password);
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        // print(result.user!.uid);

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot value) {
          // result.user!.updateDisplayName(value['']);
          print(value.data());
          print(value.data().runtimeType);
          final data = value.data() as Map<String, dynamic>;
          final role = data['role'];
          print(role);
          if (role == "doctor") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const DoctorHomeScreen()));
          }else if (role == "lab"){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const LabHomeScreen()));
          }else if(role == "medical"){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const MedicalHomeScreen()));
          }
          else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const PatientHomeScreen()));
          }
        });

        HelperFunctions.saveUserEmailSharedPreference(
          email,
        );

        HelperFunctions.saveUserLoggedInSharedPreference(true);
        setState(
          () {
            isLoading = false;
          },
        );
        // Navigator.of(context)
        // .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
        // if (role == "doctor") {
        //   Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(builder: (ctx) => DocHomePage()));
        // } else {
        //   Navigator.of(context)
        //       .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
        // }
      } catch (e) {
        print("error");
        // print(result.user!.updateDisplayName(value['fname'])
        print(e.toString());
        String msg = e.toString();
        print(msg);
        setState(
          () {
            isLoading = false;
            loginerror =
                msg.substring(msg.indexOf("] ") + 1, msg.length - 1).trim();
          },
        );

        // Get.snackbar("Cannot Log In",
        //     msg.substring(msg.indexOf("] ") + 1, msg.length - 1).trim(),
        //     snackPosition: SnackPosition.TOP,
        //     duration: const Duration(seconds: 10),
        //     snackStyle: SnackStyle.FLOATING);
      }
    } else {
      print("No, There is some error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Column(children: [
                        Container(
                          height: 200,
                          child: Image.asset("assets/images/Frame 3.png"),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (!emailValid) {
                              // return "";
                              // } else {
                              return "Enter a valid email";
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Email"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value == "") {
                              return "Please Enter Password";
                            } else if (value!.length < 6) {
                              return "Password is too short";
                            }
                            // return "";
                          },
                          obscureText: obscerText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: const Text("Password"),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscerText = !obscerText;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Icon(
                                obscerText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            validation();
                            print("Button is clicked");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            height: 65,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text("Login",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        loginerror != ""
                            ? Text(
                                loginerror,
                                style: const TextStyle(color: Colors.red),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have a account?"),
                            const SizedBox(
                              width: 6,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            const PatientRegistrationPage()));
                                print("Routing to the Register page");
                              },
                              child: const Text("Register Now"),
                            )
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ));
  }
}
