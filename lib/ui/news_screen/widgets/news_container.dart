import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_const.dart';
import 'package:news/utils/app_styles.dart';

import '../../../models/NewsResponse.dart';

class NewsContainer extends StatefulWidget {
  Articles articles ;
   NewsContainer({super.key,required this.articles});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    var appConst = AppConst(context);
    return Container(
      margin: EdgeInsetsGeometry.symmetric(
        vertical: 10,
            horizontal: 15
      ),
      padding: EdgeInsetsGeometry.symmetric(
          vertical: 10,
          horizontal: 8
      ),
      height: appConst.height*0.45,
      width: double.infinity,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: appConst.theme.canvasColor
        )
      ),
      child: Column(
        children: [

          SizedBox(
            height: appConst.height * .3,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.articles.urlToImage??'',
                height: appConst.height * .3,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
              
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('IMAGE ERROR: $error');
              
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          SizedBox(height: 8,),
          Expanded(child: Text(widget.articles.title!,style:appConst.textStyle.headlineLarge ,)),
          Row(
            children: [
            Expanded(child: Text('By ${widget.articles.author}' ,style: AppStyles.bothGrayMed12,)),
              Text(widget.articles.publishedAt! ,style: AppStyles.bothGrayMed12,)
            ],
          )
        ],
      ),
    );
  }
}
