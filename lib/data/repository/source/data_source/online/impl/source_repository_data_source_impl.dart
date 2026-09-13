
import 'package:news/apis/api_manger.dart';
import 'package:news/data/repository/source/data_source/online/source_online_data_source.dart';
import 'package:news/models/SourceResponse.dart';

class SourceOnlineDataSourceImpl extends SourceOnlineDataSource{
  ApiManger apiManger;
  SourceOnlineDataSourceImpl({required this.apiManger});
  @override
  Future<SourceResponse> getSources(String categoryId) {
    return apiManger.getSource(categoryId);
  }
}