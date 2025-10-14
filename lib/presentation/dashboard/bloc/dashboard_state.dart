import 'package:equatable/equatable.dart';
import 'package:ev_flutter_app/presentation/component/app_bottom_nav_bar.dart';

class DashboardState extends Equatable {
  final BottomNavItem selectedItem;
  final bool canPopRoute;
  final String contentSession;
  final bool tabToggle;

  const DashboardState({
    this.selectedItem = BottomNavItem.home,
    this.canPopRoute = false,
    this.contentSession = '',
    this.tabToggle = false,
  });

  DashboardState copyWith({
    BottomNavItem? selectedItem,
    bool? canPopRoute,
    String? contentSession,
    bool? tabToggle,
  }) {
    return DashboardState(
      selectedItem: selectedItem ?? this.selectedItem,
      canPopRoute: canPopRoute ?? this.canPopRoute,
      contentSession: contentSession ?? this.contentSession,
      tabToggle: tabToggle ?? this.tabToggle,
    );
  }

  @override
  List<Object?> get props => [
        selectedItem,
        canPopRoute,
        contentSession,
        tabToggle,
      ];
}
