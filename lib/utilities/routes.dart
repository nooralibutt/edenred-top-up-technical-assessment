import 'package:flutter/material.dart';
import 'package:mobile_top_up/screen/add_beneficiary/add_beneficiary_screen.dart';
import 'package:mobile_top_up/screen/home/top_up_home_screen.dart';
import 'package:mobile_top_up/screen/top_up/top_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  TopUpHomeScreen.routeName: (_) => const TopUpHomeScreen(),
  AddBeneficiaryScreen.routeName: (_) => const AddBeneficiaryScreen(),
  TopUpScreen.routeName: (_) => const TopUpScreen(),
};
