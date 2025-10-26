import 'package:flutter/material.dart';
import 'package:phiny_gui/components/custom_title_bar.dart';
import 'package:phiny_gui/components/sidebar.dart';

class DashBoardLayout extends StatelessWidget {
  const DashBoardLayout({
    super.key,
    required this.currentPage,
    required this.currentActiveIndex,
  });
  final Widget currentPage;
  final int currentActiveIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTitleBar(),
      body: SizedBox.expand(
        child: Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 100),
              child: Sidebar(currentActiveIndex: currentActiveIndex),
            ),
            Expanded(flex: 4, child: currentPage),
          ],
        ),
      ),
    );
  }
}
