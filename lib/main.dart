import 'package:flutter/material.dart';
import 'strings.dart';
import 'content_list.dart';

void main() => runApp(AwesomeTipsApp());

class AwesomeTipsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      // theme: ThemeData(primaryColor: Colors.red.shade800),
      home: ContentList(),
    );
  }
}

