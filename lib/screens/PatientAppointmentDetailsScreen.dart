import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalms/screens/ViewPDFScreen.dart';

class PatientAppointmentDetailsPage extends StatefulWidget {
  final snapshot;
  const PatientAppointmentDetailsPage({super.key, required this.snapshot});

  @override
  State<PatientAppointmentDetailsPage> createState() =>
      PatientAppointmentDetailsPageState();
}

class PatientAppointmentDetailsPageState
    extends State<PatientAppointmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
                  .where("UserId", isEqualTo: user!.uid)
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
                          initialValue: "${widget.snapshot["patient name"]}",
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
                          initialValue: "${widget.snapshot["patient email"]}",
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
                          initialValue: "${widget.snapshot["phone"]}",
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
                          initialValue: "${widget.snapshot["problem"]}",
                          // controller: problemTextEditingController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          initialValue: widget.snapshot["prescription"] != ""
                              ? "Prescription Available"
                              : "No prescription",
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (widget.snapshot["prescription"] == "") {
                                    return;
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => PDFView(
                                          prescriptionUrl: widget
                                              .snapshot["prescription"])));
                                  print("Button pressed");
                                },
                                icon: const Icon(Icons.download)),
                            filled: true,
                            fillColor: const Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: const Text("Your Presricption"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.snapshot["labReport"] != ""
                              ? "Report Available"
                              : "No Report",
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
                                icon: const Icon(Icons.download)),
                            filled: true,
                            fillColor: const Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: const Text("Your Report"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          enabled: false,
                          initialValue: widget.snapshot["labTests"],
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffEEEEEE),
                            border: InputBorder.none,
                            label: Text("Lab test Name"),
                            // hintText: "Enter your name"
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     // setappointment();
                        //     print("Button is clicked");
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: const Color(0xff0D8F83)),
                        //     height: 65,
                        //     width: double.infinity,
                        //     alignment: Alignment.center,
                        //     child: const Text("Submit",
                        //         style: TextStyle(color: Colors.white)),
                        //   ),
                        // ),
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
