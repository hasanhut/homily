import 'package:flutter/material.dart';
import 'package:homily/screens/expense_tracker_homepage.dart';
import 'package:homily/screens/photo_album_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('H O M I L Y'),
          backgroundColor: Colors.black,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Calendar"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Shopping List"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpenseTrackerHomePage()),
                  ),
                },
                child: const Text("Expense Tracker"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Task Sharer"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Event Planner"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PhotoAlbumHome()),
                  ),
                },
                child: const Text("Photo Album"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
