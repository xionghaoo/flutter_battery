import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelloWorldWidget extends StatefulWidget {

  @override
  _HelloWorldWidgetState createState() => _HelloWorldWidgetState();
}

class _HelloWorldWidgetState extends State<HelloWorldWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter页面'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Flutter页面'
          ),
        ),
      ),
    );
  }
}