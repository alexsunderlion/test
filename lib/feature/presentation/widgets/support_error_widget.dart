import 'package:clubforce/core/util/constants.dart';
import 'package:flutter/material.dart';

class SupportErrorWidget extends StatelessWidget {
  const SupportErrorWidget({Key? key, this.message = ErrorMessages.fatalErrorMessage}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Error',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              //Call or redirect to support page
            },
            child: const Text(
              'Contact Support',
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
