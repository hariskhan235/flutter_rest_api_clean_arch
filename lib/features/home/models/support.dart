class Support {
  Support({
    required this.url,
    required this.text,
  });
  late final String url;
  late final String text;

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['text'] = text;
    return _data;
  }
}
