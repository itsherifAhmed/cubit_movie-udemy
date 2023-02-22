
import 'package:flutter/material.dart';

import '../style/colors.dart';
import 'app_progress.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  final bool isPerson;
  final double personSize;
  final bool isProgress;
  final double? width;
  final double? height;

  const AppNetworkImage({
    Key? key,
    required this.url,
    this.isPerson = false,
    this.personSize = 30,
    this.isProgress = true,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.black.withOpacity(0.1),
      child: (url?? '').isEmpty ? AppMediaError(
        isPerson: isPerson,
        personSize: personSize,
      ) : Image.network(
        url!,
        width: width,
        height: height,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.none,
        loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return isProgress ? const AppProgress() : const Offstage();
          }
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return AppMediaError(
            isPerson: isPerson,
            personSize: personSize,
          );
        },
      ),
    );
  }
}

class AppMediaError extends StatelessWidget {
  final bool isPerson;
  final double personSize;

  const AppMediaError({
    Key? key,
    required this.isPerson,
    required this.personSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isPerson ? Icon(
        Icons.person,
        size: personSize,
      ) : const Icon(
        Icons.error_outline,
      ),
    );
  }
}
