import 'package:aida/All%20Chat%20Features/text_with_aida.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SelectionScreen extends StatefulWidget {
  SelectionScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<SelectionScreen> {
  void _performAction() {
    // Navigate to the new screen
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        child: const TextChat(),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Select Chat Feature'),
        backgroundColor: Color.fromARGB(255, 237, 244, 245),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _performAction,
                  child: Hero(
                    tag: 'imageHero',
                    child: Image.asset('images/young_yeti.png'), // Make sure this path is correct
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _buildAnimatedButton("Video Chatbot", const Offset(100, 0), () {
                      // Add functionality for Video Chatbot button if needed
                    }),
                    const SizedBox(height: 10),
                    _buildAnimatedButton("Text with AIDA", const Offset(-100, 0), _performAction),
                    const SizedBox(height: 10),
                    _buildAnimatedButton("Voice Chat with AIDA", const Offset(100, 0), () {
                      // Add functionality for Voice Chat with AIDA button if needed
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton(String title, Offset offset, VoidCallback onPressed) {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 1),
      tween: Tween(begin: const Offset(0, 0), end: offset),
      curve: Curves.easeInOut,
      builder: (context, Offset value, child) {
        return Transform.translate(
          offset: value,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
              shadowColor: Colors.grey.withOpacity(0.5),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}


