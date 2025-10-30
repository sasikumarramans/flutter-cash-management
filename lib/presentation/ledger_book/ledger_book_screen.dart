import 'dart:async';

import 'package:bearnshare/app/helpers/app_utils.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_event.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_state.dart';
import 'package:bearnshare/presentation/ledger_book/book_selection_dialog.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LedgerBookScreen extends StatefulWidget {
  const LedgerBookScreen({super.key});
  @override
  State<LedgerBookScreen> createState() => _LedgerBookScreenState();
}

class _LedgerBookScreenState extends State<LedgerBookScreen> {
  late final LedgerBookBloc _bloc;
  late final ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();
  late StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<LedgerBookBloc>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    var keyboardVisibilityController = KeyboardVisibilityController();

    _bloc.add(LoadEntries(
        bookId: GetIt.I.get<LedgerBookBloc>().state.selectedBookItem?.id ?? 0));
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!mounted) return;
      context.read<LedgerBookBloc>().add(KeyboardVisibilityChanged(visible));
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _bloc.add(const LoadMoreEntries());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: BlocConsumer<LedgerBookBloc, LedgerBookState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              _buildHeader(context, state),
              _buildSearchBar(),
              _buildSummaryCards(state),
              Expanded(
                child: _buildTransactionsList(state),
              ),
              if (!state.isKeyboardVisible) _buildActionButtons(context)
            ],
          );
        },
      ),
    ));
  }

  void showBottomDialog(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BookSelectionDialog(),
    );
  }

  void _handleEditEntry(entry) {
    print("handleEditEntry");
    context.pushNamed(
      MainRouter.addIncomeRoute,
      extra: {
        'bookId': entry.bookId,
        'entryType': entry.type,
        'entryId': entry.id,
        "entryItem": entry
      },
    );
  }

  void _handleDeleteEntry(entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.homePageCardBgColor,
        title: Text(
          'Delete Entry',
          style: AppTheme.ledgerTitleTextStyle
              .copyWith(color: AppTheme.addExpenseBtnClr),
        ),
        content: Text(
          'Are you sure you want to delete this entry?',
          style: AppTheme.homePageTitleTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Cancel',
              style: AppTheme.homePageTitleTextStyle.copyWith(
                color: AppTheme.genderInfoTextColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              GetIt.I<LedgerBookBloc>().add(LedgerDeleteEntry(entry.id));
              context.pop();
            },
            child: Text(
              'Delete',
              style: AppTheme.homePageTitleTextStyle.copyWith(
                color: AppTheme.addExpenseBtnClr,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LedgerBookState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          InkWell(
            child: Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  state.selectedBookItem?.name ?? "",
                  style: AppTheme.ledgerTitleTextStyle,
                ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_down,
                    color: Colors.white, size: 24),
              ],
            ),
            onTap: () {
              showBottomDialog(context);
            },
          ),
          const Spacer(),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.reportBtnColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Assets.icons.reportImg.svg(),
                  const SizedBox(width: 6),
                  Text(
                    S().s_report,
                    style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            onTap: () {
              context.pushNamed(MainRouter.reportRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: StatefulBuilder(
              builder: (context, setSearchState) {
                return AppTextField(
                  controller: _searchController,
                  textFieldStyle: TextFieldStyle.filled,
                  textFieldState: TextFieldState.enabled,
                  textFieldType: TextFieldType.text,
                  hint: 'Search transactions',
                  debounceDuration: const Duration(milliseconds: 1000),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white54,
                    size: 22,
                  ),
                  onChanged: (value) {
                    _bloc.add(SearchEntriesChanged(value));
                  },
                  onTapOutside: (v) {
                    AppUtils.hideKeyboard();
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Assets.icons.filterIcon.svg(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(LedgerBookState state) {
    final summary = state.selectedBookItem;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.homePageCardBgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildSummaryItem(
                S().total_entries,
                state.totalElements.toString() ?? '0',
                Colors.white,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppTheme.splitBorderLineColor,
            ),
            Expanded(
              child: _buildSummaryItem(
                S().total_cash_in,
                '₹ ${NumberFormat('#,##,###').format(summary?.totalIncome ?? 0)}',
                AppTheme.amountPosTextColor,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppTheme.splitBorderLineColor,
            ),
            Expanded(
              child: _buildSummaryItem(
                S().total_cash_out,
                '₹ ${NumberFormat('#,##,###').format(summary?.totalExpense ?? 0)}',
                AppTheme.addExpenseBtnClr,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: AppTheme.homePageTitleTextStyle.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.homePageContentHeaderTextStyle
              .copyWith(fontSize: 16, color: valueColor),
        ),
      ],
    );
  }

  Widget _buildTransactionsList(LedgerBookState state) {
    /*  if (state.status == LedgerBookStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.amountPosTextColor,
        ),
      );
    }
*/

    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(LoadEntries(
            bookId: GetIt.I.get<LedgerBookBloc>().state.selectedBookItem!.id,
            isRefresh: true));
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: AppTheme.amountPosTextColor,
      child: state.entries.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: Text(
                      'No transactions found',
                      style: AppTheme.ledgerTitleTextStyle.copyWith(
                        color: AppTheme.genderInfoTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.entries.length + 1,
              itemBuilder: (context, index) {
                if (index == state.entries.length) {
                  return state.isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.amountPosTextColor,
                            ),
                          ),
                        )
                      : const SizedBox(height: 80);
                }

                final entry = state.entries[index];
                return _buildTransactionCard(entry);
              },
            ),
    );
  }

  Widget _buildTransactionCard(EntryItem entry) {
    // Format date
    final createdAt = DateTime.tryParse(entry.dateTime!);
    String formattedDate = 'Unknown';
    if (createdAt != null) {
      final now = DateTime.now();
      final difference = now.difference(createdAt);

      if (difference.inDays == 0) {
        formattedDate = 'Today, ${DateFormat('h:mm a').format(createdAt)}';
      } else if (difference.inDays == 1) {
        formattedDate = 'Yesterday, ${DateFormat('h:mm a').format(createdAt)}';
      } else {
        formattedDate = DateFormat('MMM d, h:mm a').format(createdAt);
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: AppTheme.homePageContentHeaderTextStyle
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  formattedDate,
                  style: AppTheme.homePageTitleTextStyle
                      .copyWith(color: AppTheme.genderInfoTextColor),
                ),
              ],
            ),
          ),
          Text(
            '${entry.isIncome ? '+' : '-'}₹${NumberFormat('#,##,###').format(entry.amount)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: entry.isIncome
                  ? AppTheme.amountPosTextColor
                  : AppTheme.addExpenseBtnClr,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              _handleEditEntry(entry);
            },
            child: Assets.icons.editIcon.svg(),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              _handleDeleteEntry(entry);
            },
            child: Assets.icons.deleteIcon.svg(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
                buttonType: ButtonType.filled,
                textString: S().add_income,
                leadingIcon: const Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: (value) {
                  context.pushNamed(
                    MainRouter.addIncomeRoute,
                    extra: {
                      'bookId': GetIt.I
                          .get<LedgerBookBloc>()
                          .state
                          .selectedBookItem
                          ?.id,
                      'entryType': 'INCOME',
                    },
                  );
                },
                buttonState: ButtonState.enabled,
                expandButton: true,
                enabledButtonFilledStyle: BoxDecoration(
                  color: AppTheme.amountPosTextColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledTextStyle: AppTheme.loginText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
                buttonType: ButtonType.filled,
                textString: S().add_expense,
                leadingIcon: const Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: (value) {
                  context.pushNamed(
                    MainRouter.addIncomeRoute,
                    extra: {
                      'bookId': GetIt.I
                          .get<LedgerBookBloc>()
                          .state
                          .selectedBookItem
                          ?.id,
                      'entryType': 'EXPENSE',
                    },
                  );
                },
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
                )),
          ),
        ],
      ),
    );
  }
}
