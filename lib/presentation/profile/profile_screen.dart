import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/generated/assets.gen.dart';
import 'package:ev_flutter_app/presentation/component/app_button.dart';
import 'package:flutter/material.dart';

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
                _buildProfileCard(),
                const SizedBox(height: 20),
                Text(
                  'Settings & Account',
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppTheme.homePageCardBgColor,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              'Profile',
              style: AppTheme.ledgerTitleTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.amountPosTextColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Edit Profile',
              style: AppTheme.profileTextStyle.copyWith(color: Colors.white),
            ),
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
            title: 'Account Settings',
            subtitle: 'Name, Email, Password',
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.lanIcon.svg(),
            title: 'Currency & Language',
            subtitle: 'Currently: ₹ (INR)',
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.notificationIcon.svg(),
            title: 'Notifications',
            subtitle: 'Push notifications & alerts',
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.exportIcon.svg(),
            title: 'Export Data',
            subtitle: 'Download reports & data',
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Assets.icons.faqIcon.svg(),
            title: 'FAQs & Support',
            subtitle: 'Get help & answers',
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
        textString: "Logout",
        leadingIcon: const Icon(Icons.logout, color: Colors.white, size: 22),
        onPressed: (value) {},
        buttonState: ButtonState.enabled,
        expandButton: true,
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.addExpenseBtnClr,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledTextStyle: AppTheme.loginText.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ));
  }
}
