import 'package:flutter/material.dart';
import 'package:talking/configs/colors/generic_colors.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    required this.icon,
    this.hintText,
    this.obscureText,
    this.keyboardType,
    required this.controller,
    this.onChanged,
  });

  final IconData icon;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: TColors.white,
        shadows: [
          BoxShadow(
            color: TColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 5),
          ),
        ],
        shape: const StadiumBorder(),
      ),
      child: TextFormField(
        autocorrect: false,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          prefixIconColor: Theme.of(context).colorScheme.outline,
          prefixIcon: Icon(icon),
          hintStyle: Theme.of(context).textTheme.bodyLarge,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
