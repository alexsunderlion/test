import 'package:clubforce/core/util/enum/top_headline_news_category.dart';

class Helper {
  String getStringTopHeadlineNewsCategory(TopHeadlineNewsCategory topHeadlineNewsCategory) {
    switch (topHeadlineNewsCategory) {
      case TopHeadlineNewsCategory.business:
        return 'business';
      case TopHeadlineNewsCategory.entertainment:
        return 'entertainment';
      case TopHeadlineNewsCategory.general:
        return 'general';
      case TopHeadlineNewsCategory.health:
        return 'health';
      case TopHeadlineNewsCategory.science:
        return 'science';
      case TopHeadlineNewsCategory.sports:
        return 'sports';
      case TopHeadlineNewsCategory.technology:
        return 'technology';
    }
  }

  static int? toInt(dynamic data) {
    if (data is num) {
      return data.toInt();
    }
    return int.tryParse(data.toString());
  }

  static String? toStr(dynamic data) {
    return data.toString();
  }
}
