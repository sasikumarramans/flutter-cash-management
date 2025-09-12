import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_flutter_app/app/router/animation/slide_transition_screen.dart';
import 'package:ev_flutter_app/app/router/router_scope.dart';
import 'package:ev_flutter_app/presentation/auth/otp/bloc/otp_bloc.dart';
import 'package:ev_flutter_app/presentation/auth/otp/otp_screen.dart';

class LoginRouter {
  static const String otpScreenRoute = 'otp';
  static const String otpScreenScope = 'otpScope';

  static List<RouteBase> routes() {
    const Key otpScreenKey = Key('otpScreenKey');

    return [
      GoRoute(
          path: otpScreenRoute,
          name: otpScreenRoute,
          pageBuilder: (context, state) {
            return SlideTransitionScreen<void>(
                child: RouterScope(
              key: otpScreenKey,
              inject: () {},
              dispose: () {},
              child: BlocProvider<OtpBloc>.value(
                value: GetIt.I<OtpBloc>(),
                child: const OtpScreen(),
              ),
            ));
          }),
    ];
  }
}
