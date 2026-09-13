import '../../../../models/NewsResponse.dart';

abstract class NewsRepository{
  Future<NewsResponse> getNewsBySourceId(String sourceId);

}