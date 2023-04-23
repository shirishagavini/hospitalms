import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hospitalms/screens/LabHomeScreen.dart';
import 'package:hospitalms/screens/UploadPrescriptionforMedical.dart';
import 'package:hospitalms/screens/Video_appointment.dart';
import 'package:hospitalms/screens/AllDoctorScreenForPatient.dart';
import 'package:hospitalms/screens/BookAppointmentScreen.dart';
import 'package:hospitalms/screens/AppointListScreenForPatient.dart';
import 'package:hospitalms/screens/allLabReportsforPatient.dart';
import 'package:hospitalms/screens/authentication/LoginScreen.dart';
import 'package:hospitalms/screens/UpdateProfileForPatient.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

final List<String> imageList = [
  "assets/images/Rectangle 6.png",
  "assets/images/Rectangle 6.png",
  "assets/images/Rectangle 6.png",
  "assets/images/Rectangle 6.png",
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
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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

class _PatientHomeScreenState extends State<PatientHomeScreen>
{
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final fname =
        FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xff0D8F83),
              ),
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(user.uid)
                      .get(),
                  builder: (context, snapshot)
                  {
                    return Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data!.get("image")),
                            minRadius: 30,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(top: 40),
                          // color: Colors.amberAccent,
                          height: MediaQuery.of(context).size.height,
                          child: Column(children: [
                            Text(
                              snapshot.data!.get("fname") +
                                  " " +
                                  snapshot.data!.get("lname"),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal),
                            ),
                            Text(
                              user.email.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            )
                          ]),
                        )
                      ],
                    );
                  }),
            ),
            ListTile(
              leading: const Icon(Icons.mode_edit_outlined),
              title: const Text('Edit Profile'),
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const UpdateProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services_outlined),
              title: const Text('Find Doctor'),
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AllDoctorsListPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_business_outlined),
              title: const Text('Book Appointment'),
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const BookAppointmentPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.today_outlined),
              title: const Text('Appointment List'),
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AppointmentListForPatients()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone_outlined),
              title: const Text('Emergency Call'),
              onTap: () async {
                final Uri emergencycalluri =
                    Uri(scheme: "tel", path: "+919770309438");
                await UrlLauncher.launchUrl(emergencycalluri);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('LogOut'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 35,
                color: Colors.grey, // Change Custom Drawer Icon Color
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.white,
        title: Image.asset("assets/images/Frame 6.png"),
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
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const BookAppointmentPage()));
                          // print("Button is pressed");
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
                                "Book an Appointment",
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
                              builder: (ctx) => const AllDoctorsListPage()));
                          // print("Button is pressed");
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
                                  "Find a Doctor",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  const AppointmentListForPatients()));
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
                              Image.asset("assets/images/to-do-list 1.png"),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Appointment List",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.amber,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri emergencycalluri =
                              Uri(scheme: "tel", path: "+919770309438");
                          await UrlLauncher.launchUrl(emergencycalluri);
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
                                Image.asset("assets/images/phone-call 1.png"),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Emergency Call",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                              builder: (ctx) => const UpdateProfilePage()));
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height / 6,
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
                              Image.asset("assets/images/report 1.png"),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "About us",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.amber,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // print("Button clicked");
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AllLabReportsPageList()));
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
                                Image.asset("assets/images/to-do-list 1.png"),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "View Lab Report",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // print("Button clicked");
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => PrescriptionForMedical()));
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
                                Image.asset("assets/images/to-do-list 1.png"),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Upload Prescription for medical",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
