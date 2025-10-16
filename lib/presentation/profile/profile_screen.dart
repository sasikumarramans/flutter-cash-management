import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildProfileCard(context),
                const SizedBox(height: 20),
                Text(
                  S().settings_account,
                  style: AppTheme.profileTextStyle,
                ),
                const SizedBox(height: 8),
                _buildSettingsCard(),
                const SizedBox(height: 24),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppTheme.homePageCardBgColor,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),*/

            const SizedBox(width: 5),
            Text(
              'Profile',
              style: AppTheme.ledgerTitleTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'RK',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alex Johnson',
                  style:
                      AppTheme.profileTextStyle.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'TechFlow Solutions',
                  style: AppTheme.profileTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.splitGroupColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Edit Profile',
                style: AppTheme.profileTextStyle.copyWith(color: Colors.white),
              ),
            ),
            onTap: () {
              context.pushNamed(MainRouter.editProfileRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildSettingItem(
            icon: Assets.icons.accountIcon.svg(),
            title: S().account_settings,
            subtitle: 'Name, Email',
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.lanIcon.svg(),
            title: S().currency_language,
            subtitle: 'Currently: ₹ (INR)',
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.notificationIcon.svg(),
            title: S().notifications,
            subtitle: S().push_notifications_alert,
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.exportIcon.svg(),
            title: S().export_data,
            subtitle: S().download_reports,
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.faqIcon.svg(),
            title: S().s_faq,
            subtitle: S().get_help_answer,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required Widget icon,
    required String title,
    required String subtitle,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: icon,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.profileTextStyle
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTheme.historyTextStyle
                      .copyWith(color: AppTheme.profileTitleTextStyle),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppTheme.profileTitleTextStyle,
            size: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 1,
        color: AppTheme.splitBorderLineColor,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return AppButton(
        buttonType: ButtonType.filled,
        textString: S().s_logout,
        leadingIcon: const Icon(Icons.logout, color: Colors.white, size: 22),
        onPressed: (value) {},
        buttonState: ButtonState.enabled,
        expandButton: true,
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.addExpenseBtnClr,
          borderRadius: BorderRadius.circular(30),
        ),
        enabledTextStyle: AppTheme.loginText.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ));
  }
}
