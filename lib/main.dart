import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_top_up/screen/home/top_up_home_screen.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager_provider.dart';
import 'package:mobile_top_up/services/top_up_service/i_top_up_service.dart';
import 'package:mobile_top_up/services/top_up_service/top_up_mock_service.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';
import 'package:mobile_top_up/utilities/routes.dart';

void main() {
  // Mock or real services can be injected here
  final ITopUpService service = TopUpMockService();

  runApp(
    TopUpManagerProvider(
      topUpManager: TopUpManager(topUpService: service),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Top Up',
      routes: routes,
      theme: AppTheme.buildTheme(),
      initialRoute: TopUpHomeScreen.routeName,
      builder: EasyLoading.init(),
    );
  }
}
