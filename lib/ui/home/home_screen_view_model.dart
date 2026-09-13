import 'package:flutter/cupertino.dart';
import 'package:news/utils/app_const.dart';
import '../../models/news_category.dart';
import '../../utils/app_routes.dart';

class HomeScreenViewModel{
  BuildContext context;
  HomeScreenViewModel({required this.context}){
   getNewsCategory(context);
  }
  void getNewsCategory(BuildContext context){
    var appConst = AppConst(context);
    newsCategory =  [
      NewsCategory(title: "General",
        id: 'general', image:  appConst.image.general,
      ),
      NewsCategory(
          title: "Business",
          id: 'business',
          image: appConst.image.business),
      NewsCategory(
          title: "Sports",
          id: 'sports',
          image: appConst.image.sports),
      NewsCategory(
          title: "Technology",
          id: 'technology',
          image: appConst.image.technology),
      NewsCategory(
          title: "Entertainment",
          id: 'entertainment',
          image: appConst.image.entertainment),
      NewsCategory(
          title: "Science",
          id: 'science',
          image: appConst.image.science),
    ];
  }
  List<NewsCategory>? newsCategory;
  void onTab ( int index){
    Navigator.pushNamed(context, AppRoutes.newsScreenRouteName,
        arguments: {
          'title':newsCategory?[index].title,
          'id':newsCategory?[index].id
        }
    );
  }

}