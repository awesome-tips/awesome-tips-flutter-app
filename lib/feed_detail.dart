import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'consts.dart';

class FeedDetail extends StatefulWidget {
  final String feedUrl;

  FeedDetail({Key key, @required this.feedUrl}) : super(key: key);

  @override
  createState() => _FeedDetailState(feedUrl: feedUrl);
}

class _FeedDetailState extends State<FeedDetail> {
  bool loaded = false;
  final String feedUrl;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  _FeedDetailState({Key key, this.feedUrl});

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      print(url);
    });
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        // 标记加载完成
        setState(() {
          loaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(Text(Consts.detailTitle, style: TextStyle(color: Colors.white)));
    if (!loaded) {
      titleContent.add(CupertinoActivityIndicator());
    }
    titleContent.add(Container(width: 50.0));

    return WebviewScaffold(
      appBar: AppBar(
        title: Row(
          children: titleContent,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      url: feedUrl,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}