import 'package:flutter/material.dart';
import 'package:phiny_gui/app/theme/app_color.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 20,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: AppColors.avatarBg,
        child: Icon(Icons.person, size: 70, color: AppColors.avatarIcon),
      ),
    );
    ;
  }
}
