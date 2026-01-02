import 'package:flutter/material.dart';

void main() {
  runApp(Awallimna());
}

// ignore: use_key_in_widget_constructors
class Awallimna extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('قلم'),
          // iconx
        ),
        body: Center(
          child: Text('مرحبا بكم في قلم'),
        ),
      ),
    );
  }
}