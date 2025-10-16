import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';
import 'package:bearnshare/presentation/split_dashboard/bloc/split_dashboard_event.dart';
import 'package:bearnshare/presentation/split_dashboard/bloc/split_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplitDashboardBloc
    extends BaseBloc<SplitDashboardEvent, SplitDashboardState> {
  SplitDashboardBloc() : super(const SplitDashboardState()) {
    on<SplitDashboardInitProfile>(_dashboardInitProfile);
    on<SplitDashboardTabChanged>(_onTabChanged);
    on<SplitDashboardBackPressed>(_onBackPressed);
    on<SplitUpdateContentSession>(_updateContentSession);
    on<SplitDashboardTabToggle>(_dashboardTabToggle);
  }

  Future<void> _dashboardInitProfile(SplitDashboardInitProfile event,
      Emitter<SplitDashboardState> emit) async {}

  void _onTabChanged(
    SplitDashboardTabChanged event,
    Emitter<SplitDashboardState> emit,
  ) {
    emit(
      state.copyWith(
        selectedItem: event.tab,
      ),
    );
  }

  void _onBackPressed(
    SplitDashboardBackPressed event,
    Emitter<SplitDashboardState> emit,
  ) {
    if (state.selectedItem != SplitBottomNavItem.home) {
      add(
        const SplitDashboardTabChanged(
          SplitBottomNavItem.home,
        ),
      );
    }
  }

  void _updateContentSession(
    SplitUpdateContentSession event,
    Emitter<SplitDashboardState> emit,
  ) {
    emit(
      state.copyWith(
        contentSession: event.contentSession,
      ),
    );
  }

  void _dashboardTabToggle(
    SplitDashboardTabToggle event,
    Emitter<SplitDashboardState> emit,
  ) {
    emit(
      state.copyWith(
        tabToggle: !state.tabToggle,
      ),
    );
  }
}
