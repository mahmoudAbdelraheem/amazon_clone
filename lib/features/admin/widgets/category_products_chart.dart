import '../../../constants/global_variables.dart';
import '../models/sales.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> earings;
  const CategoryProductsChart({super.key, required this.earings});

  @override
  Widget build(BuildContext context) {
    var ordinalList = earings
        .map(
          (e) => OrdinalData(
            domain: e.lable,
            measure: e.earing,
          ),
        )
        .toList();
    final ordinalGroup = [
      OrdinalGroup(
        id: '1',
        data: ordinalList,
      ),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(25, 15, 20, 10),
      height: 300,
      child: DChartBarO(
        fillColor: (group, ordinalData, index) {
          return GlobalVariables.secondaryColor;
        },
        dashPattern: (group, ordinalData, index) {
          return List.generate(5, (index) => index);
        },
        barLabelValue: (group, ordinalData, index) {
          String measure = ordinalData.measure.toString();

          return measure;
        },
        barLabelDecorator: BarLabelDecorator(
          barLabelPosition: BarLabelPosition.auto,
          labelAnchor: BarLabelAnchor.end,
          labelPadding: 10,
        ),
        groupList: ordinalGroup,
      ),
    );
  }
}
