import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/ui/splash_view/view_model/splash_view_model.dart';
import 'package:news/ui/splash_view/widget/splash_logo_reveal.dart';
import 'package:news/ui/view_model/theme_view_model.dart';
import 'package:news/utils/app_animations.dart';
import 'package:news/utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  final SplashViewModel _viewModel = SplashViewModel();
  late final AnimationController _controller;
  bool _hasStarted = false;

  /// Creates the splash animation controller.
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.splashReveal,
    );
  }

  /// Starts the splash once, as soon as the context can load images.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStarted) return;
    _hasStarted = true;
    _startSplash();
  }

  /// Precaches the logo, swaps the native splash for the animation, then opens home.
  Future<void> _startSplash() async {
    await _viewModel.precacheSplashImages(context);
    _viewModel.removeNativeSplash();
    await _controller.forward();
    if (!mounted) return;
    _viewModel.openHome(context);
  }

  /// Stops the splash animation.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = context.select(
      (ThemeViewModel viewModel) => viewModel.state == ThemeMode.dark,
    );
    return Scaffold(
      body: Center(
        child: SplashLogoReveal(
          animation: _controller,
          color: isDarkTheme ? AppColors.whiteColor : AppColors.blackColor,
        ),
      ),
    );
  }
}
