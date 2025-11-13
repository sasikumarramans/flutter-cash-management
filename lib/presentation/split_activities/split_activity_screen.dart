import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/activity/model/get_activities_response.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:bearnshare/presentation/split_activities/bloc/split_activity_bloc.dart';
import 'package:bearnshare/presentation/split_activities/bloc/split_activity_event.dart';
import 'package:bearnshare/presentation/split_activities/bloc/split_activity_state.dart';
import 'package:bearnshare/presentation/split_home/add_member_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplitActivityScreen extends StatefulWidget {
  const SplitActivityScreen({super.key});

  @override
  State<SplitActivityScreen> createState() => _SplitActivityScreenState();
}

class _SplitActivityScreenState extends State<SplitActivityScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final SplitActivityBloc _bloc;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<SplitActivityBloc>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    BackButtonInterceptor.add(myInterceptor);
    _bloc.add(const LoadActivities());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _bloc.add(const LoadMoreActivities());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SplitActivityBloc, SplitActivityState>(
          bloc: _bloc,
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(),
                _buildFilterTabs(state),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: _buildActivitiesList(state),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: AppButton(
          textString: 'Add Expense',
          buttonType: ButtonType.filled,
          buttonState: ButtonState.completed,
          leadingIcon: const Icon(Icons.add, color: Colors.white, size: 20),
          completedButtonFilledStyle: BoxDecoration(
            color: AppTheme.splitGroupColor,
            borderRadius: BorderRadius.circular(30),
          ),
          completedTextStyle: AppTheme.bottomBarText.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          onPressed: (_) {
            AddExpenseMembersSheet.showAddExpenseMembersDialog(context);
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Text(
            'Activity',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 20),
          ),
          const Spacer(),
          GestureDetector(
            child: Assets.icons.graph.svg(color: Colors.white),
            onTap: () {
              context.pushNamed(MainRouter.splitReportSummaryRoute);
            },
          ),
          const SizedBox(width: 16),
          GestureDetector(
            child: Assets.icons.group.svg(color: Colors.white),
            onTap: () {
              context.pushNamed(MainRouter.splitCreateGroupRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(SplitActivityState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton('All', 0, state),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton('Paid', 1, state),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton('To Pay', 2, state),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index, SplitActivityState state) {
    final isSelected = state.selectedFilterIndex == index;
    return AppButton(
      textString: label,
      buttonType: ButtonType.filled,
      buttonState: isSelected ? ButtonState.completed : ButtonState.enabled,
      expandButton: true,
      enabledButtonFilledStyle: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      completedButtonFilledStyle: BoxDecoration(
        color: AppTheme.splitGroupColor,
        borderRadius: BorderRadius.circular(10),
      ),
      enabledTextStyle: AppTheme.bottomBarText.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      completedTextStyle: AppTheme.bottomBarText.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      onPressed: (_) {
        _bloc.add(FilterActivitiesChanged(index));
      },
    );
  }

  Widget _buildActivitiesList(SplitActivityState state) {
    if (state.status == SplitActivityStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.splitGroupColor,
        ),
      );
    }

    if (state.status == SplitActivityStatus.failed) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load activities',
              style: AppTheme.ledgerTitleTextStyle,
            ),
            const SizedBox(height: 16),
            AppButton(
              textString: 'Retry',
              buttonType: ButtonType.filled,
              buttonState: ButtonState.completed,
              completedButtonFilledStyle: BoxDecoration(
                color: AppTheme.splitGroupColor,
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: (_) {
                _bloc.add(const LoadActivities());
              },
            ),
          ],
        ),
      );
    }

    if (state.filteredActivities.isEmpty) {
      return Center(
        child: Text(
          'No activities found',
          style: AppTheme.ledgerTitleTextStyle,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _bloc.add(const LoadActivities(isRefresh: true));
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: AppTheme.splitGroupColor,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: state.filteredActivities.length + 1,
        itemBuilder: (context, index) {
          if (index == state.filteredActivities.length) {
            return state.isLoadingMore
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.splitGroupColor,
                      ),
                    ),
                  )
                : const SizedBox(height: 100);
          }

          final activity = state.filteredActivities[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildActivityItem(activity: activity),
          );
        },
      ),
    );
  }

  Widget _buildActivityItem({required ActivityItem activity}) {
    // Determine icon based on activity type
    IconData icon = Icons.info_outline;
    Color iconBg = const Color(0xFFE3F2FD);
    Color iconColor = const Color(0xFF2196F3);

    String label;
    double amount;
    Color amountColor;

    if (activity.context.overallReceivingAmount > 0) {
      label = "You Receive";
      amount = activity.context.overallReceivingAmount;
      amountColor = const Color(0xFF4CAF50);
    } else if (activity.context.overallPayingAmount > 0) {
      label = 'You Pay';
      amount = activity.context.overallPayingAmount;
      amountColor = const Color(0xFFFF5252);
    } else {
      label = 'Settled';
      amount = 0;
      amountColor = Colors.white54;
    }

    final activityType = activity.activityType.toLowerCase();
    if (activityType.contains('group')) {
      icon = Icons.group;
      iconBg = const Color(0xFFF3E5F5);
      iconColor = const Color(0xFF9C27B0);
    } else if (activityType.contains('expense') ||
        activityType.contains('added')) {
      icon = Icons.receipt;
      iconBg = const Color(0xFFFFEBEE);
      iconColor = const Color(0xFFE53935);
    } else if (activityType.contains('paid') ||
        activityType.contains('settled')) {
      icon = Icons.check_circle;
      iconBg = const Color(0xFFE8F5E9);
      iconColor = const Color(0xFF4CAF50);
    } else if (activityType.contains('member')) {
      icon = Icons.person_add;
      iconBg = const Color(0xFFFFF3E0);
      iconColor = const Color(0xFFFF9800);
    }

    // Format time
    final timestamp = DateTime.tryParse(activity.timestamp);
    String timeAgo = 'Unknown';
    if (timestamp != null) {
      final difference = DateTime.now().difference(timestamp);
      if (difference.inDays > 0) {
        timeAgo =
            '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        timeAgo =
            '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        timeAgo =
            '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        timeAgo = 'Just now';
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        activity.message,
                        style: AppTheme.ledgerTitleTextStyle
                            .copyWith(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (activity.context.amount != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            label,
                            style: AppTheme.ledgerSearchTextStyle
                                .copyWith(color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "INR $amount",
                            style:
                                AppTheme.homePageContentAmntTextStyle.copyWith(
                              fontSize: 14,
                              color: amountColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (activity.context.groupName != null)
                      Text(
                        "${activity.context.groupName!}. ",
                        style: AppTheme.ledgerSearchTextStyle,
                      ),
                    Text(
                      timeAgo,
                      style: AppTheme.ledgerSearchTextStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
