import '../../../../../models/NewsResponse.dart';

abstract class NewsOnlineDataSource{
  Future<NewsResponse> getNewsBySourceId(String sourceId);
}