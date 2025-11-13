import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/app_router.dart';
import 'package:phiny_gui/app/theme/app_color.dart';
import 'package:phiny_gui/app/theme/app_size.dart';
import 'package:phiny_gui/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends ConsumerWidget {
  final IconData avatarIcon;

  const ProfilePage({super.key, this.avatarIcon = Icons.person_2_outlined});

  void _showQRCode(BuildContext context, String nodeAddress) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.radiusLarge),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSize.paddingLarge),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share Node ID',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              SizedBox(
                width: 220,
                height: 220,
                child: QrImageView(data: nodeAddress),
              ),
              const SizedBox(height: AppSize.paddingMedium),
              Container(
                padding: const EdgeInsets.all(AppSize.paddingMedium),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppSize.radiusMedium),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  nodeAddress,
                  style: const TextStyle(
                    fontSize: AppSize.fontSmall,
                    color: AppColors.textSecondary,
                    fontFamily: 'monospace',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSize.radiusMedium,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppSize.fontMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.paddingMedium),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSize.radiusMedium,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppSize.fontMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelState = ref.watch(profileViewModelProvider);
    final viewModelNotifier = ref.watch(profileViewModelProvider.notifier);

    ref.listen<ProfileViewModelState>(profileViewModelProvider, (
      previous,
      next,
    ) {
      if (next.successMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMsg!),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 2),
          ),
        );
      }

      if (next.errorMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMsg!),
            backgroundColor: AppColors.error,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return SingleChildScrollView(
            padding: EdgeInsets.all(
              isWide ? AppSize.paddingXLarge : AppSize.paddingMedium,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: AppSize.fontLarge,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSize.paddingLarge),

                    // Profile Card
                    Container(
                      padding: const EdgeInsets.all(AppSize.paddingLarge),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          AppSize.radiusLarge,
                        ),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 36,
                                backgroundColor: AppColors.avatarBg,
                                child: Icon(
                                  avatarIcon,
                                  color: AppColors.avatarIcon,
                                  size: 36,
                                ),
                              ),
                              const SizedBox(width: AppSize.paddingMedium),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      viewModelState.displayName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.success.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          AppSize.radiusSmall,
                                        ),
                                      ),
                                      child: const Text(
                                        'Active',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.success,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => context.push("/editprofile"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.radiusMedium,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSize.paddingLarge),

                    // Node ID Section
                    Container(
                      padding: const EdgeInsets.all(AppSize.paddingLarge),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          AppSize.radiusLarge,
                        ),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.key,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              SizedBox(width: AppSize.paddingSmall),
                              Text(
                                'Node ID',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.paddingSmall),
                          const Text(
                            'Your unique identifier on the network',
                            style: TextStyle(
                              fontSize: AppSize.fontSmall,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppSize.paddingMedium),
                          Container(
                            padding: const EdgeInsets.all(
                              AppSize.paddingMedium,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(
                                AppSize.radiusMedium,
                              ),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: SelectableText(
                              viewModelState.nodeAddress,
                              style: const TextStyle(
                                fontSize: AppSize.fontSmall,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSize.paddingMedium),
                          Wrap(
                            spacing: AppSize.paddingSmall,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await viewModelNotifier.copyNodeId();
                                },
                                icon: const Icon(Icons.copy, size: 18),
                                label: const Text('Copy ID'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.radiusMedium,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => _showQRCode(
                                  context,
                                  viewModelState.nodeAddress,
                                ),
                                icon: const Icon(Icons.qr_code_2, size: 18),
                                label: const Text('Show QR'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.radiusMedium,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSize.paddingLarge),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          await viewModelNotifier.logout();
                          AppRouter.redirect(context, "/");
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: AppColors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSize.radiusMedium,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: AppSize.fontMedium,
                            fontWeight: FontWeight.w600,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
