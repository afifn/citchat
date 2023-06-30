import 'dart:math';

import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';

class CFillButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final VoidCallback onPressed;
  const CFillButton({
    this.width = double.infinity,
    this.height = 50,
    required this.title,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: monsterratTextStyle.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: medium
          ),
        ),
      ),
    );
  }
}

class CTextButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final VoidCallback onPressed;
  const CTextButton({
    this.width = double.infinity,
    this.height = 50,
    required this.title,
    required this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: monsterratTextStyle.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: medium
          ),
        ),
      ),
    );
  }
}

class CIconButton extends StatelessWidget {
  final Widget icon;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  const CIconButton({Key? key, required this.icon, this.width = 40, this.height = 40, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}

class CIconTextButton extends StatefulWidget {
  final int value;
  final String title;
  final Widget icon;
  final VoidCallback? onPressed;
  final Color bgColor;
  final bool isPressed;
  final ValueChanged<int?>? onChanged;
  final int? groupValue;

  const CIconTextButton({
    super.key,
    this.isPressed = false,
    required this.title,
    required this.icon,
    this.onPressed,
    required this.bgColor,
    required this.value,
    this.groupValue,
    this.onChanged,
  });

  @override
  State<CIconTextButton> createState() => _CIconTextButtonState();
}

class _CIconTextButtonState extends State<CIconTextButton> {

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(widget.value);
        }
      },
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: widget.isPressed ? widget.bgColor : widget.bgColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            widget.icon,
            const SizedBox(width: 8),
            Text(
              widget.title,
              style: monsterratTextStyle.copyWith(fontSize: 14, color: colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

Color getRandomColorFromScheme(ColorScheme colorScheme) {
  List<Color> colors = [
    colorScheme.primary,
    colorScheme.primaryVariant,
    colorScheme.secondary,
    colorScheme.secondaryVariant,
    colorScheme.surface,
    colorScheme.error,
    colorScheme.onPrimary,
    colorScheme.onSecondary,
    colorScheme.onSurface,
    colorScheme.onBackground,
    colorScheme.onError,
  ];
  Random random = Random();
  return colors[random.nextInt(colors.length)];
}