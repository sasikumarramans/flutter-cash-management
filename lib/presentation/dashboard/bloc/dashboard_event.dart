import 'package:equatable/equatable.dart';
import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class DashboardInitProfile extends DashboardEvent {}

class DashboardTabChanged extends DashboardEvent {
  final BottomNavItem tab;

  const DashboardTabChanged(this.tab);
}

class DashboardTabToggle extends DashboardEvent {
  const DashboardTabToggle();
}

class DashboardBackPressed extends DashboardEvent {
  const DashboardBackPressed();
}

class DashboardRoutePopped extends DashboardEvent {
  const DashboardRoutePopped();
}

class UpdateContentSession extends DashboardEvent {
  final String? contentSession;

  const UpdateContentSession(this.contentSession);
}
