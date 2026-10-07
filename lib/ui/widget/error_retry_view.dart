import 'package:flutter/material.dart';
import 'package:news/utils/app_styles.dart';

class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: AppStyles.grayRegular20,
              textAlign: TextAlign.center,
            ),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              color: Theme.of(context).canvasColor,
            ),
          ],
        ),
      ),
    );
  }
}
