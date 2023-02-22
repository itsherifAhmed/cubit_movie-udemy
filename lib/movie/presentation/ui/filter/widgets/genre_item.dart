import 'package:flutter/material.dart';

class GenreItem extends StatelessWidget {
  final bool value;
  final String? title;
  final void Function(bool?)? onChanged;

  const GenreItem({
    Key? key,
    required this.value,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: (title ?? '').isEmpty,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 60,
          minHeight: 60,
          maxWidth: 400,
          minWidth: 180,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: Text(
                title ?? '',
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
