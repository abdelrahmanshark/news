import 'package:news/models/SourceResponse.dart';

abstract class SourceOfflineDataSource{

  Future<SourceResponse> getSources(String categoryId);
  Future<void> saveSourced(SourceResponse sourceResponse,String categoryId);
}