import 'package:casha/cubits/simple_calc/simple_calc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCalcView extends StatelessWidget {
  final TextEditingController costController = TextEditingController(text: '25.50');
  final TextEditingController tenderController = TextEditingController(text: '50');

  void _calculateChange(BuildContext context) {
    BlocProvider.of<SimpleCalcCubit>(context).calculateWithMod(
      double.tryParse(costController.text),
      double.tryParse(tenderController.text),
    );
  }

  void _clear(BuildContext context) {
    BlocProvider.of<SimpleCalcCubit>(context).clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: () => _clear(context))],
      ),
      body: BlocBuilder<SimpleCalcCubit, SimpleCalcState>(
        builder: (context, state) {
          if (state is SimpleCalcCalculated) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text('Product Cost:')),
                                Expanded(child: TextField(controller: costController)),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(child: Text('Tender Amount:')),
                                Expanded(child: TextField(controller: tenderController)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: state.breakdown.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(child: Text('See simple_calc_cubit.dart TODO')),
                      ),
                    ),
                    Offstage(
                      offstage: state.breakdown.isEmpty,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total change R${state.totalChange}', style: TextStyle(fontWeight: FontWeight.bold)),
                              ListView(
                                shrinkWrap: true,
                                children: state.breakdown.entries.map((entry) => Text('R${entry.key} x ${entry.value}')).toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    ElevatedButton(
                      onPressed: () => _calculateChange(context),
                      child: Text('Calculate change'),
                    )
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
