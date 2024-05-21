import '../../../common/widgets/loader.dart';
import '../models/sales.dart';
import '../services/admin_services.dart';
import '../widgets/category_products_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServicesImp adminServices = AdminServicesImp();
  int? totalSales;
  List<Sales>? earings;
  getEaring() async {
    var data = await adminServices.getAnalytics(context);
    totalSales = data['totalEaring'];
    earings = data['sales'];
    setState(() {});
  }

  @override
  void initState() {
    getEaring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return totalSales == null || earings == null
        ? const Loader()
        : Column(
            children: [
              CategoryProductsChart(
                earings: earings!,
              ),
              Container(
                height: 50,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Total Earing = \$$totalSales',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
  }
}
