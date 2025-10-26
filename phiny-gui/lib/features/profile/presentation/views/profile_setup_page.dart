import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phiny_gui/app/theme/app_color.dart';
import 'package:phiny_gui/app/theme/app_size.dart';
import 'package:phiny_gui/components/custom_title_bar.dart';

class ProfileSetupPage extends StatelessWidget {
  ProfileSetupPage({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: AppSize.paddingLarge),
              ElevatedButton(
                onPressed: () {
                  context.go("/dialpad");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSize.buttonVertical,
                    horizontal: AppSize.buttonHorizontal,
                  ),
                  elevation: 0,
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.radiusSmall),
                  ),
                ),
                child: const Center(child: Text("Next")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
