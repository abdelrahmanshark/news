import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/data/repository/source/data_source/online/source_online_data_source.dart';
import 'package:news/data/repository/source/repository/source_repository.dart';
import 'package:news/di/di.dart';
import 'package:news/models/SourceResponse.dart';
import '../../data_source/offline/source_offline_data_source.dart';


class SourceRepositoryImpl extends SourceRepository{
  SourceOnlineDataSource onlineDataSource;
  SourceOfflineDataSource offlineDataSource ;
  SourceRepositoryImpl({
    required this.onlineDataSource
    ,
    required this.offlineDataSource
});
  @override
  Future<SourceResponse> getSources(String categoryId) async{
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if(!connectivityResult.contains(ConnectivityResult.none))
      {
        SourceResponse sourceResponse = await onlineDataSource.getSources(categoryId);
        offlineDataSource.saveSourced(sourceResponse, categoryId);
        return sourceResponse;
      }
   else{
     return offlineDataSource.getSources(categoryId);
    }
  }

}