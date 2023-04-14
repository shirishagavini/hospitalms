import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalms/screens/AllDoctorScreenForPatient.dart';
import 'package:hospitalms/screens/PatientHomeScreen.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class PrescriptionForMedical extends StatefulWidget {
  const PrescriptionForMedical({super.key});

  @override
  State<PrescriptionForMedical> createState() => _PrescriptionForMedicalState();
}

class _PrescriptionForMedicalState extends State<PrescriptionForMedical> {
  String url = "";
  int? number;
  // uploadDataToFirebase() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   File pick = File(result!.files.single.path.toString());
  //   var file = pick.readAsBytesSync();
  //   String name = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //   var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
  //   UploadTask task = pdfFile.putData(file);
  //   TaskSnapshot snapshot = await task;
  //   url = await snapshot.ref.getDownloadURL();
  //
  //   await FirebaseFirestore.instance.collection('Medicalprescriptions').add({
  //     "UserId": user!.uid,
  //     "patient name": user.displayName,
  //     "patient email": user.email,
  //     "phone": phoneTextEditingController.text,
  //     "prescription": "",
  //   });
  // }

  TextEditingController fnameTextEditingController = TextEditingController();
  TextEditingController lnameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  // var docname = fname;


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    uploadDataToFirebase() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      File pick = File(result!.files.single.path.toString());
      var file = pick.readAsBytesSync();
      String name = DateTime.now().millisecondsSinceEpoch.toString();

      var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
      UploadTask task = pdfFile.putData(file);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('Medicalprescriptions').add({
        "UserId": user!.uid,
        "patient name": user.displayName,
        "patient email": user.email,
        "phone": phoneTextEditingController.text,
        "prescription": url,
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D8F83),
        title: const Text("Set an Appointment"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user!.uid)
                  .get(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                  margin: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  // color: Colors.black,R
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: "${snapshot.data!.get("fname") + " " + snapshot.data!.get("lname")}",
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Name"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: snapshot.data!.get("email"),
                          // controller: emailTextEditingController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Email"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: phoneTextEditingController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Phone"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  uploadDataToFirebase();
                                  print("Button pressed");
                                },
                                icon: const Icon(Icons.upload)),
                            filled: true,
                            fillColor: const Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: const Text("Upload Prescription"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => PatientHomeScreen()));
                            print("Button is clicked");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff0D8F83)),
                            height: 65,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text("Submit",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("If you already registered,"),
                        //     SizedBox(
                        //       width: 6,
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //             builder: (ctx) => const LoginPage()));
                        //         print("Routing to the login page");
                        //       },
                        //       child: Text("Sign In"),
                        //     )
                        //   ],
                        // )
                      ]),
                )
                    : const Center(
                  heightFactor: 20,
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
