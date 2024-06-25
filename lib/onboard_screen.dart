import 'dart:async';
import 'package:aida/selection_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> with SingleTickerProviderStateMixin{
  double _dragPosition = 0.0;
  final double _buttonWidth = 700.0;
  // ignore: unused_field
  bool _isSwiped = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {
          _dragPosition = _animation.value * (_buttonWidth - 50.0);
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.primaryDelta!;
      if (_dragPosition < 0) _dragPosition = 0;
      if (_dragPosition > _buttonWidth - 50.0) _dragPosition = _buttonWidth - 50.0;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragPosition > _buttonWidth / 2) {
      _animationController.forward();
      _isSwiped = true;
      _performAction();
    } else {
      setState(() {
        _dragPosition = 0.0;
      });
    }
  }

  void _performAction() {
    // Navigate to the new screen
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center, // Change transition type here
        child: SelectionScreen(),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Image.asset('images/background_2.jpg'),
                  Positioned(
                    top: 10,
                    left: 150,
                    child: Image.asset('images/yeti.png'),
                  ),

                  const Positioned(
                    top: 250,
                    left: 650,
                    child: Column(
                      children: [
                        TextSwitcher(),
                      ],
                    ),
                  ),
                  

                  Positioned(
                    bottom: 50,
                    left: 120,
                    child: Container(
                      width: _buttonWidth + 300,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Stack(
                        children: [
                          const Positioned.fill(
                            child: Center(
                              child: Text(
                                'Discover',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: _dragPosition,
                            child: GestureDetector(
                              onHorizontalDragUpdate: _onDragUpdate,
                              onHorizontalDragEnd: _onDragEnd,
                              child: Container(
                                width: 350.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      )
    );
  }
}


class TextSwitcher extends StatefulWidget {
  const TextSwitcher({super.key});

  @override
  _TextSwitcherState createState() => _TextSwitcherState();
}

class _TextSwitcherState extends State<TextSwitcher> {
  bool _showFirstText = true;

  @override
  void initState() {
    super.initState();
    // Start a timer to switch the text every few seconds
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _showFirstText = !_showFirstText;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _showFirstText
          ? const Text(
              'Hi, I\'m Aida!',
              key: ValueKey<int>(1),
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : const Text(
              'Your virtual chat friend',
              key: ValueKey<int>(2),
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }
}