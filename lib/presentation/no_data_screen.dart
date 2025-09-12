import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const SizedBox.shrink(),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'No data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
