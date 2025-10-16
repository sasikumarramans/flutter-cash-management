import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';
import 'package:equatable/equatable.dart';

sealed class SplitDashboardEvent extends Equatable {
  const SplitDashboardEvent();

  @override
  List<Object?> get props => [];
}

class SplitDashboardInitProfile extends SplitDashboardEvent {}

class SplitDashboardTabChanged extends SplitDashboardEvent {
  final SplitBottomNavItem tab;

  const SplitDashboardTabChanged(this.tab);
}

class SplitDashboardTabToggle extends SplitDashboardEvent {
  const SplitDashboardTabToggle();
}

class SplitDashboardBackPressed extends SplitDashboardEvent {
  const SplitDashboardBackPressed();
}

class SplitDashboardRoutePopped extends SplitDashboardEvent {
  const SplitDashboardRoutePopped();
}

class SplitUpdateContentSession extends SplitDashboardEvent {
  final String? contentSession;

  const SplitUpdateContentSession(this.contentSession);
}
