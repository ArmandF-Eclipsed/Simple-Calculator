import 'package:casha/casha_app.dart';
import 'package:casha/cubits/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(CashaApp());
}
