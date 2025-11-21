import 'package:flutter/material.dart';
import 'package:phiny_gui/app/theme/app_size.dart';

Widget buildCallButton({
  required IconData icon,
  required Color color,
  required String label,
  required VoidCallback onTap,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
      ),
      const SizedBox(height: AppSize.paddingSmall),
      Text(
        label,
        style: TextStyle(
          fontSize: AppSize.fontSmall,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
