import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/category_filter.dart';
import 'package:news/ui/home_view/widget/category_filter_option.dart';
import 'package:news/ui/view_model/theme_view_model.dart';
import 'package:news/utils/app_animations.dart';
import 'package:news/utils/app_styles.dart';

/// Two-option switch between all categories and favorite categories.
///
/// A filled thumb slides under the selected option.
class CategoryFilterToggle extends StatelessWidget {
  const CategoryFilterToggle({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  final CategoryFilter selectedFilter;
  final ValueChanged<CategoryFilter> onChanged;

  static const double _height = 52;
  static const double _radius = 26;
  static const double _borderWidth = 2;
  static const double _thumbInset = 4;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = context.select(
      (ThemeViewModel viewModel) => viewModel.state == ThemeMode.dark,
    );
    final ThemeData theme = Theme.of(context);
    final S strings = S.of(context);
    // The thumb uses the screen's contrast color, so its label uses the screen color.
    final TextStyle selectedStyle = isDarkTheme
        ? AppStyles.blackBold16
        : AppStyles.whiteBold16;
    final TextStyle unselectedStyle = isDarkTheme
        ? AppStyles.whiteBold16
        : AppStyles.blackBold16;
    final bool isAllSelected = selectedFilter == CategoryFilter.all;
    return Container(
      height: _height,
      padding: const EdgeInsets.all(_thumbInset),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: theme.canvasColor, width: _borderWidth),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedAlign(
            alignment: isAllSelected
                ? AlignmentDirectional.centerStart
                : AlignmentDirectional.centerEnd,
            duration: AppAnimations.fast,
            curve: AppAnimations.curve,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.circular(_radius),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CategoryFilterOption(
                  label: strings.filterAll,
                  style: isAllSelected ? selectedStyle : unselectedStyle,
                  onTap: () => onChanged(CategoryFilter.all),
                ),
              ),
              Expanded(
                child: CategoryFilterOption(
                  label: strings.filterFavorites,
                  style: isAllSelected ? unselectedStyle : selectedStyle,
                  onTap: () => onChanged(CategoryFilter.favorites),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
