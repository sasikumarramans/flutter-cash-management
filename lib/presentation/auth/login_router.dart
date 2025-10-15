import 'package:bearnshare/app/router/animation/slide_transition_screen.dart';
import 'package:bearnshare/app/router/router_scope.dart';
import 'package:bearnshare/presentation/auth/otp/bloc/otp_bloc.dart';
import 'package:bearnshare/presentation/auth/otp/otp_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
