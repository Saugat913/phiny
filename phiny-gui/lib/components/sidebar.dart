import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/theme/app_color.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.currentActiveIndex});
  final int currentActiveIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(right: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SideBarItem(
              icon: Icons.dialpad,
              label: "Dial Pad",
              isSelected: currentActiveIndex == 0,
              routePath: "/dialpad",
            ),
            SideBarItem(
              icon: Icons.history,
              label: "History",
              isSelected: currentActiveIndex == 1,
              routePath: "/callhistory",
            ),
            Spacer(),
            SideBarItem(
              icon: Icons.person_2_outlined,
              label: "Profile",
              isSelected: currentActiveIndex == 2,
              routePath: "/profile",
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarItem extends StatefulWidget {
  const SideBarItem({
    super.key,
    this.isSelected = false,
    required this.icon,
    required this.label,
    required this.routePath,
  });
  final bool isSelected;
  final IconData icon;
  final String label;
  final String routePath;

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (event) => setState(() {
        _isHovered = false;
      }),
      onEnter: (event) => setState(() {
        _isHovered = true;
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: () {
            context.go(widget.routePath);
          },
          //whole icon button
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.avatarBg
                  : _isHovered
                  ? AppColors.primaryLight
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icon
                Icon(
                  widget.icon,
                  color: widget.isSelected
                      ? AppColors.primary
                      : _isHovered
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  size: 24,
                ),
                const SizedBox(height: 4),
                // Label
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: widget.isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight: widget.isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
