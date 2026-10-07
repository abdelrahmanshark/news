class Article {
  const Article({
    this.articleId,
    this.title,
    this.description,
    this.content,
    this.link,
    this.imageUrl,
    this.sourceName,
    this.sourceIcon,
    this.creators = const [],
    this.pubDate,
  });

  /// Builds an [Article] from NewsData.io or cached JSON.
  // `dynamic` because Hive returns Map<dynamic, dynamic> instead of Map<String, dynamic>.
  factory Article.fromJson(dynamic json) {
    final dynamic creatorJson = json['creator'];
    return Article(
      articleId: json['article_id'],
      title: _availableText(json['title']),
      description: _availableText(json['description']),
      content: _availableText(json['content']),
      link: json['link'],
      imageUrl: json['image_url'],
      sourceName: json['source_name'],
      sourceIcon: json['source_icon'],
      creators: creatorJson is List
          ? creatorJson.whereType<String>().toList()
          : const [],
      pubDate: json['pubDate'],
    );
  }

  final String? articleId;
  final String? title;
  final String? description;

  /// Full article text; null on plans that don't include it.
  final String? content;
  final String? link;
  final String? imageUrl;
  final String? sourceName;
  final String? sourceIcon;
  final List<String> creators;

  /// Publish date in UTC, formatted as `yyyy-MM-dd HH:mm:ss`.
  final String? pubDate;

  /// Parses [pubDate] as a UTC [DateTime], or returns null when it is missing or invalid.
  DateTime? get publishedAt {
    final String? date = pubDate;
    if (date == null) return null;
    // The API omits the timezone, so `Z` marks the value as UTC.
    return DateTime.tryParse(date.endsWith('Z') ? date : '${date}Z');
  }

  /// Returns [value] as text, or null when it is missing or a paid-plan placeholder.
  static String? _availableText(dynamic value) {
    if (value is! String || value.trim().isEmpty) return null;
    // Fields locked by the plan come back as "ONLY AVAILABLE IN ... PLANS".
    if (value.startsWith('ONLY AVAILABLE IN')) return null;
    return value;
  }

  /// Converts this article to JSON (same keys as NewsData.io) for caching.
  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'description': description,
      'content': content,
      'link': link,
      'image_url': imageUrl,
      'source_name': sourceName,
      'source_icon': sourceIcon,
      'creator': creators,
      'pubDate': pubDate,
    };
  }
}
