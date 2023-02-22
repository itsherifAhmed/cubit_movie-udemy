import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final int? maxLines;
  final String? prefix;
  final Widget? suffix;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const AppTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.maxLines,
    this.prefix,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.contentPadding = const EdgeInsets.only(left: 12),
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        maxLines: maxLines,
        focusNode: focusNode,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: Theme.of(context).primaryColor,
        autocorrect: false,
        obscureText: obscureText,
        autofocus: false,
        inputFormatters: inputFormatters ?? [
          LengthLimitingTextInputFormatter(100),
        ],
        decoration: _textFieldStyle(
          context: context,
          hint: hint,
          maxLines: maxLines,
          prefix: prefix,
          contentPadding: contentPadding,
          backgroundColor: backgroundColor,
          suffix: suffix,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }

  InputDecoration _textFieldStyle({
    required BuildContext context,
    required String hint,
    required int? maxLines,
    required String? prefix,
    required EdgeInsets contentPadding,
    required Color? backgroundColor,
    required Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      hintMaxLines: 1,
      fillColor: backgroundColor ?? Theme.of(context).backgroundColor,
      contentPadding: contentPadding,
      constraints: maxLines == 1 ? const BoxConstraints(
        minHeight: 48,
        maxHeight: 48,
      ) : null,
      prefixIcon: prefix == null ? null : Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 2,
        ),
        child: Text(
            prefix,
            style: Theme.of(context).textTheme.subtitle1
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 225,
        minHeight: 22,
      ),
      suffixIcon: suffix,
      border: _outlineInputBorder(),
      errorBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      disabledBorder: _outlineInputBorder(),
      focusedErrorBorder: _outlineInputBorder(),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    );
  }
}