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
  List<int> numbers = [];

  void onClicked() {
    setState(() {
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Click Count',
                  style: TextStyle(fontSize: 30),
                ),
                for (var n in numbers) Text('$n'),
                IconButton(
                  iconSize: 50,
                  onPressed: onClicked,
                  icon: const Icon(Icons.add_box_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
