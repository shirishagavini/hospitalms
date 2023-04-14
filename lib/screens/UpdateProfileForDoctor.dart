import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hospitalms/screens/AllDoctorScreenForPatient.dart';
import 'package:hospitalms/screens/DoctorHomeScreen.dart';
import 'package:hospitalms/screens/PatientHomeScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class UpdateDocProfilePage extends StatefulWidget {
  final String? fname;
  final String? lname;
  final String? DocID;
  const UpdateDocProfilePage({super.key, this.fname, this.lname, this.DocID});

  @override
  State<UpdateDocProfilePage> createState() => _UpdateDocProfilePageState();
}

class _UpdateDocProfilePageState extends State<UpdateDocProfilePage> {
  XFile? image;
  File? imageFile;
  String? imageUrl;
  // File file = File(videofile.path);
  // final ImagePicker picker = ImagePicker();
  final ImagePicker picker = ImagePicker();

  TextEditingController fnameTextEditingController = TextEditingController();
  TextEditingController lnameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController degreeTextEditingController = TextEditingController();
  TextEditingController postTextEditingController = TextEditingController();
  TextEditingController specsTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  // TextEditingController problemTextEditingController = TextEditingController();
  // TextEditingController dateInput = TextEditingController();
  // TextEditingController timeInput = TextEditingController();

  // GET IMAGE
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      imageFile = File(image!.path);
      print(imageFile);
    });
  }

  //IMAGE UPLOADING
  void imgAlert() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Please choose the media option'),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      Text("From camera")
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isLoading = false;
  // var docname = fname;

  @override
  void initState() {
    // dateInput.text = ""; //set the initial value of text field
    // timeInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final roomId = const Uuid().v1();
    final user = FirebaseAuth.instance.currentUser;
    void setappointment() async {
      // if (image == null) {
      //   return;
      // }

      setState(() {
        isLoading = true;
      });

      // UPLOAD IMAGE
      // Upload Image
      if (image != null) {
        final _firebaseStorage = FirebaseStorage.instance;
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/${image!.name}')
            .putFile(imageFile!);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        print("Image uploaded successfully");
      }

      print({
        "fname": fnameTextEditingController.text,
        "lname": lnameTextEditingController.text,
        "email": emailTextEditingController.text,
        "mobile": phoneTextEditingController.text,
        "degree": degreeTextEditingController.text,
        "post": postTextEditingController.text,
        "specs": specsTextEditingController.text,
        "image": imageUrl,
      });

      var collection = FirebaseFirestore.instance.collection('users');
      collection.doc(user!.uid).update({
        "fname": fnameTextEditingController.text,
        "lname": lnameTextEditingController.text,
        "mobile": phoneTextEditingController.text,
        "email": emailTextEditingController.text,
        "degree": degreeTextEditingController.text,
        "post": postTextEditingController.text,
        "specs": specsTextEditingController.text,
        "image": imageUrl,
      }) // <-- Updated data
          .then((_) {
        print("User Updated");
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const DoctorHomeScreen()));
      }).catchError(
        (error) {
          print('Failed: $error');
          setState(() {
            isLoading = false;
          });
        },
      );
      // print(widget.fname);
      // print(widget.DocID);
      // // print(user!.displayName);
      // await FirebaseFirestore.instance.collection('appointments').add({
      //   // "email": widget.user!.email,
      //   "doctor": widget.fname! + " " + widget.lname!,
      //   "doctorID": widget.DocID,
      //   "UserId": user!.uid,
      //   "patient name": user.displayName,
      //   "patient email": user.email,
      //   "phone": phoneTextEditingController.text,
      //   "problem": problemTextEditingController.text,
      //   "appointment_date": dateInput.text,
      //   "appointment_time": timeInput.text,
      //   "prescription": "",
      //   "roomId": roomId
      // });
      // print("Appointment done");
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (ctx) => const HomePage()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D8F83),
        title: const Text("Update Profile"),
      ),
      body: isLoading
          ? const Center(
              heightFactor: 20,
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(user!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        phoneTextEditingController.text =
                            snapshot.data!.get("mobile");
                        degreeTextEditingController.text =
                            snapshot.data!.get("degree");
                        postTextEditingController.text =
                            snapshot.data!.get("post");
                        specsTextEditingController.text =
                            snapshot.data!.get("specs");
                        fnameTextEditingController.text =
                            snapshot.data!.get("fname");
                        lnameTextEditingController.text =
                            snapshot.data!.get("lname");
                        emailTextEditingController.text =
                            snapshot.data!.get("email");

                        // setState(() {
                        imageUrl = snapshot.data!.get("image");
                        // });
                      }
                      return snapshot.hasData
                          ? Container(
                              margin: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              // color: Colors.black,R
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    ElevatedButton(
                                        onPressed: () {
                                          imgAlert();
                                        },
                                        child: Text("Upload profile photo")),
                                    SizedBox(height: 12),
                                    imageUrl != null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: image != null
                                                  ? Image.file(
                                                      File(image!.path),
                                                      fit: BoxFit.cover,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 300,
                                                    )
                                                  : Image.network(
                                                      imageUrl.toString(),
                                                      fit: BoxFit.cover,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 300,
                                                    ),
                                            ),
                                          )
                                        : Text(
                                            "No Image",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      // readOnly: true,
                                      // initialValue: snapshot.data!.get("fname"),
                                      // initialValue: snapshot.data!.get("fname"),
                                      controller: fnameTextEditingController,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffEEEEEE),
                                        border: InputBorder.none,
                                        label: Text("First name"),
                                        // hintText: "Enter your name"
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      // readOnly: true,
                                      // initialValue: snapshot.data!.get("lname"),
                                      controller: lnameTextEditingController,
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
                                      // initialValue: snapshot.data!.get("email"),
                                      controller: emailTextEditingController,
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
                                      // initialValue: snapshot.data!.get("mobile"),
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
                                      // initialValue: snapshot.data!.get("mobile"),
                                      controller: degreeTextEditingController,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffEEEEEE),
                                        border: InputBorder.none,
                                        label: Text("Degree"),
                                        // hintText: "Enter your name"
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      // initialValue: snapshot.data!.get("mobile"),
                                      controller: postTextEditingController,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffEEEEEE),
                                        border: InputBorder.none,
                                        label: Text("Post"),
                                        // hintText: "Enter your name"
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      // initialValue: snapshot.data!.get("mobile"),
                                      controller: specsTextEditingController,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffEEEEEE),
                                        border: InputBorder.none,
                                        label: Text("Specialization"),
                                        // hintText: "Enter your name"
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // TextFormField(
                                    //     controller: dateInput,
                                    //     decoration: InputDecoration(
                                    //         filled: true,
                                    //         fillColor: const Color(0xffEEEEEE),
                                    //         border: InputBorder.none,
                                    //         label: const Text("Select date"),
                                    //         suffixIcon: IconButton(
                                    //           onPressed: () async {
                                    //             DateTime? pickedDate =
                                    //                 await showDatePicker(
                                    //                     context: context,
                                    //                     initialDate: DateTime.now(),
                                    //                     firstDate: DateTime(1950),
                                    //                     lastDate: DateTime(2100));

                                    //             if (pickedDate != null) {
                                    //               print(pickedDate);
                                    //               String formattedDate =
                                    //                   DateFormat('dd-MM-yyyy')
                                    //                       .format(pickedDate);
                                    //               print(formattedDate);

                                    //               setState(() {
                                    //                 dateInput.text = formattedDate;
                                    //               });
                                    //             } else {}
                                    //           },
                                    //           icon: const Icon(
                                    //               Icons.calendar_month_outlined),
                                    //         ))),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // TextFormField(
                                    //     controller: timeInput,
                                    //     decoration: InputDecoration(
                                    //         filled: true,
                                    //         fillColor: const Color(0xffEEEEEE),
                                    //         border: InputBorder.none,
                                    //         label: const Text("Select Time"),
                                    //         suffixIcon: IconButton(
                                    //           onPressed: () async {
                                    //             TimeOfDay? pickedtime =
                                    //                 await showTimePicker(
                                    //                     context: context,
                                    //                     initialTime: TimeOfDay.now());

                                    //             if (pickedtime != null) {
                                    //               print(pickedtime);
                                    //               String formattedtime =
                                    //                   pickedtime.format(context);
                                    //               print(formattedtime);

                                    //               setState(() {
                                    //                 timeInput.text = formattedtime;
                                    //               });
                                    //             } else {}
                                    //           },
                                    //           icon: const Icon(
                                    //               Icons.access_time_outlined),
                                    //         ))),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    // const Text("Problem"),
                                    // TextFormField(
                                    //   // initialValue: fname,
                                    //   controller: problemTextEditingController,
                                    //   maxLines: 10,
                                    //   decoration: const InputDecoration(
                                    //       border: OutlineInputBorder()),
                                    // ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setappointment();
                                        // print("Button is clicked");
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xff0D8F83)),
                                        height: 65,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: const Text("Update Profile",
                                            style:
                                                TextStyle(color: Colors.white)),
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
