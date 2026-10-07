// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news/data/news/news_local_data_source.dart' as _i263;
import 'package:news/data/news/news_remote_data_source.dart' as _i40;
import 'package:news/data/news/news_repository_impl.dart' as _i745;
import 'package:news/domain/repositories/news_repository.dart' as _i1044;
import 'package:news/services/connectivity_service.dart' as _i681;
import 'package:news/services/data_base_service.dart' as _i38;
import 'package:news/ui/home_view/news_view/view_model/articles_view_model.dart'
    as _i731;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i263.NewsLocalDataSource>(
      () => _i263.NewsLocalDataSource(),
    );
    gh.lazySingleton<_i40.NewsRemoteDataSource>(
      () => _i40.NewsRemoteDataSource(),
    );
    gh.lazySingleton<_i681.ConnectivityService>(
      () => _i681.ConnectivityService(),
    );
    gh.lazySingleton<_i38.DataBaseService>(() => _i38.DataBaseService());
    gh.lazySingleton<_i1044.NewsRepository>(
      () => _i745.NewsRepositoryImpl(
        gh<_i40.NewsRemoteDataSource>(),
        gh<_i263.NewsLocalDataSource>(),
        gh<_i681.ConnectivityService>(),
      ),
    );
    gh.factory<_i731.ArticlesViewModel>(
      () => _i731.ArticlesViewModel(gh<_i1044.NewsRepository>()),
    );
    return this;
  }
}
