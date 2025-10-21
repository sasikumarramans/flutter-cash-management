import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/component/profile_avatar.dart';
import 'package:bearnshare/presentation/split_create_group/add_member_dialog.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_bloc.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_event.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplitCreateGroupScreen extends StatefulWidget {
  const SplitCreateGroupScreen({super.key});

  @override
  State<SplitCreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<SplitCreateGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  late final CreateGroupBloc _bloc;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Travel', 'icon': Icons.flight},
    {'name': 'Home', 'icon': Icons.home},
    {'name': 'Friends', 'icon': Icons.group},
    {'name': 'Office', 'icon': Icons.work},
    {'name': 'Others', 'icon': Icons.more_horiz},
  ];

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<CreateGroupBloc>();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<CreateGroupBloc, CreateGroupState>(
            builder: (context, state) {
          return Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGroupPhoto(),
                      const SizedBox(height: 10),
                      _buildGroupNameField(),
                      const SizedBox(height: 10),
                      _buildCategorySection(),
                      const SizedBox(height: 10),
                      _buildAddMembersSection(state),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              _buildCreateButton(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            'Create a group',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupPhoto() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=300&h=300&fit=crop',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    // Handle photo change
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppTheme.splitGroupColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryBackgroundColor,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Tap to change group photo',
            style: AppTheme.ledgerTitleTextStyle
                .copyWith(fontSize: 12, color: AppTheme.homePageSubtitleColor),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Group Name',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _groupNameController,
          textFieldStyle: TextFieldStyle.outlined,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          textStyle: AppTheme.historyTextStyle.copyWith(fontSize: 15),
          onChanged: (value) {
            _bloc.add(GroupNameChanged(value));
          },
          onValidation: (isValid) {
            _bloc.add(GroupNameValidationCompleted(isValid));
          },
          outlinedEnabledStyle: InputDecoration(
            hintText: 'Enter group name (e.g., Trip to Goa)',
            hintStyle: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 15,
              color: AppTheme.homePageSubtitleColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.splitGroupColor),
            ),
            filled: true,
            fillColor: AppTheme.primaryColor,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            return _buildCategoryButton(
              category['name'],
              category['icon'],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String name, IconData icon) {
    return BlocBuilder<CreateGroupBloc, CreateGroupState>(
      builder: (context, state) {
        final isSelected = state.category == name;
        return GestureDetector(
          onTap: () {
            _bloc.add(CategoryChanged(name));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color:
                  isSelected ? AppTheme.splitGroupColor : AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppTheme.splitGroupColor
                    : AppTheme.splitBorderLineColor,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                  name,
                  style: AppTheme.ledgerSearchTextStyle
                      .copyWith(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateButton() {
    return BlocBuilder<CreateGroupBloc, CreateGroupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: AppButton(
            textString: 'Create Group',
            buttonType: ButtonType.filled,
            expandButton: true,
            buttonState:
                state.isGroupNameEnabled && state.selectedUsers.isNotEmpty
                    ? ButtonState.enabled
                    : ButtonState.disabled,
            onPressed: (_) {
              _bloc.add(const CreateGroup());
            },
            enabledButtonFilledStyle: BoxDecoration(
              color: AppTheme.splitGroupColor,
              borderRadius: BorderRadius.circular(30),
            ),
            enabledTextStyle: AppTheme.loginText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          ),
        );
      },
    );
  }

  void showBottomDialog(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddMemberDialog(),
    );
  }

  Widget _buildMoreCountChip(int additionalCount) {
    return GestureDetector(
      onTap: () => showBottomDialog(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.homePageCardBgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            '+$additionalCount',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberChip(user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: ProfileAvatar(
              profilePicture: user.profileImageUrl,
              name: user.username,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            user.username,
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _bloc.add(RemoveSelectedUser(user.id)),
            child: const Icon(
              Icons.close,
              color: Colors.white70,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMembersSection(CreateGroupState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Members',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        state.selectedUsers.isEmpty
            ? GestureDetector(
                onTap: () {
                  showBottomDialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.splitBorderLineColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Enter name, email, or phone',
                        style: AppTheme.homePageTitleTextStyle.copyWith(
                          fontSize: 15,
                          color: AppTheme.homePageSubtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Show first 2 members
                  ...state.selectedUsers
                      .take(2)
                      .map((member) => _buildMemberChip(member)),
                  // Show +X chip if there are more than 2 members
                  state.selectedUsers.length > 2
                      ? _buildMoreCountChip(state.selectedUsers.length - 2)
                      : _buildAddMoreButton(),
                ],
              ),
      ],
    );
  }

  Widget _buildAddMoreButton() {
    return GestureDetector(
      onTap: () => showBottomDialog(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.splitGroupColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              'Add More',
              style: AppTheme.ledgerTitleTextStyle.copyWith(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
