import 'package:hive/hive.dart';
import 'package:news/models/NewsResponse.dart';

import '../../../../../../apis/api_manger.dart';
import '../news_offline_data_source.dart';

class NewsOfflineDataSourceImpl extends NewsOfflineDataSource{

  @override
  Future<NewsResponse> getNewsBySourceId(String sourceId) async{
    var box = await Hive.openBox('news');
    var data  =  NewsResponse.fromJson(box.get(sourceId));
    return data;
  }

  @override
  Future<void> saveNews(String sourceId,NewsResponse newsResponse) async {
  var box = await Hive.openBox('news');
  await box.put(sourceId, newsResponse.toJson());
  }

}