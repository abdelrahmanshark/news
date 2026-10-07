import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/ui/home_view/view_model/home_view_model.dart';
import 'package:news/ui/home_view/widget/categories_body.dart';
import 'package:news/ui/home_view/widget/side_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).home)),
        drawer: const SideDrawer(),
        body: const CategoriesBody(),
      ),
    );
  }
}
