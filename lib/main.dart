import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;

  void onClicked() {
    setState(() {
      counter += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click Count',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '$counter',
                style: const TextStyle(fontSize: 30),
              ),
              IconButton(
                iconSize: 50,
                onPressed: onClicked,
                icon: const Icon(Icons.add_box_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
