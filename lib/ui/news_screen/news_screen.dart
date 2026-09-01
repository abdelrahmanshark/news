import 'package:flutter/material.dart';
import 'package:news/apis/api_manger.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final arg =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      sourceId = arg['id'];
      sourceTitle = arg['title'];
      isInitialized = true;
      loadSources();
    }
  }

  Future<void> loadSources()async{
    setState(() {
      sourcesFuture =  ApiManger.getSource(sourceId);
    });
    var id = await sourcesFuture!;
    selectedSourceId = id.sources?[0].id??'';
    loadNews(selectedSourceId);
  }
  Future<SourceResponse>? sourcesFuture;
  String selectedSourceId  = '';
  Future<NewsResponse>? newsFuture;

  void loadNews(String sourceId){
    setState(() {
      selectedSourceId = sourceId;
      newsFuture = ApiManger.getNewsBySourceId(selectedSourceId);
    });
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
        children: [
          Expanded(
            flex: 1,
            child: NewsTapBar(onSourceChange: (id) {
              loadNews(id);
            },sourcesFuture: sourcesFuture,),
          ),
          Expanded(
            flex: 7,
            child: NewsItem(newsFuture: newsFuture,
                onSourceChanged: (id) {
                  loadNews(id);
                },
                sourceId: selectedSourceId),
          ),
        ],
      ),
      drawer: SideDrawer(),
    );
  }
}
