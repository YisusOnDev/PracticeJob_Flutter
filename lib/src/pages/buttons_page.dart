import 'package:flutter/material.dart';

import '../custom_drawer.dart';

class ButtonsPage extends StatelessWidget {
  static var pageName = 'buttons';

  const ButtonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Buttons'),
      ),
      body: Center(child: Column(children: <Widget>[  
            Container(  
              margin: const EdgeInsets.all(25),  
              child: ElevatedButton(
            style: style,
            onPressed: () => print('KEKW'),
            child: const Text('Print KEKW'),
          ),
            )])),
      drawer: MyCustomDrawer(),
    );
  }
}