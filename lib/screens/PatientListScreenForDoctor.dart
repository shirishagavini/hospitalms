import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospitalms/screens/AppointListScreenForPatient.dart';
import 'package:hospitalms/screens/singleappointmentlist.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  Widget patientfiler(BuildContext context, String userId) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: userId)
            .get(),
        builder: (context, usersnapshot) {
          return usersnapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.black,
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(border: Border.all(), boxShadow: [
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
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 7,
                                child: Row(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      margin: const EdgeInsets.all(10),
                                      child: Image.network(usersnapshot.data?.docs.elementAt(0)['image']),
                                      // child: Image.asset(
                                      //     "assets/images/Rectangle 8.png"),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(top: 20),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        // color: Colors.deepOrangeAccent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              // "name",
                                              "${usersnapshot.data?.docs.elementAt(0)['fname']} ${usersnapshot.data?.docs.elementAt(0)['lname']}",
                                              style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              usersnapshot.data?.docs
                                                  .elementAt(0)['email'],
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      80, 0, 0, 0),
                                                  fontFamily: 'Inter',
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "phone : ${usersnapshot.data!.docs.elementAt(0)["mobile"]}",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      80, 0, 0, 0),
                                                  fontFamily: 'Inter',
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Schedule: 12:00:00 15:00:00",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      80, 0, 0, 0),
                                                  fontFamily: 'Inter',
                                                  fontSize: 13,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ))
                                  ],
                                )),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: MediaQuery.of(context).size.height / 15,
                                // color: Colors.grey,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    SingleAppointmentListPage(
                                                        userId: userId)));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        height:
                                            MediaQuery.of(context).size.height /
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
                                                  offset: Offset.fromDirection(
                                                      5, -2))
                                            ]),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "View all appointments",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  heightFactor: 20,
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    List list = [];
    List list2 = [];
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Patients"),
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
                  .where("doctorID", isEqualTo: user!.uid)
                  .get(),
              builder: (context, docsnapshot) {
                if (docsnapshot.hasData) {
                  for (int i = 0; i < docsnapshot.data!.docs.length; i++) {
                    print("${docsnapshot.data!.docs.elementAt(i)["UserId"]}");
                    print(list.contains(
                        docsnapshot.data!.docs.elementAt(i)["UserId"]));
                    list.add(docsnapshot.data!.docs
                        .elementAt(i)["UserId"]
                        .toString());
                  }
                  // print(list.toSet().toList());
                  list2 = list.toSet().toList();
                  print(list2);
                }
                return list2.isEmpty
                    ? Center(
                        child: Text("No Patient found"),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 80),
                        scrollDirection: Axis.vertical,
                        itemCount: list2.length,
                        itemBuilder: (ctx, index) {
                          return patientfiler(context, list2.elementAt(index));
                        },
                      );
              }),
        ),
      ),
    );
  }
}
