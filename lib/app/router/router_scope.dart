import 'package:flutter/material.dart';

class RouterScope extends StatefulWidget {
  final Widget child;
  final Function() inject;
  final Function() dispose;

  const RouterScope({
    required super.key,
    required this.child,
    required this.inject,
    required this.dispose,
  });

  @override
  State<RouterScope> createState() => _RouterScopeState();
}

class _RouterScopeState extends State<RouterScope> {
  @override
  void initState() {
    widget.inject();
    super.initState();
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(_) {
    return widget.child;
  }
}
