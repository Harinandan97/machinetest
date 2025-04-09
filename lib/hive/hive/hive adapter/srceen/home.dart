import 'package:flutter/material.dart';

class homhi extends StatefulWidget {
  final String email;
  const homhi({Key? key, required this.email});

  @override
  State<homhi> createState() => _homhiState();
}

class _homhiState extends State<homhi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(children: [
        Center(child: Text("welcome"),)
      ],),
    );
  }
}
