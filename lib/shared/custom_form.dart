import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';

class CFormField extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final bool obscureText;
  final bool isShowIcon;
  final TextEditingController controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLength;
  const CFormField({
    this.title,
    required this.controller,
    this.validator,
    this.maxLength,
    this.obscureText = false,
    this.isShowTitle = true,
    this.isShowIcon = false,
    this.icon,
    this.onChanged,
    this.keyboardType,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorIcon = Theme.of(context).colorScheme.surfaceVariant;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Text(title!, style: monsterratTextStyle.copyWith(fontWeight: medium),),
        if (isShowTitle) const SizedBox(height: 8,),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          autocorrect: false,
          validator: validator,
          maxLength: maxLength,
          style: monsterratTextStyle.copyWith(),
          decoration: InputDecoration(
            hintText: !isShowTitle ? title : null,
            hintStyle: !isShowTitle ? monsterratTextStyle.copyWith(fontSize: 14) : null,
            prefixIcon: isShowIcon ? icon : null,
            prefixIconColor: isShowIcon ? colorIcon : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}


class CFormChat extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final TextInputType? keyboardType;
  const CFormChat({
    Key? key,
    this.controller,
    required this.hint,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      style: monsterratTextStyle.copyWith(fontSize: 14),
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: monsterratTextStyle.copyWith(fontSize: 14),
        border: InputBorder.none,
        // contentPadding: const EdgeInsets.all(11),
      ),
    );
  }
}
