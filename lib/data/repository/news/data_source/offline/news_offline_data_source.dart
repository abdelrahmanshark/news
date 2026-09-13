import '../../../../../models/NewsResponse.dart';

abstract class NewsOfflineDataSource{
  Future<NewsResponse> getNewsBySourceId(String sourceId);
  Future<void> saveNews(String sourceId,NewsResponse newsResponse);

}