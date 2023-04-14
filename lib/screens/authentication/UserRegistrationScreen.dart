import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalms/screens/authentication/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hospitalms/screens/PatientHomeScreen.dart';
import 'package:hospitalms/services/AuthenticationServices.dart';
import 'package:hospitalms/services/DatabaseService.dart';
import 'package:image_picker/image_picker.dart';

import '../../helper/HelperFunction.dart';

class PatientRegistrationPage extends StatefulWidget {
  const PatientRegistrationPage({super.key});

  @override
  State<PatientRegistrationPage> createState() =>
      _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  XFile? image;
  File? imageFile;
  String? imageUrl;
  // File file = File(videofile.path);
  // final ImagePicker picker = ImagePicker();
  final ImagePicker picker = ImagePicker();

  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController lnameTextEditingController = TextEditingController();

  // GET IMAGE
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      imageFile = File(image!.path);
      print(imageFile);
    });
  }

  //IMAGE UPLOADING
  void imgAlert() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Please choose the media option'),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      Text("From camera")
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isLoading = false;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscerText = true;
  late String email;
  late String password;
  late String repassword;
  late String fname;
  late String lname;

  void validation() async {
    final FormState? _form = _formKey.currentState;

    FirebaseAuth _auth = FirebaseAuth.instance;

    if (_form!.validate() && image != null) {
      try {
        setState(
          () {
            isLoading = true;
          },
        );

        // UPLOAD IMAGE
        // Upload Image
        // if (image != null) {
        final _firebaseStorage = FirebaseStorage.instance;
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/${image!.name}')
            .putFile(imageFile!);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        print("Image uploaded successfully");
        // }

        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        HelperFunctions.saveUserEmailSharedPreference(
          email,
        );
        HelperFunctions.saveUserFNameSharedPreference(
          fname,
        );
        HelperFunctions.saveUserLNameSharedPreference(
          lname,
        );
        // print(result.user!.uid);
        String fullname = "${fname} ${lname}";
        result.user!.updateDisplayName(fullname);

        // Create USer
        FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({
          "fname": fname,
          "lname": lname,
          "email": email,
          "uid": result.user!.uid,
          "role": "patient",
          "mobile": mobileTextEditingController.text,
          // "imgName": image!.name,
          "image": imageUrl,
        });

        HelperFunctions.saveUserLoggedInSharedPreference(true);

        setState(
          () {
            isLoading = false;
          },
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => PatientHomeScreen()));
      } catch (e) {
        // print("error");
        print(e.toString());
        String msg = e.toString();
        setState(
          () {
            isLoading = false;
          },
        );
        Get.snackbar("Cannot Sign Up",
            msg.substring(msg.indexOf("] ") + 1, msg.length - 1).trim(),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 2),
            snackStyle: SnackStyle.GROUNDED);
      }
    } else {
      print("Form has not been successfully submitted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    // color: Colors.black,R
                    child: Column(children: [
                      Container(
                        height: 200,
                        child: Image.asset("assets/images/Frame 3.png"),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                          onPressed: () {
                            imgAlert();
                          },
                          child: Text("Upload profile photo")),
                      SizedBox(height: 12),
                      image != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                ),
                              ),
                            )
                          : Text(
                              "No Image",
                              style: TextStyle(fontSize: 20),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          onChanged: (value) {
                            setState(() {
                              fname = value;
                            });
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("First name"),
                            // hintText: "Enter your name"
                          ),
                          validator: (value) {
                            if (value == '') {
                              return "Please Enter first name";
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          onChanged: (value) {
                            setState(() {
                              lname = value;
                            });
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Last name"),
                            // hintText: "Enter your name"
                          ),
                          validator: (value) {
                            if (value == '') {
                              return "Please Enter last name";
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEEEEEE),
                          border: InputBorder.none,
                          label: Text("Eamil"),
                        ),
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: mobileTextEditingController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEEEEEE),
                          border: InputBorder.none,
                          label: Text("Mobile"),
                          // hintText: "Enter your name"
                        ),
                        validator: (mobileTextEditingController) {
                          if (mobileTextEditingController == null ||
                              mobileTextEditingController.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
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
                        },
                        obscureText: obscerText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEEEEEE),
                          border: InputBorder.none,
                          label: Text("Password"),
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
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            repassword = value;
                          });
                        },
                        validator: (value) {
                          String error = "";

                          if (image == null) {
                            error += "No Image ";
                          }
                          if (value == "") {
                            return error + "Please Enter Password";
                          }
                          if (value != password) {
                            return error + "Passwords Don't match";
                          }
                          if (image == null) {
                            return "No Image Selected";
                          }

                          // if (image != null && value == "") {
                          //   return "No Image & Please Enter Password";
                          // }

                          // if (value == "") {
                          //   return "Please Enter Password";
                          // }
                          // // else if (value!.length < 6) {
                          // //   return "Password is too short";
                          // // }
                          // else if (value != password) {
                          //   return "Passwords Dont match";
                          // }
                        },
                        obscureText: obscerText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEEEEEE),
                          border: InputBorder.none,
                          label: Text("Confirm Password"),
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
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Button is clicked");
                        },
                        child: GestureDetector(
                          onTap: () {
                            print("Button is clicked");
                            validation();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            height: 65,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text("Sign Up",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("If you already registered,"),
                          SizedBox(
                            width: 6,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) => const LoginPage()));
                              print("Routing to the login page");
                            },
                            child: Text("Sign In"),
                          )
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
    );
  }
}
