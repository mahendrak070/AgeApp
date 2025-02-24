import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AgeCounter(),
      child: const MyApp(),
    ),
  );
}

class AgeCounter with ChangeNotifier {
  int age = 0;

  void increment() {
    if (age < 99) {
      age++;
      notifyListeners();
    }
  }

  void decrement() {
    if (age > 0) {
      age--;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Counter',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Color getBackgroundColor(int age) {
    if (age <= 12) {
      return Colors.blue[200]!;
    } else if (age <= 19) {
      return Colors.green[200]!;
    } else if (age <= 30) {
      return Colors.amber[200]!;
    } else if (age <= 50) {
      return Colors.orange[300]!;
    } else {
      return Colors.grey[400]!;
    }
  }

  String getMessage(int age) {
    if (age <= 12) {
      return "You're a child!";
    } else if (age <= 19) {
      return "Teenager time!";
    } else if (age <= 30) {
      return "You're a young adult!";
    } else if (age <= 50) {
      return "You're an adult now!";
    } else {
      return "Golden years!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AgeCounter>(
      builder: (context, counter, child) {
        return Scaffold(
          backgroundColor: getBackgroundColor(counter.age),
          appBar: AppBar(
            title: const Text('Age Tracker'),
            centerTitle: true,
            backgroundColor: Colors.teal[700],
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Age: ${counter.age}',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    getMessage(counter.age),
                    style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: counter.decrement,
                tooltip: 'Decrement',
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.remove),
              ),
              FloatingActionButton(
                onPressed: counter.increment,
                tooltip: 'Increment',
                backgroundColor: Colors.greenAccent,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    );
  }
}
