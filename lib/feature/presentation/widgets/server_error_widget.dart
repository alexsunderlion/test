import 'package:clubforce/core/util/constants.dart';
import 'package:flutter/material.dart';

class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget({Key? key, this.message = ErrorMessages.serverError, this.onRetry}) : super(key: key);
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Server Error',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message.isEmpty ? ErrorMessages.serverError : message,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.accentColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
