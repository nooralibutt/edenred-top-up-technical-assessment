import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';
import 'package:mobile_top_up/screen/add_beneficiary/add_beneficiary_screen.dart';
import 'package:mobile_top_up/screen/top_up/top_up_screen.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager_provider.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';
import 'package:mobile_top_up/widgets/gradient_button.dart';

class RechargeTab extends StatefulWidget {
  const RechargeTab({super.key});

  @override
  State<RechargeTab> createState() => _RechargeTabState();
}

class _RechargeTabState extends State<RechargeTab> {
  @override
  Widget build(BuildContext context) {
    final topUpManager = TopUpManagerProvider.of(context);

    return FutureBuilder(
      future: topUpManager.getBeneficiaries(),
      builder: (BuildContext context,
          AsyncSnapshot<List<BeneficiaryModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final beneficiaries = snapshot.data;
        if (beneficiaries == null) {
          return const Center(child: Text('Error Fetching beneficiaries'));
        }

        if (beneficiaries.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const Gap(30),
                const Text('No beneficiaries so far.'),
                const Gap(30),
                buildAddBeneficiary(),
              ],
            ),
          );
        }

        return Column(
          children: [
            SizedBox(height: 150, child: BeneficiaryListView(beneficiaries)),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: buildAddBeneficiary(),
            ),
          ],
        );
      },
    );
  }

  Widget buildAddBeneficiary() {
    return GradientButton(
        text: 'Add Beneficiary',
        onTap: () async {
          await Navigator.of(context).pushNamed(AddBeneficiaryScreen.routeName);
          setState(() {});
        });
  }
}

class BeneficiaryListView extends StatelessWidget {
  final List<BeneficiaryModel> beneficiaries;
  const BeneficiaryListView(this.beneficiaries, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: beneficiaries.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext context, int index) {
          final beneficiary = beneficiaries[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: context.mqWidth * 0.39,
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    beneficiary.nickname,
                    textAlign: TextAlign.center,
                    style: context.titleMedium!.bold
                        .copyWith(color: AppTheme.purpleAccentColor),
                  ),
                ),
                const Gap(10),
                Text(
                  beneficiary.phoneNumber,
                  style:
                      context.labelMedium!.copyWith(color: AppTheme.lightBlack),
                ),
                const Gap(10),
                GradientButton(
                    onTap: () {
                      Navigator.pushNamed(context, TopUpScreen.routeName,
                          arguments: beneficiary);
                    },
                    text: 'Recharge Now'),
              ],
            ),
          );
        });
  }
}
