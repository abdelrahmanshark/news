import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/news_category.dart';
import 'package:news/ui/home_view/widget/favorite_button.dart';
import 'package:news/ui/home_view/widget/swipe_view_all_button.dart';
import 'package:news/ui/view_model/theme_view_model.dart';
import 'package:news/ui/widget/pressable_scale.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

/// Home category card: category icon, localized name, a favorite heart, and a swipeable "View All".
///
/// Laid out at the 363 x 198 design size and scaled to the available width.
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.isIconAtStart,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final NewsCategory category;

  /// Whether the icon sits on the reading-start side; cards alternate sides.
  final bool isIconAtStart;

  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  static const double _designWidth = 363;
  static const double _designHeight = 198;
  static const double _radius = 24;
  static const double _padding = 16;
  static const double _iconSize = 110;
  static const int _iconAreaFlex = 42;
  static const int _textAreaFlex = 58;
  static const double _favoriteInset = 4;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = context.select(
      (ThemeViewModel viewModel) => viewModel.state == ThemeMode.dark,
    );
    // Cards use the opposite color of the screen so they stand out.
    final Color cardColor = isDarkTheme
        ? AppColors.whiteColor
        : AppColors.blackColor;
    final Color contrastColor = isDarkTheme
        ? AppColors.blackColor
        : AppColors.whiteColor;
    final S strings = S.of(context);
    final Widget iconArea = Expanded(
      flex: _iconAreaFlex,
      child: Center(
        child: Icon(category.icon, size: _iconSize, color: contrastColor),
      ),
    );
    final Widget textArea = Expanded(
      flex: _textAreaFlex,
      child: Column(
        crossAxisAlignment: isIconAtStart
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  category.localizedName(strings),
                  style: isDarkTheme
                      ? AppStyles.blackMedium32
                      : AppStyles.whiteMedium32,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          SwipeViewAllButton(
            label: strings.viewAll,
            labelStyle: isDarkTheme
                ? AppStyles.whiteMedium24
                : AppStyles.blackMedium24,
            cardColor: cardColor,
            contrastColor: contrastColor,
            isKnobAtEnd: isIconAtStart,
            onSwiped: onTap,
          ),
        ],
      ),
    );
    return PressableScale(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: _designWidth / _designHeight,
        child: FittedBox(
          child: Container(
            width: _designWidth,
            height: _designHeight,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(_radius),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(_padding),
                  // Row follows the reading direction, so "start" flips in Arabic.
                  child: Row(
                    children: isIconAtStart
                        ? [iconArea, textArea]
                        : [textArea, iconArea],
                  ),
                ),
                // Sits in the icon area's top corner, away from the category name.
                PositionedDirectional(
                  top: _favoriteInset,
                  start: isIconAtStart ? _favoriteInset : null,
                  end: isIconAtStart ? null : _favoriteInset,
                  child: FavoriteButton(
                    isFavorite: isFavorite,
                    color: contrastColor,
                    onPressed: onFavoriteTap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
