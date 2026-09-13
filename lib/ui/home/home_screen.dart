import 'package:flutter/material.dart';
import 'package:news/ui/home/home_screen_view_model.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_const.dart';
import 'package:news/utils/app_styles.dart';
import 'package:news/widgets/drop_down_theme_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel(context: context);
    var appConst = AppConst(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',style: appConst.textStyle.headlineLarge,),
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
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
            horizontal: 15,
        vertical: 20
        ),
        child: Column(
            children: [
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      homeScreenViewModel.onTab(index);
                    },
                    child: Image.asset(homeScreenViewModel.newsCategory![index].image,fit: BoxFit.cover,));
              },
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: homeScreenViewModel.newsCategory!.length),
        )
            ],
        ),
      ),
      drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightColor
                  ),
                  child: Center(child: Text('News App',style: AppStyles.blackBold24,)),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryDarkColor
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10,
                    vertical: 20),
                    child: Column(
                      children: [
                       Row(
                         children: [
                           Icon(Icons.home_outlined,color: AppColors.primaryLightColor,),
                           SizedBox(width: 20,),
                           Text('Go to home' ,style: AppStyles.whiteBold20,)
                         ],
                       ),
                        SizedBox(height: 20,),
                        Divider(color: AppColors.primaryLightColor,height: 1,),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Icon(Icons.light,color: AppColors.primaryLightColor,),
                            SizedBox(width: 20,),
                            Text('Theme' ,style: AppStyles.whiteBold20,)
                          ],
                        ),
                        SizedBox(height: 20,),
                        DropDownThemeMenu()
                      ],
                    ),
                  ),
                ),
              )
            ],
          )

      ),
    );

  }
}
