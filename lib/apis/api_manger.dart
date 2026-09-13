import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/apis/api_const.dart';
import 'package:news/models/NewsResponse.dart';
import 'package:news/models/SourceResponse.dart';
class ApiManger{
  static ApiManger? _instance ;
  ApiManger._();
  static ApiManger getInstance(){
    _instance ??= ApiManger._();
    return _instance!;
  }
   Future<SourceResponse> getSource(String categoryId) async{
    /*
    https://newsapi.org/v2/top-headlines/sources?apiKey=0031254f08b142978c24db81550d0808
    */
    Uri url = Uri.https(ApiConst.baseUrl,ApiConst.sourceApi,{
      'apiKey':ApiConst.apiKey,
      'category':categoryId,
    });
    try{
      var response = await http.get(url);
      String responseBody = response.body;//String
      //String => json =>object
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    }catch(e){
      rethrow;
    }

  }
   Future<NewsResponse> getNewsBySourceId(String sourceId)async{
    Uri url = Uri.https(ApiConst.baseUrl,ApiConst.newsApi,{
      'apiKey':ApiConst.apiKey,
      'sources':sourceId,
    });
    print('URL: $url');
    try{
      var response = await http.get(url);
      var responseBody =response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    }catch(e){
      rethrow;
    }

  }
}