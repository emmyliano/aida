import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background_2.jpg"), // Path to your image
          // fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        body: ChatScreen(),
      ),
    );
  }
}


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showBottomContainers = false;
  List<Map<String, dynamic>> messages = [
    {
      'text': 'Hi there! I can help you with that. What are your departure and return dates for the trip?',
      'isSender': false,
    },
    {
      'text': 'I plan to depart from New York on Friday, November...',
      'isSender': true,
    }
  ];

  final TextEditingController _controller = TextEditingController();

  void toggleBottomContainers() {
    setState(() {
      showBottomContainers = !showBottomContainers;
    });
  }

  void sendMessage() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message'),
        ),
      );
    } else {
      setState(() {
        messages.add({
          'text': _controller.text,
          'isSender': true,
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatBubble(
                text: messages[index]['text'],
                isSender: messages[index]['isSender'],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: sendMessage,
              ),
            ],
          ),
        ),
        if (showBottomContainers)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle send personal info tap
                  },
                  child: _buildBottomContainer(
                    icon: Icons.person,
                    text: 'Send personal info',
                    color: Colors.teal,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle send card details tap
                  },
                  child: _buildBottomContainer(
                    icon: Icons.credit_card,
                    text: 'Send card details',
                    color: Colors.purple,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle send documents tap
                  },
                  child: _buildBottomContainer(
                    icon: Icons.document_scanner,
                    text: 'Send documents',
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: toggleBottomContainers,
          child: Text(showBottomContainers ? 'Hide Options' : 'Show Options'),
        ),
      ],
    );
  }

  Widget _buildBottomContainer({required IconData icon, required String text, required Color color}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8.0),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  ChatBubble({required this.text, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isSender) ...[
              const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.android, color: Colors.white),
              ),
              const SizedBox(width: 8.0),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: isSender ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSender ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            if (isSender) ...[
              const SizedBox(width: 8.0),
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
