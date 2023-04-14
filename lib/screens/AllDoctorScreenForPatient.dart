import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalms/screens/BookAppointmentScreen.dart';

class AllDoctorsListPage extends StatefulWidget {
  const AllDoctorsListPage({super.key});

  @override
  State<AllDoctorsListPage> createState() => _AllDoctorsListPageState();
}

class _AllDoctorsListPageState extends State<AllDoctorsListPage> {
  bool isLoading = false;
  late String fname;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // super.initState();
  //   isLoading = true;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D8F83),
        title: const Text("Available Doctors"),
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
                  .collection("users")
                  .where("role", isEqualTo: "doctor")
                  .get(),
              builder: (context, docsnapshot) {
                // print(docsnapshot.hasError);
                return docsnapshot.hasData
                    ? ListView.builder(
                        padding: EdgeInsets.only(bottom: 80),
                        scrollDirection: Axis.vertical,
                        itemCount: docsnapshot.data?.docs.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              // color: Colors.black,
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height / 4,
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
                                        MediaQuery.of(context).size.height / 7,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          margin: const EdgeInsets.all(10),
                                          child: Image.network(docsnapshot
                                              .data?.docs
                                              .elementAt(index)['image']),
                                        ),
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
                                                  docsnapshot.data?.docs
                                                          .elementAt(
                                                              index)['fname'] +
                                                      " " +
                                                      docsnapshot.data?.docs
                                                          .elementAt(
                                                              index)['lname'],
                                                  style: TextStyle(
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
                                                  docsnapshot.data?.docs
                                                      .elementAt(index)['post'],
                                                  style: TextStyle(
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
                                                          index)['specs'],
                                                  style: TextStyle(
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
                                                          index)['degree'],
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          80, 0, 0, 0),
                                                      fontFamily: 'Inter',
                                                      fontSize: 13,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ))
                                      ],
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    // color: Colors.grey,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
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
                                            child: const Text(
                                              "View Profile",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        BookAppointmentPage(
                                                            fname: docsnapshot
                                                                    .data?.docs
                                                                    .elementAt(index)[
                                                                'fname'],
                                                            lname: docsnapshot
                                                                    .data?.docs
                                                                    .elementAt(
                                                                        index)[
                                                                'lname'],
                                                            DocID: docsnapshot
                                                                .data!.docs
                                                                .elementAt(index)
                                                                .id)));
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
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xff0D8F83)),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "Appointment",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
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
    ));
  }
}
