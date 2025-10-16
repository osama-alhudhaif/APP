import 'package:flutter/material.dart';

class OtherAccountScreen extends StatelessWidget {
  const OtherAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Account'),
      ),
      body: Center(
        child: Text(
          'Other Account Screen',
          style: TextStyle(
            fontSize: size.width * 0.05,
          ),
        ),
      ),
    );
  }
}
