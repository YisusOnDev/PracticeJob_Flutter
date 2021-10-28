import 'package:flutter/material.dart';
import 'package:myownapp/src/custom_drawer.dart';

class CounterPage extends StatefulWidget {
  static const pageName = 'counter';

  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPage();
}

class _CounterPage extends State<CounterPage> {
  final TextStyle counterTextStyle = const TextStyle(
      height: 5,
      fontSize: 38,
      color: Colors.black,
      backgroundColor: Colors.purpleAccent);

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter - 1 >= 0) {
        _counter--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Count: $_counter', style: counterTextStyle),
          ],
        ),
      ),
      drawer: MyCustomDrawer(),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 'incrementButton',
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
              heroTag: 'decrementButton',
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
              heroTag: 'resetButton',
                onPressed: _resetCounter,
                tooltip: 'Set 0',
                child: const Text("0"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
