import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/cache_manager/profile_cached_image_shimmer.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_event.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_state.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const GetProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          print("userDataObject");
          print(state.userDataObject);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildProfileCard(context, state),
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
          );
        }),
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

  Widget _buildProfileCard(BuildContext context, ProfileState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(left: 0),
            decoration: const BoxDecoration(
              color: AppTheme.medicalDisclaimerDiverColor,
              shape: BoxShape.circle,
            ),
            child: Container(
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(
                    width: 1,
                    color: AppTheme.profileBorderColor,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(5),
              child: ClipOval(
                child: ProfileCachedImageShimmer(
                  imageUrl: state.userDataObject?.profileImageUrl,
                  width: 100,
                  height: 100,
                  name: state.userDataObject?.username,
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
                  state.userDataObject?.username ?? "",
                  style:
                      AppTheme.profileTextStyle.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  state.userDataObject?.email ?? "",
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
                style: AppTheme.profileTextStyle
                    .copyWith(color: Colors.white, fontSize: 12),
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
