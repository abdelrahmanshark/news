import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/models/news_category.dart';
import 'package:news/ui/home_view/view_model/home_state.dart';
import 'package:news/ui/home_view/view_model/home_view_model.dart';
import 'package:news/ui/home_view/widget/category_card.dart';
import 'package:news/ui/home_view/widget/category_list_item.dart';

/// Scrollable list of category cards that animates cards moving to a new place.
class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.state,
    required this.scrollController,
  });

  final HomeState state;
  final ScrollController scrollController;

  /// Finds the new index of a card by its key, or null when it is no longer shown.
  int? _findCategoryIndex(Key key) {
    if (key is! ValueKey<String>) return null;
    final int index = state.categories.indexWhere(
      (category) => category.id == key.value,
    );
    return index == -1 ? null : index;
  }

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = context.read<HomeViewModel>();
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 4),
      itemCount: state.categories.length,
      // Lets a reordered card keep its state, so its animation continues smoothly.
      findChildIndexCallback: _findCategoryIndex,
      itemBuilder: (context, index) {
        final NewsCategory category = state.categories[index];
        return CategoryListItem(
          key: ValueKey(category.id),
          isMoving: state.isMoving(category.id),
          isArriving: state.isArriving(category.id),
          child: CategoryCard(
            category: category,
            isIconAtStart: viewModel.isIconAtStart(category),
            isFavorite: state.isFavorite(category.id),
            onTap: () => viewModel.openCategory(context, category),
            onFavoriteTap: () => viewModel.toggleFavorite(category),
          ),
        );
      },
    );
  }
}
