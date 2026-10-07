import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news/utils/app_animations.dart';
import 'package:news/utils/app_assets.dart';
import 'package:news/utils/app_routes.dart';

class SplashViewModel {
  /// Loads the splash logo so the first animated frame is never blank.
  Future<void> precacheSplashImages(BuildContext context) {
    return precacheImage(const AssetImage(AppAssets.splashLogo), context);
  }

  /// Hides the native splash so the animated Flutter splash becomes visible.
  void removeNativeSplash() {
    FlutterNativeSplash.remove();
  }

  /// Waits briefly on the finished logo, then replaces the splash with home.
  Future<void> openHome(BuildContext context) async {
    await Future.delayed(AppAnimations.splashHold);
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
  }
}
