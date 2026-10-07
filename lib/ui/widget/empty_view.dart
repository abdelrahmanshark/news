import 'package:flutter/material.dart';
import 'package:news/utils/app_styles.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppStyles.grayRegular20,
        textAlign: TextAlign.center,
      ),
    );
  }
}
