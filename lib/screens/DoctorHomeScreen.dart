// import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hospitalms/screens/AllDoctorScreenForPatient.dart';
import 'package:hospitalms/screens/authentication/LoginScreen.dart';
import 'package:hospitalms/screens/DoctorAppointmentsScreen.dart';
import 'package:hospitalms/screens/PatientListScreenForDoctor.dart';
import 'package:hospitalms/screens/UpdateProfileForDoctor.dart';

import 'AppointListScreenForPatient.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      "assets/images/Rectangle 6.png",
      "assets/images/img1.jpg",
      "assets/images/img2.jpg",
      "assets/images/img3.jpg",
      "assets/images/img4.jpg",
    ];
    Widget _buildHomeBanner() {
      return Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 240,
            // color: Colors.blue,
            child: GFCarousel(
              items: imageList.map(
                (url) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      child: Image.asset(url, fit: BoxFit.cover, width: 1000.0),
                    ),
                  );
                },
              ).toList(),
              onPageChanged: (index) {},
            ),
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0D8F83),
          leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const LoginPage()));
            },
            icon: const Icon(Icons.logout),
          ),
          title: const Text("Home"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(child: _buildHomeBanner()),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    const DoctorAppointmentsPage()));
                            print("Button is pressed");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 3.45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      blurStyle: BlurStyle.inner,
                                      color: Colors.black,
                                      offset: Offset.fromDirection(10))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/calendar (1) 1.png"),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Your Appointments",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const PatientListPage()));
                            print("Button is pressed");
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 3.45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        blurStyle: BlurStyle.inner,
                                        color: Colors.black,
                                        offset: Offset.fromDirection(10))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/doctor 1.png"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Find a Patient",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    const UpdateDocProfilePage()));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 3.45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        blurStyle: BlurStyle.inner,
                                        color: Colors.black,
                                        offset: Offset.fromDirection(10))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/doctor 1.png"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Update Profile",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        // Container(
                        //     width: MediaQuery.of(context).size.width / 3.45,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(10),
                        //         boxShadow: [
                        //           BoxShadow(
                        //               blurRadius: 10,
                        //               blurStyle: BlurStyle.inner,
                        //               color: Colors.black,
                        //               offset: Offset.fromDirection(10))
                        //         ]),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Image.asset("assets/images/report 1.png"),
                        //         const SizedBox(
                        //           height: 20,
                        //         ),
                        //         const Text(
                        //           "View Lab Reports",
                        //           style: TextStyle(fontWeight: FontWeight.bold),
                        //         )
                        //       ],
                        //     )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
