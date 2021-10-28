import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static var pageName = 'Home Page';

  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle homeCounterTextStyle = const TextStyle(
      height: 5,
      fontSize: 38,
      color: Colors.black,
      backgroundColor: Colors.greenAccent);

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
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                labelText: 'Enter custom number for count:',
                hintText: '10',
              ),
            ),
            Text('Count: $_counter', style: homeCounterTextStyle),
          ],
        ),
      ),
      floatingActionButton:
          _interactionButtons(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _interactionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const SizedBox(width: 30),
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const Expanded(child: SizedBox()),
        FloatingActionButton(
          onPressed: _resetCounter,
          tooltip: 'Set 0',
          child: const Text("0"),
        ),
        const Expanded(child: SizedBox()),
        FloatingActionButton(
          onPressed: _decrementCounter,
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
