import 'dart:io';
import 'dart:ui';

import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_ios_message_dialog.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/component/lower_case_text_formatter.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_event.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      40,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(state),
                      const SizedBox(height: 40),
                      _buildProfileAvatar(state),
                      const SizedBox(height: 40),
                      _buildUserNameField(state),
                      const SizedBox(height: 24),
                      _buildEmailField(state),
                      const Spacer(),
                      _buildContinueButton(state),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              S.of(context).set_up_your_profile,
              style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          S().set_up_your_profile_hint,
          style: AppTheme.promptTextStyle
              .copyWith(fontSize: 13, color: AppTheme.genderInfoTextColor),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar(ProfileState state) {
    return Center(
      child: GestureDetector(
        child: Stack(
          children: [
            state.profileImageFile != null
                ? CircleAvatar(
                    radius: 65.0,
                    backgroundImage:
                        Image.file(File(state.profileImageFile!)).image,
                    backgroundColor: Colors.transparent,
                  )
                : Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: AppTheme.homePageCardBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white38,
                    ),
                  ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.amountPosTextColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF1A1A1A),
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      state.profileImageFile != null
                          ? Icons.camera_alt
                          : Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          showReferenceDialog();
        },
      ),
    );
  }

  Widget _buildUserNameField(ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: S().user_name,
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _userNameController,
          inputFormatters: [
            LowercaseTextFormatter(),
            FilteringTextInputFormatter.allow(
              RegExp(r'[a-z0-9_.,]'),
            ),
          ],
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.name,
          hint: S().usename_hint,
          maxLength: 30,
          onChanged: (value) {
            context.read<ProfileBloc>().add(
                  UserNameEvent(value),
                );
          },
          showMaxLengthIndicator: false,
          debounceDuration: const Duration(milliseconds: 1000),
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Colors.white60,
            size: 22,
          ),
          suffixIcon: state.userNameUniqueApiStatus ==
                  UserNameUniqueApiStatus.fetchingData
              ? IconButton(
                  onPressed: () {},
                  iconSize: 20.0,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ))
              : null,
          onValidation: (isValid) =>
              context.read<ProfileBloc>().add(UserNameCompleted(isValid)),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        if (state.uniqueUserNameStatus == UniqueUserNameStatus.error ||
            state.uniqueUserNameStatus == UniqueUserNameStatus.alreadyPresent ||
            state.uniqueUserNameStatus == UniqueUserNameStatus.success)
          const SizedBox(
            height: 7,
          ),
        if (state.uniqueUserNameStatus == UniqueUserNameStatus.error ||
            state.uniqueUserNameStatus == UniqueUserNameStatus.alreadyPresent ||
            state.uniqueUserNameStatus == UniqueUserNameStatus.success)
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 0, left: 20, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.uniqueUserNameStatus == UniqueUserNameStatus.success
                    ? Assets.icons.usernameSuccess.svg()
                    : state.uniqueUserNameStatus == UniqueUserNameStatus.error
                        ? Assets.icons.usernameError.svg()
                        : Assets.icons.usernameAlreadyTaken.svg(),
                Flexible(
                    child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    state.userNameTooltipMessage,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTheme.userNameText.copyWith(
                        fontSize: 12,
                        color: state.uniqueUserNameStatus ==
                                UniqueUserNameStatus.success
                            ? Colors.green
                            : state.uniqueUserNameStatus ==
                                    UniqueUserNameStatus.error
                                ? Colors.red
                                : const Color(0xffFFD60A)),
                  ),
                ))
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEmailField(ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: S().email_address,
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _emailController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.email,
          hint: S().email_hint,
          onChanged: (value) {
            context.read<ProfileBloc>().add(
                  EmailIdChanged(value),
                );
          },
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.white60,
            size: 22,
          ),
          onValidation: (isValid) => context
              .read<ProfileBloc>()
              .add(EmailIdCompleted(isValid: isValid)),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(ProfileState state) {
    return AppButton(
      textString: S().s_continue,
      buttonType: ButtonType.filled,
      expandButton: true,
      enabledButtonFilledStyle: BoxDecoration(
        color: const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(30),
      ),
      enabledTextStyle: AppTheme.loginText.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      buttonState: state.isUserNameEnabled && state.isEmailEnabled
          ? ButtonState.enabled
          : ButtonState.disabled,
      onPressed: (_) {
        context.read<ProfileBloc>().add(const ProfileUpdate());
      },
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }

  void showReferenceDialog() async {
    final profileBloc = GetIt.I.get<ProfileBloc>();
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Navigator.of(context).pop(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AppIosMessageDialog(
                title: S.of(context).choose_media,
                subtitle: S.of(context).choose_media_hint,
                titleTextStyle: AppTheme.simpleWhiteTextStyle
                    .copyWith(fontSize: 14, color: Colors.white),
                subtitleTextStyle: AppTheme.simpleWhiteTextStyle
                    .copyWith(fontSize: 12, color: const Color(0x99EBEBF5)),
                showDivider: false,
                backgroundColor: const Color(0xff1C1C1E),
                actions: [
                  TextButton(
                    onPressed: () {
                      profileBloc.add(const AddProfilePhoto(
                        mediaPicker: MediaPicker.files,
                      ));
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Assets.icons.files.svg(),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).files,
                            style: AppTheme.simpleWhiteTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      profileBloc.add(const AddProfilePhoto(
                        mediaPicker: MediaPicker.camera,
                      ));
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Assets.icons.camera.svg(),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).camera,
                            style: AppTheme.simpleWhiteTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      profileBloc.add(const AddProfilePhoto(
                        mediaPicker: MediaPicker.gallery,
                      ));
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Assets.icons.gallery.svg(),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            S.of(context).gallery,
                            style: AppTheme.simpleWhiteTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                showCancel: true,
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation =
            CurvedAnimation(parent: animation, curve: Curves.easeOut);
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
