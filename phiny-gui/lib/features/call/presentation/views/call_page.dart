import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/theme/app_color.dart';
import 'package:phiny_gui/app/theme/app_size.dart';
import 'package:phiny_gui/features/call/presentation/viewmodels/call_viewmodels.dart';
import 'package:phiny_gui/features/call/presentation/state/call_viewmodels_state.dart';

class CallingPage extends ConsumerStatefulWidget {
  final String targetNodeId;
  final String targetName;

  const CallingPage({
    super.key,
    required this.targetNodeId,
    this.targetName = "Unknown",
  });

  @override
  ConsumerState<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends ConsumerState<CallingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Start the call automatically when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(callViewModelProvider.notifier).startCall();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _endCall() {
    ref.read(callViewModelProvider.notifier).endCall();
    if (mounted) {
      context.go("/dialpad");
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  String _getStatusText(CallViewState callState, Duration duration) {
    switch (callState) {
      case CallViewState.connecting:
        return 'Connecting...';
      case CallViewState.connected:
        return _formatDuration(duration);
      case CallViewState.idle:
        return 'Call ended';
    }
  }

  @override
  Widget build(BuildContext context) {
    final callState = ref.watch(callViewModelProvider);

    if (callState.callState == CallViewState.idle) {
      _endCall();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(AppSize.paddingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Avatar with pulse animation
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow:
                              callState.callState == CallViewState.connecting
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(
                                      0.3 * _pulseController.value,
                                    ),
                                    blurRadius: 40,
                                    spreadRadius: 20 * _pulseController.value,
                                  ),
                                ]
                              : null,
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: AppColors.avatarBg,
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: AppColors.avatarIcon,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppSize.paddingLarge),

                  // Name
                  Text(
                    widget.targetName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppSize.paddingSmall),

                  // Status or Timer
                  Text(
                    _getStatusText(callState.callState, callState.callDuration),
                    style: TextStyle(
                      fontSize: AppSize.fontMedium,
                      color: callState.callState == CallViewState.connected
                          ? AppColors.success
                          : AppColors.textSecondary,
                      fontWeight: callState.callState == CallViewState.connected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),

                  const SizedBox(height: AppSize.paddingSmall),

                  const Spacer(),

                  // Control buttons (only when connected)
                  if (callState.callState == CallViewState.connected) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildControlButton(
                          icon: callState.isMuted ? Icons.mic_off : Icons.mic,
                          label: 'Mute',
                          isActive: callState.isMuted,
                          onTap: () {
                            ref
                                .read(callViewModelProvider.notifier)
                                .toggleMute();
                          },
                        ),
                        const SizedBox(width: AppSize.paddingLarge),
                        _buildControlButton(
                          icon: callState.isSpeakerOn
                              ? Icons.volume_up
                              : Icons.volume_down,
                          label: 'Speaker',
                          isActive: callState.isSpeakerOn,
                          onTap: () {
                            ref
                                .read(callViewModelProvider.notifier)
                                .toggleSpeaker();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.paddingXLarge),
                  ],

                  // End call button
                  _buildCallButton(
                    icon: Icons.call_end,
                    color: AppColors.red,
                    label: callState.callState == CallViewState.connected
                        ? 'End Call'
                        : 'Cancel',
                    onTap: _endCall,
                  ),

                  const SizedBox(height: AppSize.paddingLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppColors.primary : AppColors.border,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textSecondary,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: AppSize.paddingSmall),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? AppColors.primary : AppColors.textSecondary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildCallButton({
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
}
