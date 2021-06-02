import 'package:flutter/material.dart';
import 'dynamic.dart';

void main() {
  runApp(MaterialApp(
    title: 'Dynamic Link',
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => HomePage(),
      '/Hello': (BuildContext context) => MyApp(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('MyHomepage')),
        ),
        body: Center(
          child: Text('Hello, Welcome to homepage!!!'),
        ),
      ),
    );
  }
}
