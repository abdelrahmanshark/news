import 'package:flutter/material.dart';
import 'package:news/utils/app_const.dart';

import '../../../apis/api_manger.dart';
import '../../../models/SourceResponse.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class NewsTapBar extends StatefulWidget {
  Function(String) onSourceChange;
  Future<SourceResponse>? sourcesFuture;
   NewsTapBar({super.key, required this.onSourceChange,required this.sourcesFuture});

  @override
  State<NewsTapBar> createState() => _NewsTapBarState();
}

class _NewsTapBarState extends State<NewsTapBar> {
  void reloadSources() {
    setState(() {
      widget.sourcesFuture = ApiManger.getSource('sports');
    });
  }
  Widget build(BuildContext context) {
    var appConst = AppConst(context);
    return FutureBuilder(
      future: widget.sourcesFuture,
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
                reloadSources()
                ;},
                  child: Text('Try Again',style: AppStyles.lightBold16,)
              )
            ],
          );
        }
        else if (snapshot.hasData && snapshot.data?.status != 'ok'){
          return Column(
            children: [
              Text(snapshot.data?.message??'something went wrong',
                style:  AppStyles.bothGrayMed12,
              ),
              ElevatedButton(onPressed: (){
                reloadSources();
              },
                  child: Text('Try Again',style: AppStyles.lightBold16,)
              )
            ],
          );
        }
        var sourcesList = snapshot.data?.sources??[];
        return DefaultTabController(
            initialIndex: 0,
            length: sourcesList.length,
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
                  widget.onSourceChange(sourcesList[index].id??'');

                },
                tabs: sourcesList.map((e) {
                  return Text(e.name??'');
                },).toList()));
      },);
  }
}
