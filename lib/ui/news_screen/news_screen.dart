import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/apis/api_manger.dart';
import 'package:news/ui/news_screen/cubit/news_screen_view_model.dart';
import 'package:news/ui/news_screen/widgets/news_item.dart';
import 'package:news/ui/news_screen/widgets/news_tap_bar.dart';
import 'package:news/ui/home/widgets/side_drawer.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_const.dart';
import 'package:news/utils/app_styles.dart';

import '../../models/NewsResponse.dart';
import '../../models/SourceResponse.dart';
import '../../widgets/drop_down_theme_menu.dart';

class NewsScreen extends StatefulWidget {
   NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late String sourceTitle;
  late String sourceId;
  bool isInitialized = false;
  late var bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final arg =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      sourceId = arg['id'];
      sourceTitle = arg['title'];
      isInitialized = true;
       bloc = BlocProvider.of<NewsScreenViewModel>(context)..loadSources(sourceId);

    }
  }

  @override
  Widget build(BuildContext context) {
    var appConst =AppConst(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(sourceTitle,style: appConst.textStyle.headlineLarge,),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return  IconButton(
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu));
          },

        ),
        actions: [
          Icon(Icons.search,size: 30,)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: NewsTapBar(onSourceChange: (id) {
              bloc.loadNews(id);

            },bloc: bloc,sourceId: sourceId,),
          ),
          Expanded(
            flex: 7,
            child: NewsItem(
                onSourceChanged: (id) {
                  bloc.loadNews(id);
                },
                sourceId: bloc.selectedSourceId,bloc: bloc,),
          ),
        ],
      ),
      drawer: SideDrawer(),
    );
  }
}
