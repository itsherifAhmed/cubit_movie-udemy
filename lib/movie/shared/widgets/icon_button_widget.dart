import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final void Function() onPressed;
  final Color? color;
  final double buttonSize;
  final double iconSize;

  const IconButtonWidget({
    Key? key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.color,
    this.buttonSize = 50,
    this.iconSize = 30,
  })  : assert(buttonSize > 0),
        assert(iconSize > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: MaterialButton(
        height: buttonSize,
        minWidth: buttonSize,
        elevation: 0.0,
        focusElevation: 0.0,
        hoverElevation: 0.0,
        disabledElevation: 0.0,
        highlightElevation: 0.0,
        padding: EdgeInsets.zero,
        color: Theme.of(context).backgroundColor,
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
