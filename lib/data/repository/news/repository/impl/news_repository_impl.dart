import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/data/repository/news/data_source/online/news_online_data_source.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/models/NewsResponse.dart';

import '../../data_source/offline/news_offline_data_source.dart';

class NewsRepositoryImpl extends NewsRepository{
  NewsOnlineDataSource onlineDataSource;
  NewsOfflineDataSource offlineDataSource ;
  NewsRepositoryImpl({
    required this.onlineDataSource
    ,
    required this.offlineDataSource
  });
  @override
  Future<NewsResponse> getNewsBySourceId(String sourceId)async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if(!connectivityResult.contains(ConnectivityResult.none))
    {
      NewsResponse newsResponse = await onlineDataSource.getNewsBySourceId(sourceId);
      offlineDataSource.saveNews(sourceId, newsResponse);
      return newsResponse;
    }
    else{
      return offlineDataSource.getNewsBySourceId(sourceId);
    }
  }

}