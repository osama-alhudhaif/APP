import 'package:flutter/material.dart';
import 'other_account_screen.dart';

class WriterProfileScreen extends StatelessWidget {
  final int userId;

  const WriterProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return OtherAccountScreen(userId: userId);
  }
}
