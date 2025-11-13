import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phiny_gui/app/app_router.dart';
import 'package:phiny_gui/app/theme/app_color.dart';
import 'package:phiny_gui/app/theme/app_size.dart';
import 'package:phiny_gui/components/custom_title_bar.dart';
import 'package:phiny_gui/features/profile/presentation/viewmodels/profile_setup_viewmodel.dart';

class ProfileSetupPage extends ConsumerWidget {
  ProfileSetupPage({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelState = ref.watch(profileSetupViewModelProvider);
    final viewModelNotifier = ref.watch(profileSetupViewModelProvider.notifier);

    // If display name is set redirect to the dialpad
    if (viewModelState.displayName != null) {
      AppRouter.redirect(context, "/dialpad");
      return CircularProgressIndicator.adaptive();
    }

    return Scaffold(
      appBar: CustomTitleBar(),
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(AppSize.paddingXLarge),
          constraints: const BoxConstraints(maxWidth: AppSize.maxContentWidth),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSize.radiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Set up your profile',
                style: TextStyle(
                  fontSize: AppSize.fontLarge,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSize.paddingSmall),
              const Text(
                'Choose a display name and avatar to get started.',
                style: TextStyle(
                  fontSize: AppSize.fontMedium,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSize.paddingLarge),
              const Text(
                'Display Name',
                style: TextStyle(
                  fontSize: AppSize.fontSmall,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSize.paddingSmall),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.radiusMedium),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSize.paddingMedium,
                    vertical: AppSize.paddingMedium,
                  ),
                ),
              ),
              if (viewModelState.errorMsg != null) ...[
                Text(
                  viewModelState.errorMsg!,
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: AppSize.fontSmall,
                  ),
                ),
              ],
              const SizedBox(height: AppSize.paddingLarge),
              ElevatedButton(
                onPressed: () async {
                  if (viewModelState.isLoading) {
                    return;
                  }
                  // current display name
                  final displayName = _nameController.text;
                  await viewModelNotifier.setDisplayName(displayName);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSize.buttonVertical,
                    horizontal: AppSize.buttonHorizontal,
                  ),
                  elevation: 0,
                  backgroundColor: viewModelState.isLoading
                      ? AppColors.primaryLight
                      : AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.radiusSmall),
                  ),
                ),
                child: viewModelState.isLoading
                    ? CircularProgressIndicator.adaptive()
                    : const Center(child: Text("Continue")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
