import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Heading extends StatefulWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    String? mail = auth.currentUser!.email;
    return Column(
      children: [
        const Text(
          "Welcome",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "$mail",
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
