import 'package:flutter/material.dart';

class BankaiSplash extends StatelessWidget {
  const BankaiSplash({super.key, required this.progress, this.size = 220});
  final double progress;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Opacity(
        opacity: progress.clamp(0.0, 1.0),
        child: Image.asset('assets/icon/app_icon.png', fit: BoxFit.contain),
      ),
    );
  }
}
