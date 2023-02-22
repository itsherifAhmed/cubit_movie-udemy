
import 'package:flutter/material.dart';

import '../style/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final EdgeInsets padding;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 22,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0.4),
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            onPressed: onTap,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
