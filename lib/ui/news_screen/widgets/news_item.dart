
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/ui/news_screen/cubit/news_screen_states.dart';
import 'package:news/ui/news_screen/widgets/news_container.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../cubit/news_screen_view_model.dart';

class NewsItem extends StatelessWidget {
  Function(String) onSourceChanged;
  NewsScreenViewModel bloc;
  String sourceId;
   NewsItem({super.key,required this.onSourceChanged,required this.sourceId,required this.bloc});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<NewsScreenViewModel,NewsScreenState>(
      buildWhen: (previous, current) {
        return current is NewsLoadingState ||
            current is NewsSuccessState ||
            current is NewsErrorState ||
        current is EmptyArticlesState
        ;
      },
        builder: (context, state) {
          if (state is NewsLoadingState){
            return Center(child: CircularProgressIndicator(color: AppColors.gray,),);
          }
          else if(state is NewsErrorState){
            return Column(
              children: [
                Text(bloc.newsErrMsg,style: AppStyles.bothGrayMed12,),
                ElevatedButton(onPressed: (){
                  bloc.loadNews(sourceId)
                  ;},
                    child: Text('Try Again',style: AppStyles.lightBold16,)
                )
              ],
            );
          }
          else if (state is EmptyArticlesState){
            return Center(child: Text("No articles published yet",style: AppStyles.bothGrayMed12.copyWith(fontSize: 20),),);
          }
          else if (state is NewsSuccessState){
            return  ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      final url = bloc.newsList[index].url;
                        log(url.toString());
                      if (url != null && url.isNotEmpty) {
                        bloc.openLink(url);
                      }
                    },
                    child: NewsContainer(articles: bloc.newsList[index]));
              },
              itemCount: bloc.newsList.length,

            );
          }
          else {
            return  Column(
              children: [
                Text(bloc.newsErrMsg,style: AppStyles.bothGrayMed12,),
                ElevatedButton(onPressed: (){
                  bloc.loadSources(sourceId)
                  ;},
                    child: Text('Try Again',style: AppStyles.lightBold16,)
                )
              ],
            );
          }
        },

    );

  }
}
