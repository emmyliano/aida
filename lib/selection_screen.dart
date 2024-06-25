import 'package:aida/All%20Chat%20Features/text_with_aida.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

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
  

  final List<FuzzyContainers> categories = [
    FuzzyContainers(textData: 'Love', colorData: Colors.purple[100]!, iconData: Icons.favorite),
    FuzzyContainers(textData: 'Friend', colorData: Colors.amber[100]!, iconData: Icons.people),
    FuzzyContainers(textData: 'Learn', colorData: Colors.pink[100]!, iconData: Icons.book),
    const FuzzyContainers(textData: 'Music', colorData: Colors.white, iconData: Icons.music_note),
    FuzzyContainers(textData: 'Beauty', colorData: Colors.purple[200]!, iconData: Icons.brush),
    FuzzyContainers(textData: 'Shopping', colorData: Colors.purple[300]!, iconData: Icons.shopping_cart),
    FuzzyContainers(textData: 'Art', colorData: Colors.amber[200]!, iconData: Icons.palette),
    FuzzyContainers(textData: 'Fashion', colorData: Colors.pink[200]!, iconData: Icons.style),
    FuzzyContainers(textData: 'Education', colorData: Colors.purple[400]!, iconData: Icons.school),
    FuzzyContainers(textData: 'Co', colorData: Colors.amber[300]!, iconData: Icons.coffee),
    FuzzyContainers(textData: 'Technology', colorData: Colors.purple[500]!, iconData: Icons.computer),
    const FuzzyContainers(textData: 'Peace', colorData: Colors.white, iconData: Icons.sentiment_satisfied),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Select Chat Feature'),
        backgroundColor: const Color.fromARGB(255, 237, 244, 245),
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

                    ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: categories[index],
                          ),
                        );
                      },
                    ),
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
              backgroundColor: Colors.white,
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


class FuzzyContainers extends StatelessWidget {
  
  final String textData;
  final Color colorData;
  final IconData iconData;

  const FuzzyContainers({
    super.key, 
    required this.textData,
    required this.colorData,
    required this.iconData,});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorData,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),

          const SizedBox(width: 8.0), // white spacing
          
          Text(
            textData,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}