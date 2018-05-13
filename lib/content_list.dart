import 'package:flutter/material.dart';
import 'strings.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'feed.dart';

class ContentList extends StatefulWidget {
  @override
  createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  var _items = [];

  @override
  Widget build(BuildContext context) {
    print('length: ${_items.length}');

    return Scaffold(
      appBar: AppBar(title: Text(Strings.appTitle)),
      body: new ListView.builder(
        padding: const EdgeInsets.all(13.0),
        itemCount: _items.length * 2,
        itemBuilder: (BuildContext context, int position) {

          // 此处为添加分割线
          if (position.isOdd) return Divider();
          final index = position ~/ 2;

          return _buildRow(index);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  Widget _buildRow(int i) {
    Feed feed = this._items[i];

    return ListTile(
        title: Text(
          feed.title,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text(
          '${feed.postdate} @${feed.author}',
        ));
  }

  void _loadData() async {
    String dataURL =
        "https://app.kangzubin.com/iostips/api/feed/list?page=1&from=flutter-app&version=1.0";
    http.Response response = await http.get(dataURL);

    final body = JSON.decode(response.body);
    final int code = body["code"];
    if (code == 0) {
      final feeds = body["data"]["feeds"];

      print(feeds);
      var items = [];
      feeds.forEach((item) =>
          items.add(Feed(item["auther"], item["title"], item["postdate"])));

      setState(() {
        _items = items;
      });
    }
  }
}
