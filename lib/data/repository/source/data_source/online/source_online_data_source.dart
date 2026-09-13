import 'package:news/models/SourceResponse.dart';

abstract class SourceOnlineDataSource{
  Future<SourceResponse> getSources(String categoryId);
}