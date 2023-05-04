import 'package:flutter/src/widgets/framework.dart';
import 'package:hospitalms/screens/authentication/UserRegistrationScreen.dart';

import '../screens/authentication/LoginScreen.dart';

// import '../screens/signup.dart';

class Authenticate extends StatefulWidget
{
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? const LoginPage() : const PatientRegistrationPage();
  }
}
