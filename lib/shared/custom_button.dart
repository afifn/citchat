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
