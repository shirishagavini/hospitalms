import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalms/screens/PatientAppointmentDetailsScreen.dart';
import 'package:hospitalms/screens/video_calling/videocall.dart';

class SingleAppointmentListPage extends StatefulWidget {
  const SingleAppointmentListPage({super.key, required this.userId});
  final String userId;

  @override
  State<SingleAppointmentListPage> createState() =>
      _SingleAppointmentListPageState();
}

class _SingleAppointmentListPageState extends State<SingleAppointmentListPage>
{
  @override
  Widget build(BuildContext context)
  {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("All appointments"),
        backgroundColor: Color(0xff0D8F83),
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
                  .collection("appointments")
                  .where("UserId", isEqualTo: widget.userId)
                  .get(),
              builder: (context, docsnapshot) {
                return docsnapshot.hasData
                    ? ListView.builder(
                        padding: EdgeInsets.only(bottom: 80),
                        scrollDirection: Axis.vertical,
                        itemCount: docsnapshot.data?.docs.length,
                        // itemCount: 5,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  // color: Colors.green,
                                  child: Text(
                                    "${docsnapshot.data!.docs.elementAt(index)["appointment_date"]} | SN: ${index + 1}",
                                  ),
                                ),
                                Container(
                                  // color: Colors.black,
                                  padding: const EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 4,
                                            blurStyle: BlurStyle.outer,
                                            color: Colors.black,
                                            offset: Offset.fromDirection(1, 1))
                                      ]),
                                  child: Column(
                                    children: [
                                      Container(
                                          // color: Colors.black,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: Image.asset(
                                                    "assets/images/Rectangle 8.png"),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  // color: Colors.deepOrangeAccent,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        // "name",
                                                        docsnapshot.data?.docs
                                                                .elementAt(
                                                                    index)[
                                                            'problem'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16,
                                                            fontStyle: FontStyle
                                                                .normal),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      // Text(
                                                      //   "CLINICS",
                                                      //   style: TextStyle(
                                                      //       color: Color.fromARGB(
                                                      //           80, 0, 0, 0),
                                                      //       fontFamily: 'Inter',
                                                      //       fontSize: 13,
                                                      //       fontStyle: FontStyle.normal,
                                                      //       fontWeight: FontWeight.w400),
                                                      // ),
                                                      Text(
                                                        "AID : ${docsnapshot.data!.docs.elementAt(index).id}",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    80,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontFamily: 'Inter',
                                                            fontSize: 12,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "Schedule: ${docsnapshot.data!.docs.elementAt(index)["appointment_date"]} ${docsnapshot.data!.docs.elementAt(index)["appointment_time"]}",
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    80,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            fontFamily: 'Inter',
                                                            fontSize: 12,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          )),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              15,
                                          // color: Colors.grey,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              PatientAppointmentDetailsPage(
                                                                snapshot: docsnapshot
                                                                    .data!.docs
                                                                    .elementAt(
                                                                        index),
                                                              )));
                                                },
                                                child: Container(
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
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xffEEEEEE),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            blurStyle:
                                                                BlurStyle.inner,
                                                            color:
                                                                Colors.black54,
                                                            offset: Offset
                                                                .fromDirection(
                                                                    5, -2))
                                                      ]),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "View Details",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              VideoConference(
                                                                conferenceId:
                                                                    docsnapshot
                                                                        .data
                                                                        ?.docs
                                                                        .elementAt(
                                                                            index)['roomId'],
                                                                name: docsnapshot
                                                                    .data?.docs
                                                                    .elementAt(
                                                                        index)['doctor'],
                                                              )));
                                                },
                                                child: Container(
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
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.green,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            blurRadius: 10,
                                                            blurStyle:
                                                                BlurStyle.inner,
                                                            color:
                                                                Colors.black54,
                                                            offset: Offset
                                                                .fromDirection(
                                                                    5, -2))
                                                      ]),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "Join Meeting",
                                                      // "${docsnapshot.data?.docs.elementAt(index)['roomId']}",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ),
      ),
    );
  }
}
