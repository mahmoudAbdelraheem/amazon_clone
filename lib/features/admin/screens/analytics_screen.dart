import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
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
        : const Column();
  }
}
