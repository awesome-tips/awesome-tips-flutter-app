import 'package:flutter/material.dart';
import 'feed_list.dart';
import 'consts.dart';

void main() => runApp(AwesomeTipsApp());

class AwesomeTipsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(title: Text(Consts.appTitle)),
        body: FeedList(),
      ),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}