import 'package:hive/hive.dart';
import 'package:news/models/SourceResponse.dart';

import '../source_offline_data_source.dart';

class SourceOfflineDataSourceImpl extends SourceOfflineDataSource{
  @override
  Future<SourceResponse> getSources(String categoryId)async {
    var box = await Hive.openBox('source');
    var data  =  SourceResponse.fromJson(box.get(categoryId));
    return data;
  }

  @override
  Future<void> saveSourced(SourceResponse sourceResponse,String categoryId) async{
    var box = await Hive.openBox('source');
    await box.put(categoryId, sourceResponse.toJson());
  }

}