import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/drop_down_theme_menu.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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

    );
  }
}
