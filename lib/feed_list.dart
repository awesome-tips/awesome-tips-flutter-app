import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'feed.dart';
import 'feed_detail.dart';

class FeedList extends StatefulWidget {
  @override
  createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  int _page = 1;
  bool _loading = false;
  ScrollController _scrollController = ScrollController();
  List<Feed> _items;

  @override
  Widget build(BuildContext context) {
    if (_items == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: _items.length * 2,
          itemBuilder: (BuildContext context, int position) {
            // 此处为添加分割线
            if (position.isOdd) return Divider(height: 0.0, indent: 15);

            final index = position ~/ 2;
            return _buildCellForRow(index);
          },
          controller: _scrollController,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 10.0 == _scrollController.position.maxScrollExtent) {
        _onFetchMore();
      }
    });
    _onRefresh();
  }

  Widget _buildCellForRow(int index) {
    Feed feed = _items[index];

    return ListTile(
      title: Text(
        feed.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${feed.postdate} @${feed.author} · ${feed.platformString}',
        style: TextStyle(fontSize: 13, color: Colors.grey),
      ),
      onTap: () {
        if (feed.url != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => FeedDetail(feedUrl: feed.url)
          ));
        }
      },
    );
  }

  Future<void> _onRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));
    if (_loading) return;
    _page = 1;
    _loadData();
  }

  void _onFetchMore() async {
    if (_loading) return;
    _page += 1;
    _loadData();
  } 

  void _loadData() async {
    String dataURL = "https://tips.kangzubin.com/api/feed/list?page=$_page";
    http.Response response = await http.get(dataURL, headers: {'from': 'flutter-app', 'version': '1.0'});

    final body = json.decode(response.body);
    final int code = body["code"];
    if (code == 0) {
      List<Feed> items = [];
      if (_page > 1) {
        items.addAll(_items);
      }
      final feeds = body["data"]["feeds"];
      feeds.forEach((item) => items.add(Feed.fromJson(item)));

      setState(() {
        _items = items;
      });
    }
  }
}