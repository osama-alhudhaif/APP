import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final double size;
  final Color color;

  const LoadingSpinner({
    super.key,
    this.size = 50.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
