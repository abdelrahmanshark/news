import 'package:flutter/widgets.dart';
import 'package:news/generated/l10n.dart';

class NewsCategory {
  const NewsCategory({required this.id, required this.icon});

  /// Category code expected by the NewsData.io `category` parameter (e.g. `sports`).
  final String id;

  /// Icon shown on the category card.
  final IconData icon;

  /// Returns the category name in the current app language.
  String localizedName(S strings) {
    return switch (id) {
      'top' => strings.categoryTop,
      'breaking' => strings.categoryBreaking,
      'world' => strings.categoryWorld,
      'domestic' => strings.categoryDomestic,
      'politics' => strings.categoryPolitics,
      'business' => strings.categoryBusiness,
      'technology' => strings.categoryTechnology,
      'science' => strings.categoryScience,
      'health' => strings.categoryHealth,
      'sports' => strings.categorySports,
      'entertainment' => strings.categoryEntertainment,
      'education' => strings.categoryEducation,
      'environment' => strings.categoryEnvironment,
      'food' => strings.categoryFood,
      'lifestyle' => strings.categoryLifestyle,
      'tourism' => strings.categoryTourism,
      'crime' => strings.categoryCrime,
      _ => strings.categoryOther,
    };
  }
}
