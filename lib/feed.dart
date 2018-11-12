class Feed {
  String fid;
  String author;
  String title;
  String postdate;
  String url;
  int platform;

  String get platformString {
    switch (platform) {
      case 0:
        return '微博';
      case 1:
        return '公众号';
      case 2:
        return 'GitHub';
      case 3:
        return 'Medium';
      default:
        return '未知';
    }
  }

  Feed.fromJson(Map json) {
    fid = json['fid'];
    author = json['author'];
    title = json['title'];
    postdate = json['postdate'];
    url = json['url'];
    platform = int.tryParse(json['platform']);
  }
}
