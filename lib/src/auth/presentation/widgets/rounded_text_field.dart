import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

import '../../../../configs/colors/generic_colors.dart';

class RoundedTextField extends StatefulWidget {
  const RoundedTextField({
    super.key,
    this.obscureText,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.backgroundColor,
    this.inactiveBackgroundColor,
    this.iconsColor,
    this.inactiveIconsColor,
    this.onChanged,
    this.onEditingComplete,
    this.onFocusChanged,
    this.onSuffixIconPressed,
  });

  final bool? obscureText;
  final TextInputType? keyboardType;

  /// Will be disposed by the widget, if null a new controller will be created
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final String? labelText;
  final Color? backgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? iconsColor;
  final Color? inactiveIconsColor;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<bool>? onFocusChanged;
  final VoidCallback? onSuffixIconPressed;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode()
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  TextTheme get textTheme => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    final fillColor = _focusNode.hasFocus ? widget.backgroundColor : widget.inactiveBackgroundColor;

    return TextFormField(
      autocorrect: false,
      controller: _controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText ?? false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        label: Text(widget.labelText ?? ''),
        hintText: widget.hintText,
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: TColors.lightGrey,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.prefixIcon != null ? 20 : 10,
          vertical: 15,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: _focusNode.hasFocus ? widget.iconsColor : widget.inactiveIconsColor,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: widget.onSuffixIconPressed,
                child: Icon(
                  widget.suffixIcon,
                  color: _focusNode.hasFocus ? widget.iconsColor : widget.inactiveIconsColor,
                ),
              )
            : null,
        filled: fillColor != null,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onEditingComplete: () {
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete!();
        } else if (_focusNode.hasFocus) {
          _focusNode.nextFocus();
        }
      },
    );
  }
}
