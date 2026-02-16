import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      title: 'Lab 5',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Inner UI of the application
      home: const MyHomePage(),
    );
  }
}

/* This class is similar to MyApp instead it
   is used to build the Home Page Widget */
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Task 1: Implementing TabBar using DefaultTabController
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Lab 5'),
          // TabBar display
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: "ListView"),
              Tab(icon: Icon(Icons.grid_view), text: "GridView"),
            ],
          ),
        ),
        // Task 5: Implement a Flutter Drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Text(
                  'Navigation Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Home selected')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile selected')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings selected')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout selected')),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: ListView (Task 1 & Task 2)
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text('List Item ${index + 1}'),
                  subtitle: const Text('Title and subtitle requirement for Task 2.'),
                );
              },
            ),
            // Tab 2: GridView, Cards, and Toast (Task 1, 3, 4, 6)
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Task 3: GridView with 6 colored containers and numbers
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(margin: const EdgeInsets.all(5), color: Colors.red, child: const Center(child: Text('1'))),
                        Container(margin: const EdgeInsets.all(5), color: Colors.blue, child: const Center(child: Text('2'))),
                        Container(margin: const EdgeInsets.all(5), color: Colors.green, child: const Center(child: Text('3'))),
                        Container(margin: const EdgeInsets.all(5), color: Colors.yellow, child: const Center(child: Text('4'))),
                        Container(margin: const EdgeInsets.all(5), color: Colors.orange, child: const Center(child: Text('5'))),
                        Container(margin: const EdgeInsets.all(5), color: Colors.purple, child: const Center(child: Text('6'))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Task 1: GridView of images
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Image.asset('assets/image1.jpg', fit: BoxFit.cover),
                        Image.asset('assets/image2.jpg', fit: BoxFit.cover),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Task 4: Flutter Card Widget
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Image.asset('assets/image1.jpg', height: 150, width: double.infinity, fit: BoxFit.cover),
                        const ListTile(
                          title: Text('Card Widget Example'),
                          subtitle: Text('This card contains an image, title, and description.'),
                        ),
                      ],
                    ),
                  ),
                  // Task 6: Toast Notification Button
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: "Hello, Flutter!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                      );
                    },
                    child: const Text('Show Toast Notification'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}