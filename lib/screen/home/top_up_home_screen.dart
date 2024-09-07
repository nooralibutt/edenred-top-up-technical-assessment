import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_top_up/screen/home/history/history_tab.dart';
import 'package:mobile_top_up/screen/home/recharge/recharge_tab.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';
import 'package:mobile_top_up/utilities/enums.dart';

class TopUpHomeScreen extends StatefulWidget {
  static const String routeName = '/TopUpHomeScreen';

  const TopUpHomeScreen({super.key});

  @override
  State<TopUpHomeScreen> createState() => _TopUpHomeScreenState();
}

class _TopUpHomeScreenState extends State<TopUpHomeScreen> {
  TopUpTabType _selectedTab = TopUpTabType.recharge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 10,
        title: const Text('Mobile Recharge'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(10),
            _buildTabControl(),
            const Gap(20),
            Flexible(child: _selectedTabList()),
          ],
        ),
      ),
    );
  }

  Widget _selectedTabList() {
    if (_selectedTab == TopUpTabType.recharge) {
      return const RechargeTab();
    }

    return const HistoryTab();
  }

  Widget _buildTabControl() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.lightGreyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabButton(TopUpTabType.recharge),
          _buildTabButton(TopUpTabType.history),
        ],
      ),
    );
  }

  Widget _buildTabButton(TopUpTabType tab) {
    bool isSelected = _selectedTab == tab;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (tab == TopUpTabType.recharge) {
              _selectedTab = TopUpTabType.recharge;
            } else {
              _selectedTab = TopUpTabType.history;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.whiteColor : AppTheme.transparentColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Text(
            tab.name.capitalize,
            style: context.titleMedium!.bold.copyWith(
              color:
                  isSelected ? AppTheme.purpleAccentColor : AppTheme.lightBlack,
            ),
          ),
        ),
      ),
    );
  }
}
