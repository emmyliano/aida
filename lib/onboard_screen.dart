import 'package:flutter/material.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> with SingleTickerProviderStateMixin{
  double _dragPosition = 0.0;
  final double _buttonWidth = 700.0;
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
      MaterialPageRoute(builder: (context) => const NewScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
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
                        Text(
                          'Hi!,',
                          style: TextStyle(
                            fontSize: 50, // Large font size
                            fontWeight: FontWeight.bold, // Bold font weight
                            color: Colors.white, // White color
                          ),
                        ),

                        Text(
                          "I'm Aida!",
                          style: TextStyle(
                            fontSize: 50, // Large font size
                            fontWeight: FontWeight.bold, // Bold font weight
                            color: Colors.white, // White color
                          ),
                        ),
                      ],
                    ),
                  ),
                  

                  Positioned(
                    bottom: 50,
                    right: 50,
                    child: Container(
                      width: _buttonWidth + 10,
                      height: 60.0,
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
                                width: 60.0,
                                height: 60.0,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
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


class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Screen'),
      ),
      body: const Center(
        child: Text('Welcome to the new screen!'),
      ),
    );
  }
}