import 'package:news/apis/api_manger.dart';
import 'package:news/data/repository/news/data_source/offline/impl/news_offline_data_source_impl.dart';
import 'package:news/data/repository/news/data_source/offline/news_offline_data_source.dart';
import 'package:news/data/repository/news/data_source/online/impl/news_online_data_source_impl..dart';
import 'package:news/data/repository/news/data_source/online/news_online_data_source.dart';
import 'package:news/data/repository/source/data_source/offline/impl/source_offline_data_source_impl.dart';
import 'package:news/data/repository/source/data_source/online/impl/source_repository_data_source_impl.dart';
import 'package:news/data/repository/source/repository/impl/source_repository_impl.dart';

import '../data/repository/news/repository/impl/news_repository_impl.dart';
import '../data/repository/news/repository/news_repository.dart';
import '../data/repository/source/data_source/offline/source_offline_data_source.dart';
import '../data/repository/source/data_source/online/source_online_data_source.dart';
import '../data/repository/source/repository/source_repository.dart';

SourceRepository injectSourceRepository(){
  return SourceRepositoryImpl(
      onlineDataSource: injectSourceOnlineDataSource(),
      offlineDataSource: injectSourceOfflineDataSource());
}
SourceOnlineDataSource injectSourceOnlineDataSource(){
  return SourceOnlineDataSourceImpl(apiManger: ApiManger.getInstance());
}
SourceOfflineDataSource injectSourceOfflineDataSource(){
  return SourceOfflineDataSourceImpl();
}
NewsOnlineDataSource injectNewsOnlineDataSource(){
  return NewsOnlineDataSourceImpl(apiManger: ApiManger.getInstance());
}
NewsOfflineDataSource injectNewsOfflineDataSource(){
  return NewsOfflineDataSourceImpl();
}
NewsRepository injectNewsRepository(){
  return NewsRepositoryImpl(
      onlineDataSource: injectNewsOnlineDataSource(),
      offlineDataSource: injectNewsOfflineDataSource());
}