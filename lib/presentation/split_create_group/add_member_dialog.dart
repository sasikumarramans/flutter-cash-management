import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/component/profile_avatar.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_bloc.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_event.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final TextEditingController _searchController = TextEditingController();
  late final CreateGroupBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<CreateGroupBloc>();
    _searchController.text =
        GetIt.I.get<CreateGroupBloc>().state.searchQuery ?? "";
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupBloc, CreateGroupState>(
      bloc: _bloc,
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: AppTheme.homePageCardBgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(context),
              _buildSearchBar(),
              if (state.selectedUsers.isNotEmpty) _buildSelectedUsers(state),
              SizedBox(
                height: state.selectedUsers.isEmpty ? 10 : 0,
              ),
              _buildSearchResults(state),
              _buildSubmitButton(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            'Add Members',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 16),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AppTextField(
        controller: _searchController,
        textFieldStyle: TextFieldStyle.filled,
        textFieldState: TextFieldState.enabled,
        textFieldType: TextFieldType.text,
        onChanged: (value) {
          _bloc.add(SearchUsers(_searchController.text));
        },
        hint: 'Enter name, email, or phone',
        debounceDuration: const Duration(milliseconds: 1000),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white54,
          size: 22,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  Widget _buildSelectedUsers(CreateGroupState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.selectedUsers.map((user) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A4A),
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
                      style:
                          AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(CreateGroupState state) {
    if (state.searchStatus == SearchStatus.loading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(color: AppTheme.amountPosTextColor),
        ),
      );
    }

    if (state.searchResults.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Search for users to add to the group',
            style: AppTheme.ledgerTitleTextStyle.copyWith(
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
        ),
      );
    }

    if (state.searchResults.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No users found',
            style: AppTheme.ledgerTitleTextStyle.copyWith(
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.searchResults.length,
        itemBuilder: (context, index) {
          final user = state.searchResults[index];
          final isSelected = state.selectedUsers.any((u) => u.id == user.id);

          return InkWell(
            onTap: () {
              if (!isSelected) {
                _bloc.add(AddSelectedUser(user));
              }
            },
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      ProfileAvatar(
                        profilePicture: user.profileImageUrl,
                        name: user.username,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: AppTheme.ledgerTitleTextStyle
                                  .copyWith(fontSize: 14),
                            ),
                            if (user.firstName.isNotEmpty ||
                                user.lastName.isNotEmpty)
                              Text(
                                '${user.firstName} ${user.lastName}'.trim(),
                                style: AppTheme.ledgerTitleTextStyle.copyWith(
                                  fontSize: 12,
                                  color: Colors.white54,
                                ),
                              ),
                          ],
                        ),
                      ),
                      isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: AppTheme.amountPosTextColor,
                              size: 24,
                            )
                          : const Icon(
                              Icons.circle_outlined,
                              color: AppTheme.splitBorderLineColor,
                              size: 24,
                            ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.5,
                  color: AppTheme.splitBorderLineColor,
                  indent: 5,
                  endIndent: 5,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, CreateGroupState state) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: bottomPadding > 0 ? bottomPadding : 20.0,
      ),
      child: AppButton(
        textString: 'Add Members',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState: state.selectedUsers.isNotEmpty
            ? ButtonState.enabled
            : ButtonState.disabled,
        onPressed: (_) {
          context.pop();
        },
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.splitGroupColor,
          borderRadius: BorderRadius.circular(30),
        ),
        enabledTextStyle: AppTheme.loginText.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
