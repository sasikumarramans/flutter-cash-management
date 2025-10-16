import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';
import 'package:equatable/equatable.dart';

class SplitDashboardState extends Equatable {
  final SplitBottomNavItem selectedItem;
  final bool canPopRoute;
  final String contentSession;
  final bool tabToggle;

  const SplitDashboardState({
    this.selectedItem = SplitBottomNavItem.home,
    this.canPopRoute = false,
    this.contentSession = '',
    this.tabToggle = false,
  });

  SplitDashboardState copyWith({
    SplitBottomNavItem? selectedItem,
    bool? canPopRoute,
    String? contentSession,
    bool? tabToggle,
  }) {
    return SplitDashboardState(
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
