import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geeks Demo',
      theme: ThemeData(
        // This is the theme
        // of your application.
        primarySwatch: Colors.green,
      ),
      home: HomePage(title: "GeeksforGeeks"),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Container(),
    );
  }
}
