import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/di/injection.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/models/news_category.dart';
import 'package:news/ui/home_view/news_view/view_model/articles_view_model.dart';
import 'package:news/ui/home_view/news_view/widget/articles_list.dart';
import 'package:news/ui/home_view/widget/side_drawer.dart';
import 'package:news/ui/view_model/country_view_model.dart';
import 'package:news/ui/view_model/language_view_model.dart';
import 'package:news/ui/widget/custom_text_form_field.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key, required this.category});

  final NewsCategory category;

  /// Loads this category's articles for the current app language and news country.
  void _loadArticles(BuildContext context, ArticlesViewModel articlesViewModel) {
    articlesViewModel.loadArticles(
      categoryId: category.id,
      languageCode: context.read<LanguageViewModel>().state.languageCode,
      countryCode: context.read<CountryViewModel>().state,
    );
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);
    return BlocProvider(
      create: (context) {
        final ArticlesViewModel articlesViewModel = getIt<ArticlesViewModel>();
        _loadArticles(context, articlesViewModel);
        return articlesViewModel;
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<LanguageViewModel, Locale>(
            listener: (context, _) =>
                _loadArticles(context, context.read<ArticlesViewModel>()),
          ),
          BlocListener<CountryViewModel, String?>(
            listener: (context, _) =>
                _loadArticles(context, context.read<ArticlesViewModel>()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: Text(category.localizedName(strings))),
          drawer: const SideDrawer(),
          body: Builder(
            builder: (context) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 12, 15, 4),
                  child: CustomTextFormField(
                    hintText: strings.searchNews,
                    prefixIcon: Icons.search,
                    maxLines: 1,
                    onChanged: context.read<ArticlesViewModel>().search,
                  ),
                ),
                const Expanded(child: ArticlesList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
