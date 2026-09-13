

 import 'package:news/apis/api_manger.dart';

import '../../../../../../models/NewsResponse.dart';
import '../news_online_data_source.dart';

class NewsOnlineDataSourceImpl extends NewsOnlineDataSource{
  ApiManger apiManger;
  NewsOnlineDataSourceImpl({required this.apiManger});
  @override
  Future<NewsResponse> getNewsBySourceId(String sourceId){
    return apiManger.getNewsBySourceId(sourceId);
  }
}