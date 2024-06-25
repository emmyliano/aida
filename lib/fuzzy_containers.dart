import 'package:flutter/material.dart';



class FuzzyContainers extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Love', color: Colors.purple[100]!, icon: Icons.favorite),
    Category(name: 'Friend', color: Colors.amber[100]!, icon: Icons.people),
    Category(name: 'Learn', color: Colors.pink[100]!, icon: Icons.book),
    Category(name: 'Music', color: Colors.white, icon: Icons.music_note),
    Category(name: 'Beauty', color: Colors.purple[200]!, icon: Icons.brush),
    Category(name: 'Shopping', color: Colors.purple[300]!, icon: Icons.shopping_cart),
    Category(name: 'Art', color: Colors.amber[200]!, icon: Icons.palette),
    Category(name: 'Fashion', color: Colors.pink[200]!, icon: Icons.style),
    Category(name: 'Education', color: Colors.purple[400]!, icon: Icons.school),
    Category(name: 'Co', color: Colors.amber[300]!, icon: Icons.coffee),
    Category(name: 'Technology', color: Colors.purple[500]!, icon: Icons.computer),
    Category(name: 'Peace', color: Colors.white, icon: Icons.sentiment_satisfied),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Stack(
        children: [
          ...categories.map((category) => DraggableCategoryWidget(category: category)).toList(),
        ],
      ),
    );
  }
}

class DraggableCategoryWidget extends StatefulWidget {
  final Category category;

  DraggableCategoryWidget({required this.category});

  @override
  _DraggableCategoryWidgetState createState() => _DraggableCategoryWidgetState();
}

class _DraggableCategoryWidgetState extends State<DraggableCategoryWidget> {
  Offset position = Offset(100, 100); // Default position

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: CategoryChip(category: widget.category),
        childWhenDragging: Container(),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        child: CategoryChip(category: widget.category),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final Category category;

  CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(category.icon, color: Colors.black),
      label: Text(
        category.name,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: category.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}

class Category {
  final String name;
  final Color color;
  final IconData icon;

  Category({required this.name, required this.color, required this.icon});
}
