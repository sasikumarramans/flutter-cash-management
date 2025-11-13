import 'package:bearnshare/app/helpers/app_utils.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/component/profile_avatar.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_bloc.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_event.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AddExpenseMembersSheet extends StatefulWidget {
  const AddExpenseMembersSheet({super.key});

  @override
  State<AddExpenseMembersSheet> createState() => _AddExpenseMembersSheetState();

  static void showAddExpenseMembersDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddExpenseMembersSheet(),
    );
  }
}

class _AddExpenseMembersSheetState extends State<AddExpenseMembersSheet> {
  final TextEditingController _searchController = TextEditingController();
  late final SplitGroupBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<SplitGroupBloc>();
    _bloc.add(const SearchMembers(""));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _bloc.add(const ClearMemberSearch());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplitGroupBloc, SplitGroupState>(
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
              if (state.selectedMembers.isNotEmpty)
                _buildSelectedMembers(state),
              SizedBox(height: state.selectedMembers.isEmpty ? 10 : 0),
              Expanded(
                child: _buildContent(state),
              ),
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
            'Add Expense',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
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
        hint: 'Enter group name or friend name',
        textFieldStyle: TextFieldStyle.filled,
        textFieldState: TextFieldState.enabled,
        textFieldType: TextFieldType.text,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white54,
          size: 22,
        ),
        hintStyle: AppTheme.ledgerSearchTextStyle,
        textStyle: AppTheme.simpleWhiteTextStyle,
        debounceDuration: const Duration(milliseconds: 500),
        onChanged: (value) {
          _bloc.add(SearchMembers(_searchController.text));
        },
      ),
    );
  }

  Widget _buildSelectedMembers(SplitGroupState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.selectedMembers.map((member) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.splitGroupColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppTheme.splitGroupColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: ProfileAvatar(
                        profilePicture: '',
                        name: member.username,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      member.username,
                      style:
                          AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 13),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () =>
                          _bloc.add(RemoveMemberFromSelection(member.userId)),
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

  Widget _buildContent(SplitGroupState state) {
    if (state.searchStatus == SearchStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.splitGroupColor),
      );
    }
    if (state.searchFriends.isEmpty && state.searchGroups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: AppTheme.ledgerTitleTextStyle.copyWith(
                fontSize: 14,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.searchGroups.isNotEmpty) _buildGroupsSection(state),
          if (state.searchFriends.isNotEmpty) _buildFriendsSection(state),
        ],
      ),
    );
  }

  Widget _buildGroupsSection(SplitGroupState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Groups',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ...state.searchGroups.map((group) => _buildGroupItem(group)),
        ],
      ),
    );
  }

  Widget _buildGroupItem(group) {
    return InkWell(
      onTap: () {
        AppUtils.hideKeyboard();
        context.pushNamed(
          MainRouter.addExpenseRoute,
          extra: {
            "groupId": group.groupId,
            "members": group.participants,
          },
        );
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.splitGroupColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.group,
                    color: AppTheme.splitGroupColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.groupName,
                        style: AppTheme.homePageContentHeaderTextStyle
                            .copyWith(fontSize: 14),
                      ),
                      Text(
                        '${group.memberCount} members',
                        style: AppTheme.ledgerTitleTextStyle.copyWith(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(
              color: AppTheme.splitBorderLineColor,
              thickness: 0.2,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsSection(SplitGroupState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friends',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...state.searchFriends
              .map((friend) => _buildFriendItem(friend, state)),
        ],
      ),
    );
  }

  Widget _buildFriendItem(friend, SplitGroupState state) {
    final isSelected =
        state.selectedMembers.any((m) => m.userId == friend.userId);

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          _bloc.add(RemoveMemberFromSelection(friend.userId));
        } else {
          _bloc.add(AddMemberToSelection(friend));
        }
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                ProfileAvatar(
                  profilePicture: '',
                  name: friend.username,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend.username,
                        style: AppTheme.homePageContentHeaderTextStyle
                            .copyWith(fontSize: 16),
                      ),
                      if (friend.name.isNotEmpty)
                        Text(
                          friend.name,
                          style: AppTheme.ledgerTitleTextStyle.copyWith(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.splitGroupColor
                          : AppTheme.splitBorderLineColor,
                      width: 2,
                    ),
                    color: isSelected
                        ? AppTheme.splitGroupColor
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 0),
          const Divider(
            color: AppTheme.splitBorderLineColor,
            thickness: 0.2,
          )
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, SplitGroupState state) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 0,
        bottom: bottomPadding > 0 ? bottomPadding : 20,
      ),
      child: AppButton(
        textString: state.selectedMembers.isNotEmpty
            ? 'Submit (${state.selectedMembers.length})'
            : 'Submit',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState: state.selectedMembers.isNotEmpty
            ? ButtonState.enabled
            : ButtonState.disabled,
        onPressed: (_) {
          AppUtils.hideKeyboard();
          context.pushNamed(
            MainRouter.addExpenseRoute,
            extra: {
              "groupId": 0,
              "members": state.selectedMembers,
            },
          );
          Navigator.pop(context);
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
  }
}
