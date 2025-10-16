import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.all(13),
        margin: const EdgeInsets.only(bottom: 80),
        width: 130,
        decoration: BoxDecoration(
            color: AppTheme.homePageCardBgColor,
            borderRadius: BorderRadius.circular(35),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppTheme.amountPosTextColor, Color(0xff007652)])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.splitWiseIcon.svg(),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Splitwise",
              style: AppTheme.homePageTitleTextStyle,
            )
          ],
        ),
      ),
      body: SafeArea(
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
                _buildLedgerBooks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            text: 'Welcome, ',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 18),
            children: [
              TextSpan(
                text: 'David!',
                style: AppTheme.homePageContentHeaderTextStyle
                    .copyWith(fontSize: 18, color: AppTheme.amountPosTextColor),
              ),
            ],
          ),
        ),
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
    return Container(
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
                'KashSave Metrics',
                style: AppTheme.homePageTitleTextStyle,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF252538),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.info, size: 20, color: Colors.white60),
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
                '₹3,500',
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
                child: _buildMetricBox('₹0', S.of(context).total_savings),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricBox('₹0', S.of(context).this_month),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBox(String amount, String label) {
    return GestureDetector(
      child: Container(
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
              style: AppTheme.homePageContentHeaderTextStyle
                  .copyWith(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.homePageTitleTextStyle.copyWith(
                  fontSize: 12, color: AppTheme.homePageSubtitleColor),
            ),
          ],
        ),
      ),
      onTap: () {
        context.pushNamed(MainRouter.totalSavingRoute);
      },
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

  Widget _buildLedgerBooks() {
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        fontSize: 12, color: AppTheme.homePageAppBarTitleColor),
                  ),
                ],
              ),
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
            children: [
              _buildLedgerItem(
                icon: Icons.home,
                title: 'Home Expenses',
                subtitle: '2 Hours ago',
                amount: '₹2,500',
                isOwed: false,
              ),
              const Divider(
                color: AppTheme.splitBorderLineColor,
              ),
              _buildLedgerItem(
                icon: Icons.business,
                title: 'House Rent',
                subtitle: '2 Hours ago',
                amount: '₹2,500',
                isOwed: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
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
        )
      ],
    );
  }

  Widget _buildLedgerItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required bool isOwed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
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
                isOwed ? S.of(context).you_give : S.of(context).you_get,
                style: AppTheme.homePageTitleTextStyle
                    .copyWith(color: AppTheme.homePageAppBarTitleColor),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: AppTheme.homePageContentAmntTextStyle,
              ),
            ],
          )
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
