import 'package:flutter/material.dart';
import 'package:phiny_gui/app/theme/app_color.dart';

class CallRecord {
  final String nodeId;
  final String type;
  final String time;

  CallRecord(this.nodeId, this.type, this.time);
}

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final calls = [
      CallRecord('node-12345-abc-def-ghi', 'Incoming', '5 min ago'),
      CallRecord('node-67890-jkl-mno-pqr', 'Outgoing', '10 min ago'),
      CallRecord('node-11223-stu-vwx-yza', 'Missed', '22 min ago'),
      CallRecord('node-44556-bcd-efg-hij', 'Outgoing', '1 hr ago'),
      CallRecord('node-77889-klm-nop-qrs', 'Incoming', '3 hrs ago'),
      CallRecord('node-99001-tuv-wxy-zab', 'Outgoing', 'Yesterday'),
      CallRecord('node-22334-cde-fgh-ijk', 'Missed', 'Yesterday'),
      CallRecord('node-55667-lmn-opq-rst', 'Incoming', '2 days ago'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(constraints.maxWidth > 800 ? 40 : 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Call History',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: calls.length,
                    itemBuilder: (context, index) {
                      return _buildCallItem(context, calls[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCallItem(BuildContext context, CallRecord call) {
    IconData icon;
    Color iconBg;
    Color iconColor;

    switch (call.type) {
      case 'Incoming':
        icon = Icons.call_received;
        iconBg = AppColors.primaryLight;
        iconColor = AppColors.primary;
        break;
      case 'Outgoing':
        icon = Icons.call_made;
        iconBg = AppColors.primaryLight;
        iconColor = AppColors.primary;
        break;
      case 'Missed':
        icon = Icons.phone_missed;
        iconBg = AppColors.redLight;
        iconColor = AppColors.red;
        break;
      default:
        icon = Icons.phone;
        iconBg = AppColors.primaryLight;
        iconColor = AppColors.primary;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call.nodeId,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontFamily: 'monospace',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${call.type} call',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            call.time,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
