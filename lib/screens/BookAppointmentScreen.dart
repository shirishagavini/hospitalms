import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalms/screens/AllDoctorScreenForPatient.dart';
import 'package:hospitalms/screens/PatientHomeScreen.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BookAppointmentPage extends StatefulWidget {
  final String? fname;
  final String? lname;
  final String? DocID;
  const BookAppointmentPage({super.key, this.fname, this.lname, this.DocID});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  TextEditingController fnameTextEditingController = TextEditingController();
  TextEditingController lnameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController problemTextEditingController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  // var docname = fname;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    timeInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final roomId = const Uuid().v1();
    final user = FirebaseAuth.instance.currentUser;
    void setappointment() async {
      print(widget.fname);
      print(widget.DocID);
      // print(user!.displayName);
      await FirebaseFirestore.instance.collection('appointments').add({
        // "email": widget.user!.email,
        "doctor": widget.fname! + " " + widget.lname!,
        "doctorID": widget.DocID,
        "UserId": user!.uid,
        "patient name": user.displayName,
        "patient email": user.email,
        "phone": phoneTextEditingController.text,
        "problem": problemTextEditingController.text,
        "appointment_date": dateInput.text,
        "appointment_time": timeInput.text,
        "prescription": "",
        "labTests": "",
        "labReport": "",
        "roomId": roomId
      });
      print("Appointment done");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const PatientHomeScreen()));
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
                              TextFormField(
                                readOnly: true,
                                initialValue: widget.fname != null
                                    ? "${widget.fname} ${widget.lname}"
                                    : "",
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffEEEEEE),
                                    border: InputBorder.none,
                                    label: const Text("Select a Doctor"),
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                          Icons.arrow_circle_down_sharp),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const AllDoctorsListPage()));
                                        print("Button pressed");
                                      },
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                initialValue: snapshot.data!.get("fname"),
                                // controller: fnameTextEditingController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: InputBorder.none,
                                  label: Text("Fisrt name"),
                                  // hintText: "Enter your name"
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                initialValue: snapshot.data!.get("lname"),
                                // controller: lnameTextEditingController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: InputBorder.none,
                                  label: Text("Last Name"),
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
                                  controller: dateInput,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffEEEEEE),
                                      border: InputBorder.none,
                                      label: const Text("Select date"),
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime(2100));

                                          if (pickedDate != null) {
                                            print(pickedDate);
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(pickedDate);
                                            print(formattedDate);

                                            setState(() {
                                              dateInput.text = formattedDate;
                                            });
                                          } else {}
                                        },
                                        icon: const Icon(
                                            Icons.calendar_month_outlined),
                                      ))),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  controller: timeInput,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color(0xffEEEEEE),
                                      border: InputBorder.none,
                                      label: const Text("Select Time"),
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          TimeOfDay? pickedtime =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now());

                                          if (pickedtime != null) {
                                            print(pickedtime);
                                            String formattedtime =
                                                pickedtime.format(context);
                                            print(formattedtime);

                                            setState(() {
                                              timeInput.text = formattedtime;
                                            });
                                          } else {}
                                        },
                                        icon: const Icon(
                                            Icons.access_time_outlined),
                                      ))),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Problem"),
                              TextFormField(
                                // initialValue: fname,
                                controller: problemTextEditingController,
                                maxLines: 10,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setappointment();
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
