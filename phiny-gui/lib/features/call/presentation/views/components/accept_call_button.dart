import 'package:flutter/material.dart';
import 'package:phiny_gui/app/theme/app_color.dart';

import 'build_call_button.dart';

class AcceptCallButton extends StatelessWidget {
  const AcceptCallButton({super.key, required this.onAcceptCall});
  final VoidCallback onAcceptCall;

  @override
  Widget build(BuildContext context) {
    return buildCallButton(
      icon: Icons.call,
      color: AppColors.success,
      label: 'Accept',
      onTap: onAcceptCall,
    );
  }
}
