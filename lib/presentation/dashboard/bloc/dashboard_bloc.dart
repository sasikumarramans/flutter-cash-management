import 'package:ev_flutter_app/app/bloc/base/base_bloc.dart';
import 'package:ev_flutter_app/presentation/component/app_bottom_nav_bar.dart';
import 'package:ev_flutter_app/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:ev_flutter_app/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends BaseBloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardInitProfile>(_dashboardInitProfile);
    on<DashboardTabChanged>(_onTabChanged);
    on<DashboardBackPressed>(_onBackPressed);
    on<UpdateContentSession>(_updateContentSession);
    on<DashboardTabToggle>(_dashboardTabToggle);
  }

  Future<void> _dashboardInitProfile(
      DashboardInitProfile event, Emitter<DashboardState> emit) async {}

  void _onTabChanged(
    DashboardTabChanged event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.copyWith(
        selectedItem: event.tab,
      ),
    );
  }

  void _onBackPressed(
    DashboardBackPressed event,
    Emitter<DashboardState> emit,
  ) {
    if (state.selectedItem != BottomNavItem.home) {
      add(
        const DashboardTabChanged(
          BottomNavItem.home,
        ),
      );
    }
  }

  void _updateContentSession(
    UpdateContentSession event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.copyWith(
        contentSession: event.contentSession,
      ),
    );
  }

  void _dashboardTabToggle(
    DashboardTabToggle event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.copyWith(
        tabToggle: !state.tabToggle,
      ),
    );
  }
}
