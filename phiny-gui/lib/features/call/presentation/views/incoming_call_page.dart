import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phiny_gui/app/theme/app_color.dart';
import 'package:phiny_gui/app/theme/app_size.dart';
import 'package:phiny_gui/features/call/presentation/views/components/accept_call_button.dart';
import 'package:phiny_gui/features/call/presentation/views/components/avatar.dart';
import 'package:phiny_gui/features/call/presentation/views/components/end_call_button.dart';

class IncomingCallPage extends ConsumerWidget {
  final String targetName;
  final String targetNodeId;
  final bool isIncoming;
  final void Function() onEndCall;
  final void Function() onAcceptCall;

  const IncomingCallPage({
    super.key,
    required this.targetName,
    required this.targetNodeId,
    required this.onEndCall,
    required this.onAcceptCall,
    this.isIncoming = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 400, // Fixed width for compact dialog
      padding: const EdgeInsets.all(AppSize.paddingLarge * 1.5),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with pulse animation
          Avatar(),

          const SizedBox(height: AppSize.paddingLarge),

          // Name
          Text(
            targetName.isNotEmpty ? targetName : "Unknown Caller",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSize.paddingSmall),

          // Status text
          Text(
            'Incoming call...',
            style: TextStyle(
              fontSize: AppSize.fontMedium,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppSize.paddingXLarge),

          // Call action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EndCallButton(onEndCall: onEndCall),
              AcceptCallButton(onAcceptCall: onAcceptCall),
            ],
          ),
        ],
      ),
    );
  }
}
