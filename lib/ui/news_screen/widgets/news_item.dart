import 'package:flutter/material.dart';
import 'package:news/ui/news_screen/widgets/news_container.dart';
import 'package:news/utils/app_const.dart';

import '../../../apis/api_manger.dart';
import '../../../models/NewsResponse.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class NewsItem extends StatefulWidget {
  Function(String) onSourceChanged;
  String sourceId;
   NewsItem({super.key,required this.newsFuture,required this.onSourceChanged,required this.sourceId});
  Future<NewsResponse>? newsFuture;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    var appConst =AppConst(context);
    return FutureBuilder(
      future: widget.newsFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.gray,
            ),
          );
        }
        else if (snapshot.hasError){
          return Column(
            children: [
              Text('SomeThing went wrong',style: AppStyles.bothGrayMed12,),
              ElevatedButton(onPressed: (){
                setState(() {
                  widget.onSourceChanged(widget.sourceId);
                });
                ;},
                  child: Text('Try Again',style: AppStyles.lightBold16,)
              )
            ],
          );
        }
        else if (snapshot.hasData && snapshot.data?.status != 'ok'){
          return Column(
            children: [
              Text(snapshot.data?.message??'some thing went wrong',
                style:  AppStyles.bothGrayMed12.copyWith(
                    fontSize: 20
                ),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  ApiManger.getNewsBySourceId(widget.sourceId);
                });
              },
                  child: Text('Try Again',style: AppStyles.lightBold16,)
              )
            ],
          );
        }
        var newsList = snapshot.data?.articles??[];
        return widget.newsFuture == null?
        Center(
          child: CircularProgressIndicator(
            color: AppColors.gray,
          ),
        )
            :
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return NewsContainer(articles: newsList[index]);
          },
          itemCount: newsList.length,

        );
      },);
  }
}
