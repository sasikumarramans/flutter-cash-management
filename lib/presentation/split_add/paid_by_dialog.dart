import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/profile_avatar.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_bloc.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'bloc/add_expense_split_event.dart';

class PaidByDialog extends StatefulWidget {
  const PaidByDialog({super.key});

  @override
  State<PaidByDialog> createState() => _PaidByDialogState();
}

class _PaidByDialogState extends State<PaidByDialog> {
  late final AddExpenseSplitBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<AddExpenseSplitBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseSplitBloc, AddExpenseSplitState>(
      bloc: _bloc,
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
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
              const SizedBox(height: 10),
              _buildUsersList(state),
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
            'Select Payer',
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

  Widget _buildUsersList(AddExpenseSplitState state) {
    if (state.participants.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'Add members first to select payer',
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
        itemCount: state.participants.length,
        itemBuilder: (context, index) {
          final participant = state.participants[index];
          final isSelected = state.paidBy?.id == participant.user.id;

          return InkWell(
            onTap: () {
              _bloc.add(PaidByChanged(participant.user));
              Navigator.pop(context);
            },
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      ProfileAvatar(
                        profilePicture: participant.user.profileImageUrl,
                        name: participant.user.username,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          participant.user.username,
                          style: AppTheme.ledgerTitleTextStyle
                              .copyWith(fontSize: 14),
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
}