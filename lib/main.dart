import 'package:aida/All%20Chat%20Features/text_with_aida.dart';
import 'package:aida/Consts/consts.dart';
import 'package:aida/onboard_screen.dart';
import 'package:aida/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  Gemini.init(
    apiKey: GEMINI_API_KEY
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardScreen(),
    );
  }
}
