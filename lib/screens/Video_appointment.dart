import 'package:flutter/material.dart';
import 'package:hospitalms/screens/PatientHomeScreen.dart';
import 'package:hospitalms/screens/video_calling/videocall.dart';

class VideoAppointmentPage extends StatelessWidget {
  const VideoAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _roomController = TextEditingController();
    TextEditingController _usernamecontroller = TextEditingController();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0D8F83),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => PatientHomeScreen()));
          },
        ),
        title: Text("Video Appointment"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              // controller: phoneTextEditingController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xffEEEEEE),
                border: InputBorder.none,
                label: Text("Username"),
                // hintText: "Enter your name"
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // controller: phoneTextEditingController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xffEEEEEE),
                border: InputBorder.none,
                label: Text("Room ID"),
                // hintText: "Enter your name"
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(children: [
                GestureDetector(
                  onTap: () {
                    print("Button clicked");
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (ctx) => IndexPage()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Join the meeting",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}
