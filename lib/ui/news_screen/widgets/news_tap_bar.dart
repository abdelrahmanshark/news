import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/ui/news_screen/cubit/news_screen_states.dart';
import 'package:news/ui/news_screen/cubit/news_screen_view_model.dart';
import 'package:news/utils/app_const.dart';

import '../../../apis/api_manger.dart';
import '../../../models/SourceResponse.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class NewsTapBar extends StatelessWidget {
  Function(String) onSourceChange;
  NewsScreenViewModel bloc;
  String sourceId;
   NewsTapBar({super.key, required this.onSourceChange,required this.bloc,required this.sourceId});

  Widget build(BuildContext context) {
    var appConst = AppConst(context);
    return BlocBuilder<NewsScreenViewModel,NewsScreenState>(
      buildWhen: (previous, current) {
        return current is SourceLoadingState ||
            current is SourceSuccessState ||
            current is SourceErrorState;
      },
        builder: (context, state) {
          if (state is SourceLoadingState){
            return Center(child: CircularProgressIndicator(color: AppColors.gray,),);
          }
          else if(state is SourceErrorState){
            return Column(
              children: [
                Expanded(child: Text(bloc.sourceErrMsg,style: AppStyles.bothGrayMed12,)),
                ElevatedButton(onPressed: (){
                  bloc.loadSources(sourceId)
                  ;},
                    child: Text('Try Again',style: AppStyles.lightBold16,)
                )
              ],
            );
          }
          else if (state is SourceSuccessState){


             return DefaultTabController(
                initialIndex: 0,
                length: bloc.sourcesList.length,
                child: TabBar(
                    indicatorAnimation: TabIndicatorAnimation.linear,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: appConst.theme.canvasColor,
                    unselectedLabelColor: appConst.theme.canvasColor,
                    labelStyle: appConst.textStyle.headlineMedium,
                    unselectedLabelStyle: appConst.textStyle.bodyLarge,
                    onTap: (index) {
                      onSourceChange(bloc.sourcesList[index].id??'');

                    },
                    tabs: bloc.sourcesList.map((e) {
                      return Text(e.name??'');
                    },).toList()));
          }
          else {
            return  Column(
              children: [
                Text(bloc.sourceErrMsg,style: AppStyles.bothGrayMed12,),
                ElevatedButton(onPressed: (){
                  bloc.loadSources(sourceId)
                  ;},
                    child: Text('Try Again',style: AppStyles.lightBold16,)
                )
              ],
            );
          }
        },);

  }
}
