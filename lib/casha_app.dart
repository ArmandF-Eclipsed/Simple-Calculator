import 'package:casha/cubits/simple_calc/simple_calc_cubit.dart';
import 'package:casha/ui/simple_calc_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<SimpleCalcCubit>(
        create: (context) => SimpleCalcCubit(),
        child: SimpleCalcView(),
      ),
    );
  }
}
