import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_event.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_state.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:bearnshare/presentation/split_dashboard/split_dash_board_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LedgerBookBloc>().add(const LoadBooks());
    });
  }

  String _formatRelativeTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) {
      return 'No entries yet';
    }

    try {
      final dateTime = DateTime.parse(dateTimeStr);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 30) {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _buildMetricsCard(),
                    const SizedBox(height: 20),
                    _buildSplitActivity(),
                    const SizedBox(height: 20),
                    _buildLedgerBooks(context),
                  ],
                ),
              ),
            ),
            onRefresh: () async {
              GetIt.I<LedgerBookBloc>().add(const LoadRecentBooks());
              GetIt.I<LedgerBookBloc>().add(const LoadDashboard());
              await Future.delayed(const Duration(milliseconds: 500));
            }),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          ),
          onTap: () {
            context.go(SplitDashboardRouter.splitHomeRoute);
          },
        ),
        const SizedBox(width: 12),
        Text(
          "Back to your split",
          style: AppTheme.ledgerTitleTextStyle,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.homePageCardBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.notifications, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildMetricsCard() {
    return BlocBuilder<LedgerBookBloc, LedgerBookState>(
        builder: (context, state) {
      return GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.homePageCardBgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BearNShare Metrics',
                    style: AppTheme.homePageTitleTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252538),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        const Icon(Icons.info, size: 20, color: Colors.white60),
                  ),
                ],
              ),
              const Divider(
                color: AppTheme.splitBorderLineColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.info, color: Colors.white60, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    S.of(context).overall_expenses,
                    style: AppTheme.homePageTitleTextStyle.copyWith(
                        fontSize: 12, color: AppTheme.homePageSubtitleColor),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹${state.dashboardData?.totalExpense ?? 0}',
                    style: AppTheme.homePageContentHeaderTextStyle,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomPaint(
                      size: const Size(double.infinity, 60),
                      painter: ChartPainter(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricBox(
                        '₹${state.dashboardData?.totalSavings ?? 0}',
                        S.of(context).total_savings),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricBox(
                        '₹${state.dashboardData?.thisMonthSavings ?? 0}',
                        S.of(context).this_month),
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: () {
          context.pushNamed(MainRouter.totalSavingRoute);
        },
      );
    });
  }

  Widget _buildMetricBox(String amount, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            amount,
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.homePageTitleTextStyle
                .copyWith(fontSize: 12, color: AppTheme.homePageSubtitleColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitActivity() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).split_activity,
              style: AppTheme.homePageContentHeaderTextStyle
                  .copyWith(fontSize: 16),
            ),
            Text(
              S.of(context).view_all,
              style: AppTheme.homePageTitleTextStyle.copyWith(
                  fontSize: 14, color: AppTheme.homePageSubtitleColor),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.splitBorderLineColor, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      S.of(context).you_get,
                      style: AppTheme.homePageTitleTextStyle.copyWith(
                          fontSize: 14, color: AppTheme.homePageSubtitleColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹2,500',
                      style: AppTheme.homePageContentAmntTextStyle
                          .copyWith(color: AppTheme.amountPosTextColor),
                    ),
                  ],
                ),
              ),
              Container(
                child: Assets.icons.splitDollarIcon.svg(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      S.of(context).you_give,
                      style: AppTheme.homePageTitleTextStyle.copyWith(
                          fontSize: 14, color: AppTheme.homePageSubtitleColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹2,500',
                      style: AppTheme.homePageContentAmntTextStyle
                          .copyWith(color: AppTheme.amountNegTextColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLedgerBooks(BuildContext context) {
    return BlocBuilder<LedgerBookBloc, LedgerBookState>(
        builder: (context, state) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).ledger_books,
                style: AppTheme.homePageContentHeaderTextStyle
                    .copyWith(fontSize: 16),
              ),
              GestureDetector(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.amountPosTextColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 18, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        S.of(context).s_add,
                        style: AppTheme.homePageTitleTextStyle.copyWith(
                            fontSize: 12,
                            color: AppTheme.homePageAppBarTitleColor),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  context.pushNamed(MainRouter.addBookRoute);
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.homePageCardBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: state.recentBooks
                    .map((book) => _buildLedgerItem(
                          icon: Icons.book,
                          title: book.name,
                          subtitle: _formatRelativeTime(book.lastEntryDateTime),
                          amount: '₹${book.totalIncome ?? 0}',
                          isOwed: true,
                        ))
                    .toList(),
              )),
          const SizedBox(height: 15),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.homePageCardBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                S.of(context).view_all,
                style: AppTheme.homePageTitleTextStyle.copyWith(
                    fontSize: 14, color: AppTheme.homePageAppBarTitleColor),
              ),
            ),
            onTap: () {
              context
                  .read<DashboardBloc>()
                  .add(const DashboardTabChanged(BottomNavItem.ledger));
              context.go(DashboardRouter.ledgerRoute);
            },
          )
        ],
      );
    });
  }

  Widget _buildLedgerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required bool isOwed,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF252538),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white70),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.homePageContentHeaderTextStyle
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTheme.homePageTitleTextStyle
                          .copyWith(color: AppTheme.genderInfoTextColor),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Income",
                    style: AppTheme.homePageTitleTextStyle
                        .copyWith(color: AppTheme.homePageAppBarTitleColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amount,
                    style: AppTheme.homePageContentAmntTextStyle
                        .copyWith(color: AppTheme.amountPosTextColor),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: AppTheme.splitBorderLineColor,
          ),
        ],
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00C853)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final points = [0.6, 0.3, 0.5, 0.2, 0.4, 0.6, 0.3, 0.5, 0.4, 0.2];

    path.moveTo(0, size.height * points[0]);

    for (int i = 1; i < points.length; i++) {
      final x = (size.width / (points.length - 1)) * i;
      final y = size.height * points[i];
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
