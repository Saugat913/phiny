import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/app_provider.dart';
import 'package:phiny_gui/components/custom_title_bar.dart';
import 'package:phiny_gui/components/sidebar.dart';

class DashBoardLayout extends ConsumerWidget {
  const DashBoardLayout({
    super.key,
    required this.currentPage,
    required this.currentActiveIndex,
  });
  final Widget currentPage;
  final int currentActiveIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final peerNode = ref.watch(peerNodeProvider);
    ref.listen(incomingCallProvider, (prev, next) {
      final incoming = next;
      if (incoming != null) {
        print("Incoming call");
        context.push(
          "/calling?incoming=true&name=${Uri.encodeComponent(incoming.callerName)}",
        );
      }
    });

    return Scaffold(
      appBar: CustomTitleBar(),
      body: SizedBox.expand(
        child: peerNode.when(
          data: (node) {
            return Row(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  child: Sidebar(currentActiveIndex: currentActiveIndex),
                ),
                Expanded(flex: 4, child: currentPage),
              ],
            );
          },
          error: (error, stack) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
