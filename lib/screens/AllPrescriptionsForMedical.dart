import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalms/screens/BookAppointmentScreen.dart';

import 'ViewPDFScreen.dart';

class AllPrescriptionForMedical extends StatefulWidget {
  const AllPrescriptionForMedical({super.key});

  @override
  State<AllPrescriptionForMedical> createState() => _AllPrescriptionForMedicalState();
}

class _AllPrescriptionForMedicalState extends State<AllPrescriptionForMedical> {
  bool isLoading = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // super.initState();
  //   isLoading = true;
  // }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff0D8F83),
            title: const Text("Prescriptions"),
          ),
          body: SingleChildScrollView(
            // scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Medicalprescriptions")
                      .get(),
                  builder: (context, docsnapshot) {
                    // print(docsnapshot.hasError);
                    return docsnapshot.hasData
                        ? ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      scrollDirection: Axis.vertical,
                      itemCount: docsnapshot.data?.docs.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            // color: Colors.black,
                            padding: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              Container(
                                // color: Colors.black,
                                  width:
                                  MediaQuery.of(context).size.width / 1.1,
                                  height:
                                  MediaQuery.of(context).size.height / 10,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                          padding:
                                          const EdgeInsets.only(top: 20),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              2.3,
                                          // color: Colors.deepOrangeAccent,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Patient: ${docsnapshot.data?.docs
                                                    .elementAt(
                                                    index)['patient name']}",
                                                style: const TextStyle(
                                                    fontFamily: 'Arial',
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontSize: 16,
                                                    fontStyle:
                                                    FontStyle.normal),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                // "TEst",
                                                docsnapshot.data?.docs
                                                    .elementAt(
                                                    index)['patient email'],
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        80, 0, 0, 0),
                                                    fontFamily: 'Inter',
                                                    fontSize: 13,
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              Text(
                                                docsnapshot.data?.docs
                                                    .elementAt(
                                                    index)['prescription'] != "" ? "Report uploaded" : "No Report available",
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        80, 0, 0, 0),
                                                    fontFamily: 'Inter',
                                                    fontSize: 13,
                                                    fontStyle:
                                                    FontStyle.normal,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                              // Text(
                                              //   docsnapshot.data?.docs
                                              //       .elementAt(
                                              //       index)['degree'],
                                              //   style: const TextStyle(
                                              //       color: Color.fromARGB(
                                              //           80, 0, 0, 0),
                                              //       fontFamily: 'Inter',
                                              //       fontSize: 13,
                                              //       fontStyle:
                                              //       FontStyle.normal,
                                              //       fontWeight:
                                              //       FontWeight.w400),
                                              // ),
                                            ],
                                          ))
                                    ],
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap:() {
                                  if (docsnapshot.data?.docs
                                      .elementAt(
                                      index)['labReport'] == ""){
                                    return;
                                  }
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => PDFView(
                                          prescriptionUrl: docsnapshot.data?.docs
                                              .elementAt(
                                              index)['labReport'])));},
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width / 2,
                                  height:
                                  MediaQuery.of(context).size.height / 15,
                                  // color: Colors.grey,
                                  child:
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width /
                                        2.5,
                                    height: MediaQuery.of(context)
                                        .size
                                        .height /
                                        15,
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: const Color(0xffEEEEEE),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              blurStyle: BlurStyle.inner,
                                              color: Colors.black54,
                                              offset:
                                              Offset.fromDirection(
                                                  5, -2))
                                        ]),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        docsnapshot.data?.docs
                                            .elementAt(
                                            index)['prescription'] == "" ?
                                        "No Prescription" : "View Prescription",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  //
                                ),
                              ),
                            ]),
                          ),
                        );
                      },
                    )
                        : const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ),
        ));
  }
}
