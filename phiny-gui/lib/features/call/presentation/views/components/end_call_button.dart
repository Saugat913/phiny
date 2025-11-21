import 'package:flutter/material.dart';
import 'package:phiny_gui/app/theme/app_color.dart';

import 'build_call_button.dart';

class EndCallButton extends StatelessWidget {
  const EndCallButton({super.key, required this.onEndCall});
  final VoidCallback onEndCall;
  @override
  Widget build(BuildContext context) {
    return buildCallButton(
      icon: Icons.call_end,
      color: AppColors.red,
      label: 'Decline',
      onTap: onEndCall,
    );
  }
}
