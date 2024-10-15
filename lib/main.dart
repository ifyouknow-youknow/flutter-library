import 'package:flutter/material.dart';
import 'package:myapp/COMPONENTS/text_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [TextView(text: 'Hello ugly people')],
        ),
      ),
    );
  }
}
