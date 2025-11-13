import 'package:flutter/material.dart';
import 'package:phiny_gui/app/theme/app_color.dart';
import 'package:phiny_gui/app/theme/app_size.dart';

enum CallState { ringing, connecting, connected }

class CallingPage extends StatefulWidget {
  final String targetNodeId;
  final String targetName;
  final bool isIncoming;

  const CallingPage({
    Key? key,
    required this.targetNodeId,
    this.targetName = "Unknown",
    this.isIncoming = false,
  }) : super(key: key);

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  CallState _callState = CallState.ringing;
  Duration _callDuration = Duration.zero;
  bool _isMuted = false;
  bool _isSpeakerOn = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // If incoming call, start in ringing state
    // Otherwise simulate connection after 3 seconds
    if (!widget.isIncoming) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _acceptCall();
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _acceptCall() {
    setState(() {
      _callState = CallState.connecting;
    });

    // Simulate connection delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _callState = CallState.connected;
        });
        _startCallTimer();
      }
    });
  }

  void _startCallTimer() {
    Future.doWhile(() async {
      if (!mounted || _callState != CallState.connected) return false;
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && _callState == CallState.connected) {
        setState(() {
          _callDuration += const Duration(seconds: 1);
        });
        return true;
      }
      return false;
    });
  }

  void _endCall() {
    Navigator.pop(context);
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleSpeaker() {
    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });
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

  String _getStatusText() {
    switch (_callState) {
      case CallState.ringing:
        return widget.isIncoming ? 'Incoming call...' : 'Calling...';
      case CallState.connecting:
        return 'Connecting...';
      case CallState.connected:
        return _formatDuration(_callDuration);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          boxShadow: _callState == CallState.ringing
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
                    _getStatusText(),
                    style: TextStyle(
                      fontSize: AppSize.fontMedium,
                      color: _callState == CallState.connected
                          ? AppColors.success
                          : AppColors.textSecondary,
                      fontWeight: _callState == CallState.connected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),

                  const SizedBox(height: AppSize.paddingSmall),

                  // Node ID
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.paddingMedium,
                      vertical: AppSize.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSize.radiusMedium),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      widget.targetNodeId,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),

                  const Spacer(),

                  // Control buttons (only when connected)
                  if (_callState == CallState.connected) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildControlButton(
                          icon: _isMuted ? Icons.mic_off : Icons.mic,
                          label: 'Mute',
                          isActive: _isMuted,
                          onTap: _toggleMute,
                        ),
                        const SizedBox(width: AppSize.paddingLarge),
                        _buildControlButton(
                          icon: _isSpeakerOn
                              ? Icons.volume_up
                              : Icons.volume_down,
                          label: 'Speaker',
                          isActive: _isSpeakerOn,
                          onTap: _toggleSpeaker,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.paddingXLarge),
                  ],

                  // Call action buttons
                  if (_callState == CallState.ringing && widget.isIncoming)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCallButton(
                          icon: Icons.call_end,
                          color: AppColors.red,
                          label: 'Decline',
                          onTap: _endCall,
                        ),
                        const SizedBox(width: AppSize.paddingXLarge),
                        _buildCallButton(
                          icon: Icons.call,
                          color: AppColors.success,
                          label: 'Accept',
                          onTap: _acceptCall,
                        ),
                      ],
                    )
                  else
                    _buildCallButton(
                      icon: Icons.call_end,
                      color: AppColors.red,
                      label: _callState == CallState.connected
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
