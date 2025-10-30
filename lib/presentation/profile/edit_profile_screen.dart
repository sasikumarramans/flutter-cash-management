import 'dart:io';
import 'dart:ui';

import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_ios_message_dialog.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_event.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  ProfileBloc? _profileBloc;
  @override
  void initState() {
    super.initState();
    _profileBloc = context.read<ProfileBloc>();
    _profileBloc?.add(const InitProfile());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userNameController.text = _profileBloc?.state.userDataObject?.firstName;
      _emailController.text = _profileBloc?.state.userDataObject?.email ?? "";
      _addressController.text =
          _profileBloc?.state.userDataObject?.address ?? "";
      _companyNameController.text =
          _profileBloc?.state.userDataObject?.companyName ?? "";
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          builder: (context, state) {
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
                        _buildHeader(),
                        const SizedBox(height: 20),
                        _buildProfileAvatar(state),
                        const SizedBox(height: 20),
                        _buildUserNameField(),
                        const SizedBox(height: 15),
                        _buildEmailField(),
                        const SizedBox(height: 15),
                        _buildCompanyNameField(),
                        const SizedBox(height: 15),
                        _buildAddressField(),
                        const SizedBox(height: 40),
                        _buildContinueButton(state),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (BuildContext context, ProfileState state) {
            if (state.updateProfileStatus ==
                UpdateProfileStatus.userProfileSuccess) {
              context.pop();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(5),
                child:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 22),
              ),
              onTap: () {
                context.pop();
              },
            ),
            const SizedBox(width: 15),
            Text(
              "Edit profile",
              style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileAvatar(ProfileState state) {
    return Center(
      child: GestureDetector(
        child: SizedBox(
          height: 130,
          width: 130,
          child: Stack(
            children: [
              if (state.profileImageFile!.isNullOrEmpty &&
                  state.userDataObject!.profileImageUrl.isNullOrEmpty)
                Container(
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
                )
              else if (state.profileImageFile!.isNotEmpty)
                CircleAvatar(
                  radius: 80.0,
                  backgroundImage:
                      Image.file(File(state.profileImageFile!)).image,
                  backgroundColor: Colors.transparent,
                )
              else
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl: state.userDataObject!.profileImageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
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
                  ),
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.splitGroupColor,
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 10, right: 0),
                  child: Assets.icons.editIcon.svg(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          showReferenceDialog();
        },
      ),
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

  Widget _buildUserNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Full Name",
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '',
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
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.name,
          hint: S().usename_hint,
          onChanged: (value) {
            context.read<ProfileBloc>().add(
                  FullNameChanged(value),
                );
          },
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Colors.white60,
            size: 22,
          ),
          onValidation: (isValid) {},
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCompanyNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Company/Organization",
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _companyNameController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.name,
          hint: "Enter company/organization",
          onChanged: (value) {
            context.read<ProfileBloc>().add(
                  CompanyNameChanged(value),
                );
          },
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Colors.white60,
            size: 22,
          ),
          onValidation: (isValid) {},
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Address",
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _addressController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.name,
          hint: "Enter address",
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Colors.white60,
            size: 22,
          ),
          onChanged: (value) {
            context.read<ProfileBloc>().add(
                  AddressChanged(value),
                );
          },
          onValidation: (isValid) {},
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
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
      buttonState:
          state.isEmailEnabled ? ButtonState.enabled : ButtonState.disabled,
      onPressed: (_) {
        _profileBloc?.add(const ProfileUpdate(isUpdate: true));
      },
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }
}
