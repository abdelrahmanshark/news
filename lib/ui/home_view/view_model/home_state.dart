import 'package:news/models/category_filter.dart';
import 'package:news/models/news_category.dart';

class HomeState {
  const HomeState({
    required this.categories,
    this.filter = CategoryFilter.all,
    this.favoriteCategoryIds = const [],
    this.movingCategoryIds = const {},
    this.arrivingCategoryIds = const {},
  });

  /// Categories to show: favorites first, then filtered by the selected tab and search.
  final List<NewsCategory> categories;
  final CategoryFilter filter;

  /// Ids of the favorite categories, newest first.
  final List<String> favoriteCategoryIds;

  /// Categories shrinking away before they move to their new place.
  final Set<String> movingCategoryIds;

  /// Categories growing back in at their new place.
  final Set<String> arrivingCategoryIds;

  /// Whether [categoryId] is a favorite; a moving category already shows its new state.
  bool isFavorite(String categoryId) {
    return favoriteCategoryIds.contains(categoryId) !=
        movingCategoryIds.contains(categoryId);
  }

  /// Whether [categoryId] is shrinking away before it moves.
  bool isMoving(String categoryId) => movingCategoryIds.contains(categoryId);

  /// Whether [categoryId] is growing back in at its new place.
  bool isArriving(String categoryId) =>
      arrivingCategoryIds.contains(categoryId);
}
