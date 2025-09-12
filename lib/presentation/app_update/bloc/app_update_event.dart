import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AppUpdateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckForUpdate extends AppUpdateEvent {}

class PerformUpdate extends AppUpdateEvent {
  final BuildContext context;

  PerformUpdate(this.context);

  @override
  List<Object?> get props => [context];
}

class PerForceUpdate extends AppUpdateEvent {
  final BuildContext context;

  PerForceUpdate(this.context);

  @override
  List<Object?> get props => [context];
}
