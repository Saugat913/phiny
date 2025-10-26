import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phiny_gui/app/theme/app_color.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTitleBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.06),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Draggable area with logo and title
          Expanded(
            child: GestureDetector(
              onPanStart: (_) => windowManager.startDragging(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40, // Reduced from 100
                      height: 40, // Reduced from 100
                      child: Image.asset(
                        "assets/logo.png",
                        width: 32, // Reduced from 90
                        height: 32, // Reduced from 90
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(width: 12),
                    Text(
                      'Phiny',
                      style: TextStyle(
                        color: isDark ? AppColors.white : AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Window controls
          const WindowControls(),
        ],
      ),
    );
  }
}

class WindowControls extends StatelessWidget {
  const WindowControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowButton(
          icon: Icons.remove,
          onPressed: () => windowManager.minimize(),
          tooltip: 'Minimize',
        ),
        _WindowButton(
          icon: Icons.crop_square_outlined,
          onPressed: () async {
            if (await windowManager.isMaximized()) {
              windowManager.restore();
            } else {
              windowManager.maximize();
            }
          },
          tooltip: 'Maximize',
        ),
        _WindowButton(
          icon: Icons.close,
          onPressed: () => windowManager.close(),
          tooltip: 'Close',
          isCloseButton: true,
        ),
      ],
    );
  }
}

class _WindowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final bool isCloseButton;

  const _WindowButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.isCloseButton = false,
  });

  @override
  State<_WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<_WindowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 500),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            width: 46,
            height: 56,
            decoration: BoxDecoration(
              color: _isHovered
                  ? (widget.isCloseButton
                        ? const Color(0xFFDC2626)
                        : isDark
                        ? Colors.white.withOpacity(0.06)
                        : Colors.black.withOpacity(0.04))
                  : Colors.transparent,
            ),
            child: Center(
              child: Icon(
                widget.icon,
                color: _isHovered && widget.isCloseButton
                    ? Colors.white
                    : isDark
                    ? Colors.white.withOpacity(0.85)
                    : Colors.black.withOpacity(0.65),
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
