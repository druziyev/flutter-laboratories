import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title of the application
      title: 'Lab 4',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Inner UI of the application
      home: const MyHomePage(title: 'Lab 4'),
    );
  }
}

/* This class is similar to MyApp instead it
   is used to build the Home Page Widget */
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variable to toggle images for Task 12
  bool _useFirstImage = true;

  void _toggleImage() {
    setState(() {
      _useFirstImage = !_useFirstImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Task 1: AppBar Styling (from previous lab requirements preserved here)
        backgroundColor: Colors.teal,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // Task 9: Using Stack widget to overlay elements
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Task 6 & 7: Displaying image with BoxFit properties
                  Container(
                    width: 350,
                    height: 250,
                    child: Image.asset(
                      _useFirstImage ? 'assets/image1.jpg' : 'assets/image2.jpg',
                      /* Task 8: Description of BoxFit values:
                         - BoxFit.fill: Distorts image to fill the entire target box.
                         - BoxFit.contain: Largest possible size while showing the whole image.
                         - BoxFit.cover: Fills the box by clipping the image if necessary.
                         - BoxFit.fitWidth: Makes image as wide as the box.
                         - BoxFit.fitHeight: Makes image as tall as the box.
                         - BoxFit.none: Displays image at original size, centered.
                         - BoxFit.scaleDown: Like contain, but won't scale up if image is smaller.
                      */
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Task 9: Semi-transparent black container overlay
                  Container(
                    width: 350,
                    height: 250,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  // Task 9: Overlay text
                  const Text(
                    "Welcome to Flutter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Task 10: ElevatedButton configuration
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Showing SnackBar!')),
                  );
                },
                child: const Text(
                  "Show SnackBar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Task 11: TextButton configuration
            SizedBox(
              width: 200,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                ),
                onPressed: () {
                  // Navigation placeholder
                },
                child: const Text(
                  "Go to Second Screen",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Task 12: OutlinedButton configuration
            SizedBox(
              width: 200,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                ),
                onPressed: _toggleImage,
                child: const Text(
                  "Toggle Image",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}