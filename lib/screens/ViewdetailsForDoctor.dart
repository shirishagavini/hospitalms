import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hospitalms/screens/ViewPDFScreen.dart';

import 'DoctorHomeScreen.dart';

class DetailsPageForDoctor extends StatefulWidget
{
  final String patient_name;
  final String patient_email;
  final String patient_problem;
  final String patient_phone;
  final snapshot;
  const DetailsPageForDoctor(
      {super.key,
      required this.patient_name,
      required this.patient_email,
      required this.patient_problem,
      required this.patient_phone,
      required this.snapshot});

  @override
  State<DetailsPageForDoctor> createState() => _DetailsPageForDoctorState();
}

class _DetailsPageForDoctorState extends State<DetailsPageForDoctor>
{
  String url = "";
  int? number;
  uploadDataToFirebase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection("appointments")
        .doc(widget.snapshot.id)
        .update({"prescription": url});
  }

  @override
  Widget build(BuildContext context)
  {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D8F83),
        title: const Text("Details"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("appointments")
                  .where("doctorId", isEqualTo: user!.uid)
                  .get(),
              builder: (context, snapshot) {
                return Container(
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
                          initialValue: widget.patient_name,
                          // controller: fnameTextEditingController,
                          decoration: const InputDecoration(
                            // filled: true,
                            // fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Patient Name"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: widget.patient_email,
                          // controller: emailTextEditingController,
                          decoration: const InputDecoration(
                            // filled: true,
                            // fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Patient Email"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.patient_phone,
                          decoration: const InputDecoration(
                            // filled: true,
                            // fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Phone"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("${widget.snapshot["appointment_date"]}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("${widget.snapshot["appointment_time"]}"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Problem"),
                        TextFormField(
                          readOnly: true,
                          initialValue: widget.patient_problem,
                          // initialValue: widget.snapshot.id,
                          // controller: problemTextEditingController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 30,
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
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.snapshot["labReport"] != ""
                              ? "Report Available"
                              : "No Lab report",
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (widget.snapshot["labReport"] == "") {
                                    return;
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => PDFView(
                                          prescriptionUrl: widget
                                              .snapshot["labReport"])));
                                  print("Button pressed");
                                },
                                icon: Icon(Icons.download)),
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Lab Reports"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.snapshot["labTests"],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Lab Test Reports"),
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () {
                            // setappointment();
                            print("Button is clicked");
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => DoctorHomeScreen()));
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
                      ]),
                );
              }),
        ),
      ),
    );
  }
}
