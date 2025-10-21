import 'package:bearnshare/app/helpers/app_utils.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_progress_indicator.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_bloc.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_event.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<LedgerHistoryBloc>().add(const LoadHistoryEntries());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<LedgerHistoryBloc>().add(const LoadHistoryMoreEntries());
    }
  }

  Future<void> _onRefresh() async {
    context
        .read<LedgerHistoryBloc>()
        .add(const LoadHistoryEntries(isRefresh: true));
    await Future.delayed(const Duration(milliseconds: 500));
  }

  String _formatTime(String dateTimeStr) {
    final createdAt = DateTime.tryParse(dateTimeStr);
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
    return formattedDate;
  }

  String _formatDate(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return DateFormat('EEEE').format(dateTime);
      } else {
        return DateFormat('MMM dd, yyyy').format(dateTime);
      }
    } catch (e) {
      return '';
    }
  }

  Map<String, List<dynamic>> _groupEntriesByDate(List entries) {
    final Map<String, List<dynamic>> grouped = {};
    for (var entry in entries) {
      final date = _formatDate(entry.dateTime);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(entry);
    }
    return grouped;
  }

  double _calculateDayTotal(List entries) {
    double total = 0;
    for (var entry in entries) {
      if (entry.type == 'INCOME') {
        total += entry.amount;
      } else {
        total -= entry.amount;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: BlocBuilder<LedgerHistoryBloc, LedgerHistoryState>(
                builder: (context, state) {
                  if (state.status == LedgerHistoryStatus.loading &&
                      state.entries.isEmpty) {
                    return const Center(child: AppProgressIndicator());
                  }

                  return _buildHistoryList(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          Text(
            'History',
            style: AppTheme.ledgerTitleTextStyle,
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
        hint: 'Search by name, amount',
        debounceDuration: const Duration(milliseconds: 1000),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white54,
          size: 22,
        ),
        onChanged: (query) {
          context
              .read<LedgerHistoryBloc>()
              .add(SearchHistoryEntriesChanged(query));
        },
        onTapOutside: (v) {
          AppUtils.hideKeyboard();
        },
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 30,
            color: AppTheme.searchTextColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No entries found',
            style: AppTheme.homePageContentHeaderTextStyle
                .copyWith(color: AppTheme.searchTextColor, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(LedgerHistoryState state) {
    final groupedEntries = _groupEntriesByDate(state.entries);
    final dates = groupedEntries.keys.toList();
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: state.entries.isNotEmpty
          ? ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: dates.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= dates.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final date = dates[index];
                final entries = groupedEntries[date]!;

                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: entries.length,
                      itemBuilder: (context, entryIndex) {
                        final entry = entries[entryIndex];
                        return _buildTransactionItem(
                          icon: entry.type == 'INCOME'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          iconBg: entry.type == 'INCOME'
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFFFEBEE),
                          iconColor: entry.type == 'INCOME'
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFFF5252),
                          title: entry.title,
                          time: _formatTime(entry.dateTime),
                          amount: entry.amount,
                          isIncome: entry.type == 'INCOME',
                        );
                      },
                    ),
                    if (index < dates.length - 1) const SizedBox(height: 10),
                  ],
                );
              },
            )
          : ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: _buildEmptyState(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    required double amount,
    required bool isIncome,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.tabDividerColor, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.homePageContentHeaderTextStyle
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTheme.homePageTitleTextStyle
                      .copyWith(color: AppTheme.genderInfoTextColor),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}₹${amount.toStringAsFixed(2)}',
            style: AppTheme.homePageContentHeaderTextStyle.copyWith(
                fontSize: 16,
                color: isIncome
                    ? AppTheme.amountPosTextColor
                    : AppTheme.addExpenseBtnClr),
          ),
        ],
      ),
    );
  }
}
