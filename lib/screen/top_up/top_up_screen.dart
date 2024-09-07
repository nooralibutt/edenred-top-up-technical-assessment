import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';
import 'package:mobile_top_up/model/beneficiary_top_up_info.dart';
import 'package:mobile_top_up/screen/home/top_up_home_screen.dart';
import 'package:mobile_top_up/screen/top_up/components/top_up_body.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager_provider.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';

class TopUpScreen extends StatefulWidget {
  static const String routeName = '/TopUpScreen';

  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  @override
  Widget build(BuildContext context) {
    final beneficiary =
        ModalRoute.of(context)?.settings.arguments as BeneficiaryModel;
    final manager = TopUpManagerProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, TopUpHomeScreen.routeName);
          },
        ),
      ),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          DataTable(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppTheme.lightBlack),
              borderRadius: BorderRadius.circular(20),
            ),
            columns: const [
              DataColumn(
                label: Text(
                  'Nickname',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text(beneficiary.nickname)),
                  DataCell(Text(beneficiary.phoneNumber)),
                ],
              ),
            ],
          ),
          const Gap(20),
          FutureBuilder(
            future: manager.fetchTopUpInfo(beneficiary.phoneNumber),
            builder: (BuildContext context,
                AsyncSnapshot<BeneficiaryTopUpInfo> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final model = snapshot.data;
              if (model == null) {
                return const Center(
                    child:
                        Text('Error Fetching Top Up Beneficiary Information'));
              }

              return TopUpBody(model, beneficiary);
            },
          ),
        ],
      )),
    );
  }
}
