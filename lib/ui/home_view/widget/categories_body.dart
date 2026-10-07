import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/category_filter.dart';
import 'package:news/ui/home_view/view_model/home_state.dart';
import 'package:news/ui/home_view/view_model/home_view_model.dart';
import 'package:news/ui/home_view/widget/category_filter_toggle.dart';
import 'package:news/ui/home_view/widget/category_list.dart';
import 'package:news/ui/widget/custom_text_form_field.dart';
import 'package:news/ui/widget/empty_view.dart';
import 'package:news/ui/widget/fade_in.dart';
import 'package:news/utils/app_animations.dart';

/// Home body: category search, the "All / Favorites" toggle, and the category list.
class CategoriesBody extends StatefulWidget {
  const CategoriesBody({super.key});

  @override
  State<CategoriesBody> createState() => _CategoriesBodyState();
}

class _CategoriesBodyState extends State<CategoriesBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Smoothly scrolls the category list back to the top.
  void _scrollToTop() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      0,
      duration: AppAnimations.pageJump,
      curve: AppAnimations.pageJumpCurve,
    );
  }

  /// Whether a category was just favorited on the "All" tab, so it now sits at the top.
  bool _hasNewFavorite(HomeState previous, HomeState current) {
    return current.filter == CategoryFilter.all &&
        current.favoriteCategoryIds.length >
            previous.favoriteCategoryIds.length;
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    final HomeViewModel viewModel = context.read<HomeViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
          child: Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus) _scrollToTop();
            },
            child: CustomTextFormField(
              hintText: strings.searchCategories,
              prefixIcon: Icons.search,
              maxLines: 1,
              onChanged: viewModel.search,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
          child: BlocSelector<HomeViewModel, HomeState, CategoryFilter>(
            selector: (state) => state.filter,
            builder: (context, filter) => CategoryFilterToggle(
              selectedFilter: filter,
              onChanged: viewModel.changeFilter,
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<HomeViewModel, HomeState>(
            listenWhen: _hasNewFavorite,
            listener: (_, _) => _scrollToTop(),
            builder: (context, state) {
              if (state.categories.isEmpty) {
                final bool hasNoFavorites =
                    state.filter == CategoryFilter.favorites &&
                    state.favoriteCategoryIds.isEmpty;
                return FadeIn(
                  key: const ValueKey('categories-empty'),
                  child: EmptyView(
                    message: hasNoFavorites
                        ? strings.noFavoriteCategories
                        : strings.noCategoriesFound,
                  ),
                );
              }
              return FadeIn(
                key: ValueKey('categories-${state.filter.name}'),
                child: CategoryList(
                  state: state,
                  scrollController: _scrollController,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
