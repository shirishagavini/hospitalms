import 'package:flutter/material.dart';

class ChangeScreen extends StatelessWidget {
  const ChangeScreen(
      {required this.name,
      required this.whichAccount,
      required this.onTap,
      super.key});

  final String name;
  final Function onTap;
  final String whichAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Text(
            whichAccount,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const SignUp(),
              //   ),
              // );
              onTap();
            },
            child: Text(
              name,
              style: TextStyle(
                color: Colors.orangeAccent.shade400,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
