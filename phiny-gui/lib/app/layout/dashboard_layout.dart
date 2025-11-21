import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/app_provider.dart';
import 'package:phiny_gui/components/custom_title_bar.dart';
import 'package:phiny_gui/components/sidebar.dart';
import 'package:phiny_gui/features/call/presentation/views/incoming_call_page.dart';

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
    final peerNode = ref.watch(callManagerAdoptorProvider);

    ref.listen(incomingCallDecisionProvider, (prev, next) {
      final incoming = next;
      if (incoming.completer != null) {
        print("Incoming call");
        final callerName =
            ref.read(incomingCallDecisionProvider.notifier).getTargetName() ??
            "";
        print("Caller name: $callerName");
        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: IncomingCallPage(
              targetName: callerName,
              targetNodeId: "",
              onAcceptCall: () {
                ref
                    .read(incomingCallDecisionProvider.notifier)
                    .acceptIncomingCall();
                Navigator.pop(context);

                context.go(
                  "/calling?nodeId=${Uri.encodeComponent("")}&name=${Uri.encodeComponent(ref.read(incomingCallDecisionProvider.notifier).getTargetName() ?? "")}",
                );
              },
              onEndCall: () {
                ref
                    .read(incomingCallDecisionProvider.notifier)
                    .rejectIncomingCall();
                Navigator.pop(context);
              },
            ),
          ),
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
