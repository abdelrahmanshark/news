import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/category_filter.dart';
import 'package:news/models/news_category.dart';
import 'package:news/ui/home_view/view_model/home_state.dart';
import 'package:news/utils/app_animations.dart';
import 'package:news/utils/app_routes.dart';
import 'package:news/utils/arabic_normalizer.dart';
import 'package:news/utils/shared_preferences.dart';

class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel() : super(const HomeState(categories: _categories)) {
    _loadFavorites();
  }

  /// Every category supported by the NewsData.io `category` parameter.
  static const List<NewsCategory> _categories = [
    NewsCategory(id: 'top', icon: Icons.star_outline),
    NewsCategory(id: 'breaking', icon: Icons.bolt),
    NewsCategory(id: 'world', icon: Icons.public),
    NewsCategory(id: 'domestic', icon: Icons.flag_outlined),
    NewsCategory(id: 'politics', icon: Icons.account_balance_outlined),
    NewsCategory(id: 'business', icon: Icons.business_center_outlined),
    NewsCategory(id: 'technology', icon: Icons.memory),
    NewsCategory(id: 'science', icon: Icons.science_outlined),
    NewsCategory(id: 'health', icon: Icons.health_and_safety_outlined),
    NewsCategory(id: 'sports', icon: Icons.sports_soccer),
    NewsCategory(id: 'entertainment', icon: Icons.movie_outlined),
    NewsCategory(id: 'education', icon: Icons.school_outlined),
    NewsCategory(id: 'environment', icon: Icons.eco_outlined),
    NewsCategory(id: 'food', icon: Icons.restaurant_outlined),
    NewsCategory(id: 'lifestyle', icon: Icons.spa_outlined),
    NewsCategory(id: 'tourism', icon: Icons.flight_takeoff),
    NewsCategory(id: 'crime', icon: Icons.gavel),
    NewsCategory(id: 'other', icon: Icons.more_horiz),
  ];

  /// Newest favorite first.
  List<String> _favoriteIds = [];
  final Set<String> _movingIds = {};
  final Set<String> _arrivingIds = {};
  CategoryFilter _filter = CategoryFilter.all;
  String _query = '';

  /// Loads the saved favorites, ignoring ids of categories that no longer exist.
  Future<void> _loadFavorites() async {
    final List<String> savedIds = await getFavoriteCategoryIds();
    if (isClosed) return;
    _favoriteIds = savedIds
        .where((id) => _categories.any((category) => category.id == id))
        .toList();
    _emitState();
  }

  /// Keeps only the categories whose name contains [query], ignoring case and Arabic diacritics.
  void search(String query) {
    _query = normalizeArabic(query.trim().toLowerCase());
    _emitState();
  }

  /// Switches between the "All" and "Favorites" tabs.
  void changeFilter(CategoryFilter filter) {
    if (_filter == filter) return;
    _filter = filter;
    _emitState();
  }

  /// Favorites or unfavorites [category]: it shrinks away, then grows back at its new place.
  Future<void> toggleFavorite(NewsCategory category) async {
    final String id = category.id;
    if (_movingIds.contains(id)) return;
    _movingIds.add(id);
    _emitState();
    // Waits for the card's shrink animation before reordering the list.
    await Future<void>.delayed(AppAnimations.listMove);
    if (isClosed) return;
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.insert(0, id);
    }
    _movingIds.remove(id);
    _arrivingIds.add(id);
    _emitState();
    await saveFavoriteCategoryIds(_favoriteIds);
    await Future<void>.delayed(AppAnimations.listMove);
    if (isClosed) return;
    _arrivingIds.remove(id);
    _emitState();
  }

  /// Whether [category]'s icon sits on the reading-start side.
  ///
  /// Based on the original order, so cards don't flip sides while the list reorders.
  bool isIconAtStart(NewsCategory category) {
    return _categories.indexOf(category).isEven;
  }

  /// Opens the news screen of [category].
  void openCategory(BuildContext context, NewsCategory category) {
    Navigator.pushNamed(context, AppRoutes.newsRouteName, arguments: category);
  }

  /// Publishes the current favorites, tab, search, and animation state.
  void _emitState() {
    emit(
      HomeState(
        categories: _visibleCategories(),
        filter: _filter,
        favoriteCategoryIds: List.unmodifiable(_favoriteIds),
        movingCategoryIds: Set.unmodifiable(_movingIds),
        arrivingCategoryIds: Set.unmodifiable(_arrivingIds),
      ),
    );
  }

  /// Returns favorites first (only favorites on the "Favorites" tab), matching the search.
  List<NewsCategory> _visibleCategories() {
    final List<NewsCategory> favorites = _favoriteIds
        .map((id) => _categories.firstWhere((category) => category.id == id))
        .toList();
    final List<NewsCategory> orderedCategories =
        _filter == CategoryFilter.favorites
        ? favorites
        : [
            ...favorites,
            ..._categories.where(
              (category) => !_favoriteIds.contains(category.id),
            ),
          ];
    return orderedCategories
        .where(
          (category) => normalizeArabic(
            category.localizedName(S.current).toLowerCase(),
          ).contains(_query),
        )
        .toList();
  }
}
