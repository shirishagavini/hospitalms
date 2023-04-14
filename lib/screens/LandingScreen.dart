import 'package:flutter/material.dart';
import 'package:hospitalms/screens/authentication/LoginScreen.dart';
import 'package:hospitalms/screens/authentication/UserRegistrationScreen.dart';
import 'package:hospitalms/screens/PatientHomeScreen.dart';
// import 'package:lottie/lottie.dart';

class HospitalLandingPage extends StatelessWidget {
  const HospitalLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 150),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(50),
                  child: Image.asset("assets/images/Frame 3.png")),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 60,
                  width: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => const LoginPage()));
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  )),
            ],
          )),
    );
  }
}
