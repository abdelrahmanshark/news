import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/repository/news/repository/news_repository.dart';
import 'package:news/data/repository/source/repository/source_repository.dart';
import 'package:news/di/di.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../apis/api_manger.dart';
import '../../../models/NewsResponse.dart';
import '../../../models/SourceResponse.dart';
import 'news_screen_states.dart';

class NewsScreenViewModel extends Cubit<NewsScreenState>{
  SourceRepository sourceRepository ;
  NewsRepository newsRepository;
  ApiManger apiManger;
  NewsScreenViewModel({required this.sourceRepository,required this.apiManger,required this.newsRepository}):super(InitState());
  Future<SourceResponse>? sourcesFuture;
  List<Source> sourcesList  = [];
  List<Articles> newsList = [];
  String selectedSourceId  = '';
  Future<NewsResponse>? newsFuture;
  String sourceErrMsg = '';
  String newsErrMsg = '';
  Future<void> loadSources(String categoryId )async{
    try{
      emit(SourceLoadingState());
      sourcesFuture =  sourceRepository.getSources(categoryId);
      var sourceResponse = await sourcesFuture!;
      if (sourceResponse.status == 'error'){

        sourceErrMsg = sourceResponse.message!;
        log(sourceErrMsg);
        emit(SourceErrorState());
        return;
      }
      selectedSourceId = sourceResponse.sources?[0].id??'';
     await loadNews(selectedSourceId);
      sourcesList = sourceResponse.sources??[];
      if (sourceResponse.status == 'error'){

        sourceErrMsg = sourceResponse.message!;
        log(sourceErrMsg);
        emit(SourceErrorState());
        return;
      }
      if (sourceResponse.status == 'ok'){
        emit(SourceSuccessState());
        return;
      }
    }catch(e){
      sourceErrMsg = e.toString();
      log(sourceErrMsg);
      emit(SourceErrorState());
    }


  }

  Future<void> loadNews(String sourceId)async{
    try{
      emit(NewsLoadingState());
      selectedSourceId = sourceId;
      newsFuture = newsRepository.getNewsBySourceId(selectedSourceId);
      var newsResponse = await newsFuture;
      newsList = newsResponse?.articles ?? [];
      if(newsResponse?.status == 'error'){
        newsErrMsg = newsResponse?.message??'';
        log(newsErrMsg);
        emit(NewsErrorState());
        return;
      }
      if(newsList.isEmpty){
        emit(EmptyArticlesState());
        return;
      }
      if(newsResponse?.status == 'ok'){
        emit(NewsSuccessState());
        return;
      }
    }catch(e){
      newsErrMsg = e.toString();
      log(newsErrMsg);
      emit(NewsErrorState());
    }

  }

  Future<void> openLink(String newsUrl) async {
    if (newsUrl.isEmpty) return;

    final Uri url = Uri.parse(newsUrl);

    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      log('Error opening URL: $e');
    }
  }

}